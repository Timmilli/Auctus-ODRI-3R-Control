#include <Eigen/Dense>
#include <cmath>
#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>

#include "mgi.h"

using Eigen::Vector3d;

int main() {
  Vector3d abc(0.5, 0.5, 0.5);
  std::cout << J_pinv(abc) << std::endl;

  return 0;

  std::ifstream file("trajectory.csv");
  if (!file.is_open()) {
    std::cerr << "Failed to open CSV file\n";
    return 1;
  }

  std::vector<Eigen::Vector3d> points;
  std::string line;

  while (std::getline(file, line)) {
    std::stringstream ss(line);
    std::string value;

    Eigen::Vector3d vec;
    for (int i = 0; i < 3; ++i) {
      if (!std::getline(ss, value, ',')) {
        std::cerr << "Invalid row format\n";
        return 1;
      }
      vec(i) = std::stod(value);
    }

    points.push_back(vec);
  }

  file.close();

  Vector3d q(0.1, 0.1, 0.1);

  int max_iter = 1;

  // Example usage
  for (Vector3d &Xd : points) {
    std::cout << "\nConfiguration:\n" << q << std::endl;

    for (int i = 0; i < max_iter; i++) {
      gradient_descent(q, Xd);
    }
  }

  std::cout << "Most Final q:\n" << q << std::endl;

  return 0;
}
