#ifndef __TRAJECTORY_GENERATOR_H__
#define __TRAJECTORY_GENERATOR_H__

#include <cstdio>
typedef struct {
  double p_haa;
  double p_hfe;
  double p_k;
} angular_point_t;

class Trajectory {
private:
  int _haa_min = -1;
  int _haa_max = 9;
  int _hfe_min = -10;
  int _hfe_max = 10;
  int _k_min = -10;
  int _k_max = 10;
  double _epsilon = 0.5;
  int _nb_points = 5;
  angular_point_t _traj[5]; // TODO replace with non-fixed array size

public:
  Trajectory();

  angular_point_t *getPoint(int index);
  int getNumberOfPoints();

  int hasReachedPoint(int index, angular_point_t current_position);

  void printTrajectory();
};

#endif // __TRAJECTORY_GENERATOR_H__
