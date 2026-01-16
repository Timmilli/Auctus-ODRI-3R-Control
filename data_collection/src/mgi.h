#pragma once

#include <Eigen/Dense>

using Eigen::Vector3d;

#define L2 0.160
#define L3 0.160
#define H1 0.150
#define H2 0.020
#define H3 0.020

/*
 * @brief Does a gradient descent once such as
 * q = q - J_pinv*F
 */
void gradient_descent(Vector3d &q, Vector3d &Xd);
