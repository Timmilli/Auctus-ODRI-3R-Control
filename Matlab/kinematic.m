clear; close all; clc;
addpath("./tr_homogenes")
addpath("./kinematics")

syms l1 l2 l3 h1 h2 h3 real;
syms theta1 theta2 theta3 real;

Theta = [theta1 theta2 theta3];
L = [l1 l2 l3 h1 h2 h3];

J = getJacobian(Theta, L);

J_inv = simplify(inv(J))