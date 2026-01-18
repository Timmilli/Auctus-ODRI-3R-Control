#include "trajectory_generator.h"
#include <cstdlib>
#include <ctime>

int main() {
  srand(time(nullptr));

  Trajectory traj;

  traj.printTrajectory();
  return 0;
}
