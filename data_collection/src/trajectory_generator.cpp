#include "trajectory_generator.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>

Trajectory::Trajectory() {
  for (int i = 0; i < _nb_points; i++) {
    _traj[i].p_haa = _haa_min + rand() % (_haa_max - _haa_min);
    _traj[i].p_hfe = _hfe_min + rand() % (_hfe_max - _hfe_min);
    _traj[i].p_k = _k_min + rand() % (_k_max - _k_min);
  }
}

angular_point_t *Trajectory::getPoint(int index) { return &_traj[index]; }
int Trajectory::getNumberOfPoints() { return _nb_points; }

int Trajectory::hasReachedPoint(int index, angular_point_t current_position) {
  angular_point_t p = _traj[index];
  return (fabs(p.p_haa - current_position.p_haa) < _epsilon) &&
         (fabs(p.p_hfe - current_position.p_hfe) < _epsilon) &&
         (fabs(p.p_k - current_position.p_k) < _epsilon);
}

void Trajectory::printTrajectory() {
  for (int i = 0; i < _nb_points; i++) {
    printf("q%d=[%d,%d,%d]\n", i, _traj[i].p_haa, _traj[i].p_hfe, _traj[i].p_k);
  }
}
