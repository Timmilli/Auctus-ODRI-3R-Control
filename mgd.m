clear; close all; clc;
addpath("./tr_homogenes")

% Using Denavit-Hartenberg convention (1955)
syms l1 l2 l3 h1 h2 h3 theta1 theta2 theta3 alpha1 alpha3 real;
Pi=sym(pi);

R0T1  = th_rotz(theta1) * th_trans(0, 0, h1) * th_rotx(-Pi/2);
R1T1p = th_rotz(theta2) * th_trans(0, 0, h2) * th_rotx(Pi/2);
R1pT2 = th_trans(0, 0, l2) * th_rotx(-Pi/2);
R2T2p = th_rotz(theta3) * th_trans(0, 0, h3) * th_rotx(Pi/2);
R2pT3 = th_trans(0, 0, l3);

R0T3 = R0T1 * R1T1p * R1pT2 * R2T2p * R2pT3;
R0T3 = R0T3(1:3, 4)

%%
% Plot
% Does not take in account the small h[2,3] parameters.
close all; clc;

%    l1 l2 l3 h1 h2 h3
L = [0  1  1  1  0  0];
%    t1 t2 t3
Q = [0  0  0];

point = subs(R0T3, [l1 l2 l3 h1 h2 h3], L);
point = subs(point, [theta1 theta2 theta3], Q);

plotDotAndArm(point, [1 1 1], Q)

%%
% Methode de Paul

syms Px Py Pz s0 n0 a0 real;

U0 = [0 0 0 Px;
      s0 n0 a0 Py;
      0 0 0 Pz;
      0 0 0 1]; 

R0T1
th_inv(R0T1)