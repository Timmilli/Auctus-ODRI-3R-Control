clear; close all; clc;
addpath("./tr_homogenes")

% Using Denavit-Hartenberg convention (1955)
syms l2 l3 h1 h2 h3 theta1 theta2 theta3 alpha1 alpha3 real;
Pi=sym(pi);

R0T1  = th_rotz(theta1) * th_trans(0, 0, h1) * th_rotx(-Pi/2);
R1T1p = th_rotz(theta2) * th_trans(0, 0, h2) * th_rotx(Pi/2);
R1pT2 = th_trans(0, 0, l2) * th_rotx(-Pi/2);
R2T2p = th_rotz(theta3) * th_trans(0, 0, h3) * th_rotx(Pi/2);
R2pT3 = th_trans(0, 0, l3);

R1T2 = R1T1p * R1pT2;
R2T3 = R2T2p * R2pT3;

R1T3 = R1T2 * R2T3;
R0T3 = R0T1 * R1T3;


% MGD
MGD = simplify(R0T3(1:3,4)) % only position-based
subs(MGD, [l2 l3 h1 h2 h3 theta1 theta2 theta3], [0 0 1 1 1 0 0 0])
l = [l2 l3];
h = [h1 h2 h3];
q = [theta1 theta2 theta3];
J_MGD = jacobian(MGD, [theta1 theta2 theta3]);
matlabFunction(MGD, 'File', 'calc_mgd.m', 'Vars', {l, h, q});
matlabFunction(J_MGD, 'File', 'calc_jacobian_mgd.m', 'Vars', {l, h, q});

%%
% Plot
% Does not take in account the small h[2,3] parameters.
close all; clc;

%    l2 l3
L = [0  0];
%    h1 h2 h3
h = [1  1  1];
%    t1 t2 t3
q = [0 0 0];

p = calc_mgd(L, h, q)
plotDotAndArm(p, h, q);