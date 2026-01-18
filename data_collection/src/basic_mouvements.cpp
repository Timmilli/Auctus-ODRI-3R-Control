#include <fstream>
#include <math.h>

#include "basic_mouvements.h"
#include "csv_filler.h"

BasicMovement::BasicMovement() {
  _kp = 5.;
  _kd = 0.1;
  _iq_sat = 4.0;
  _freq = 0.5;
  _amplitude = M_PI;
}

BasicMovement::BasicMovement(double amplitude, double freq, double kp,
                             double kd, double iq_sat)
    : _amplitude(amplitude), _freq(freq), _kp(kp), _kd(kd), _iq_sat(iq_sat) {}

double BasicMovement::getCurrentFromTime(double init_pos, double elapsed_time,
                                         double motor_position,
                                         double motor_velocity) {
  double ref = init_pos + _amplitude * sin(2 * M_PI * _freq * elapsed_time);
  double v_ref =
      2. * M_PI * _freq * _amplitude * cos(2 * M_PI * _freq * elapsed_time);
  double p_err = ref - motor_position;
  double v_err = v_ref - motor_velocity;
  double cur = _kp * p_err + _kd * v_err;
  if (cur > _iq_sat)
    cur = _iq_sat;
  if (cur < -_iq_sat)
    cur = -_iq_sat;
  return cur;
}

double BasicMovement::getCurrentFromCons(double init_pos, int cons,
                                         double motor_position,
                                         double motor_velocity, CsvFiller &f,
                                         double t) {
  double ref = init_pos + cons;
  double v_ref = 0;
  double p_err = ref - motor_position;
  double v_err = v_ref - motor_velocity;
  double cur = _kp * p_err + _kd * v_err;
  if (cur > _iq_sat)
    cur = _iq_sat;
  if (cur < -_iq_sat)
    cur = -_iq_sat;
  f.writeData(t, p_err);
  return cur;
}
