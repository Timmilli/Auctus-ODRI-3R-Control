class BasicMovement {
private:
  double _amplitude;
  double _freq;
  double _kp;
  double _kd;
  double _iq_sat;

public:
  BasicMovement();
  BasicMovement(double amplitude, double freq, double kp, double kd,
                double iq_sat);
  double GetCurrent(double init_pos, double elapsed_time, double motor_position,
                    double motor_velocity);
};
