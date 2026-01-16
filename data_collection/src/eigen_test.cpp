#include <Eigen/Dense>
#include <cmath>
#include <iostream>

#include "mgi.h"

using Eigen::Vector3d;

int main() {
  int max_iter = 10;

  Vector3d Xd(0., 0.450, 0.);
  Vector3d q(0.1, 0.1, 0.1);

  std::cout << "Basic q:\n" << q << std::endl;

  for (int i = 0; i < max_iter; i++) {
    gradient_descent(q, Xd);
    std::cout << "middle q:\n" << q << std::endl;
  }
  std::cout << "Final q:\n" << q << std::endl;

  q = q * 360 / (120 * M_PI);

  std::cout << "Most Final q:\n" << q << std::endl;

  return 0;
}
