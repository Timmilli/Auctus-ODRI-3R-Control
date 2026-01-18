#include <assert.h>
#include <chrono>
#include <ctime>
#include <fstream>
#include <iostream>
#include <math.h>
#include <stdexcept>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

#include "basic_mouvements.h"
#include "csv_filler.h"
#include "master_board_sdk/defines.h"
#include "master_board_sdk/master_board_interface.h"
#include "motor_mapping.h"

#define N_SLAVES_CONTROLED 6
void print_point(angular_point_t *p, char type[3]) {
  printf("HAA_%s=%f, HFE_%s=%f, KNE_%s=%f\n", type, p->p_haa, type, p->p_hfe,
         type, p->p_k);
}

int main(int argc, char **argv) {
  if (argc != 2) {
    throw std::runtime_error("Please provide the interface name "
                             "(i.e. using 'ifconfig' on linux");
  }

  int cpt = 0;
  double freq = 0.5;
  double iq_sat = 4.0;
  double amplitude = M_PI;
  BasicMovement mvt(amplitude, freq, 25., 0.2, iq_sat);
  double cons = 0.05;
  double max_t = 3.;
  double dt = 0.001;
  double t = 0;
  double init_pos[N_SLAVES * 2] = {0};
  int state = 0;
  int error_counters[N_SLAVES] = {0};

  nice(-20); // give the process a high priority
  printf("-- Main --\n");
  MasterBoardInterface robot_if(argv[1]);
  robot_if.Init();
  // Initialisation, send the init commands
  for (int i = 0; i < N_SLAVES_CONTROLED; i++) {
    robot_if.motor_drivers[i].motor1->SetCurrentReference(0);
    robot_if.motor_drivers[i].motor2->SetCurrentReference(0);
    robot_if.motor_drivers[i].motor1->Enable();
    robot_if.motor_drivers[i].motor2->Enable();
    robot_if.motor_drivers[i].EnablePositionRolloverError();
    robot_if.motor_drivers[i].SetTimeout(5);
    robot_if.motor_drivers[i].Enable();
  }

  std::chrono::time_point<std::chrono::system_clock> last =
      std::chrono::system_clock::now();
  while (!robot_if.IsTimeout() && !robot_if.IsAckMsgReceived()) {
    if (((std::chrono::duration<double>)(std::chrono::system_clock::now() -
                                         last))
            .count() > dt) {
      last = std::chrono::system_clock::now();
      robot_if.SendInit();
    }
  }

  if (robot_if.IsTimeout()) {
    printf("Timeout while waiting for ack.\n");
  }

  CsvFiller csvfiller;
  csvfiller.openFile();

  while ((!robot_if.IsTimeout()) && (t < max_t)) {
    if (((std::chrono::duration<double>)(std::chrono::system_clock::now() -
                                         last))
            .count() > dt) {
      last = std::chrono::system_clock::now(); // last+dt would be better
      cpt++;
      t += dt;
      robot_if.ParseSensorData(); // This will read the last incomming packet
                                  // and update all sensor fields.
      switch (state) {
      case 0: // check the end of calibration (are the all controlled motor
              // enabled and ready?)
        state = 1;
        for (int i = 0; i < N_SLAVES_CONTROLED * 2; i++) {
          if (!robot_if.motor_drivers[i / 2].is_connected)
            continue; // ignoring the motors of a disconnected slave

          if (!(robot_if.motors[i].IsEnabled() &&
                robot_if.motors[i].IsReady())) {
            state = 0;
          }
          init_pos[i] = robot_if.motors[i].GetPosition(); // initial position
          t = 0;                                          // to start sin at 0
        }
        break;
      case 1:
        int i = BRHAA; // mapping in motor_mapping.h
        if ((t > 0.5) && (t < max_t)) {
          if (robot_if.motors[i].IsEnabled()) {
            double cur = mvt.getCurrentFromCons(
                init_pos[i], cons, robot_if.motors[i].GetPosition(),
                robot_if.motors[i].GetVelocity(), csvfiller, t);
            robot_if.motors[i].SetCurrentReference(cur);
          }
        }
        break;
      }

      // Check if an error happened and increase the counter.
      for (int i = 0; i < N_SLAVES; i++) {
        if (robot_if.motor_drivers[i].error_code != 0) {
          error_counters[i] += 1;
        }
      }

      if (cpt % 100 == 0) {
        printf("\33[H\33[2J"); // clear screen
        robot_if.PrintADC();
        robot_if.PrintMotors();
        robot_if.PrintMotorDrivers();

        printf("Motor driver errors: ");
        for (int i = 0; i < N_SLAVES; i++) {
          printf("%3d | ", error_counters[i]);
        }
        printf("\n\n");

        robot_if.PrintStats();

        printf("\n\n");
        printf("Current time: %f\n", t);
        printf("\n\n");

        fflush(stdout);
      }
      robot_if.SendCommand(); // This will send the command packet
    } else {
      std::this_thread::yield();
    }
  }
  if (t >= max_t) {
    char *filename = "filename";
    printf("Trajectory done. Data are in %s.\n", filename);
  } else {
    printf("Masterboard timeout detected. Either the masterboard has been shut "
           "down or there has been a connection issue with the cable/wifi.\n");
  }
  csvfiller.closeFile();
  return 0;
}
