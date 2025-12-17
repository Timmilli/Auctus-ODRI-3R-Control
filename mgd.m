clear; close all; clc;
addpath("./tr_homogenes")

% Using Denavit-Hartenberg convention (1955)
syms l1 l2 l3 h2 h3 theta1 theta2 theta3 alpha1 alpha3 real;
Pi=sym(pi);

R0T1  = th_rotz(theta1) * th_trans(0, 0, l1) * th_rotx(-Pi/2);
R1T1p = th_rotz(theta2) * th_trans(0, 0, h2) * th_rotx(Pi/2);
R1pT2 = th_trans(0, 0, l2) * th_rotx(-Pi/2);
R2T2p = th_rotz(theta3) * th_trans(0, 0, h3) * th_rotx(Pi/2);
R2pT3 = th_trans(0, 0, l3);

R0T3 = R0T1 * R1T1p * R1pT2 * R2T2p * R2pT3;
subs(R0T3(1:3, 4), [theta1 theta2 theta3], [0, 0, 0])
