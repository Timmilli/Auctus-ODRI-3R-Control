clc;
clear all;
syms t;
syms q1(t) q2(t) q3(t);
syms L1 LG1 h1 L2 LG2 h2 LG3; 
syms m1 m2 m3 g;
syms I1 I2 I3;
syms Cm1 Cm2 Cm3 fs1 fs2 fs3 fv1 fv2 fv3;
%% bases geometriques
R10 = [ 1 0 0;
    0 cos(q1(t)) -sin(q1(t));
    0 sin(q1(t)) cos(q1(t))
    ];

R21 = [cos(q2(t)) -sin(q2(t)) 0;
    sin(q2(t)) cos(q2(t)) 0;
    0 0 1
    ];

R32 = [cos(q3(t)+q2(t)) -sin(q3(t)+q2(t)) 0;
    sin(q3(t)+q2(t)) cos(q3(t)+q2(t)) 0;
    0 0 1
    ];

ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];

x0 = ex; x1 = R10*ex; x2 = R10 * R21 * ex; x3 = R10 * R32 * ex;
y0 = ey; y1 = R10*ey; y2 = R10 * R21 * ey; y3 = R10 * R32 * ey;
z0 = ez; z1 = R10*ez; z2 = R10 * R21 * ez; z3 = R10 * R32 * ez;



%% positions vitesses accelerations des centres de gravités
P0 = [0;0;0];
%
P1 = LG1*x0;
v1 = diff(P1,t);
a1 = diff(v1,t);
P2 = L1*x0 + h1*z1 + LG2*x2;
v2 = diff(P2,t);
a2 = diff(v2,t);
P3 = L1*x0 + h1*z1 + L2*x2 + h2*z3 + LG3*x3;
v3 = diff(P3,t);
a3 = diff(v3,t);


%% weight torques

Mg3 = dot(cross(LG3*x3,-m3*g*z0),z3)*z3;

Mg2 = (dot(cross(L2*x2+h2*z3+LG3*x3,-m3*g*z0),z2) + dot(cross(LG2*x2,-m2*g*z0),z2))*z2;

Mg1 = (dot(cross(L1*x0+h1*z1+L2*x2+h2*z3+LG3*x3,-m3*g*z0),x0) + dot(cross(L1*x0+h1*z1+LG2*x2,-m2*g*z0),z2) + dot(cross(LG1*x0,-m1*g*z0),x0))*x0;


%% dynamic torques

moment_cin_3 = I3*(diff(q1(t)+q2(t)+q3(t),t));
moment_cin_2 = I2*(diff(q1(t)+q2(t),t));
moment_cin_1 = I1*(diff(q1(t),t));

Cv1 = fv1*diff(q1(t),t);
Cv2 = fv2*diff(q2(t),t);
Cv3 = fv3*diff(q3(t),t);

Cs1 = fs1*sign(diff(q1(t),t));
Cs2 = fs2*sign(diff(q2(t),t));
Cs3 = fs3*sign(diff(q3(t),t));

Moment_dyn_3 = diff(moment_cin_3,t) + cross(h2*z3+LG3*x3,m3*a3);
Moment_dyn_2 = diff(moment_cin_3,t) + cross(h1*z1+L2*x2+h2*z3+LG3*x3,m3*a3) + diff(moment_cin_2,t) + cross(h1*z1+LG2*x2,m2*a2);
Moment_dyn_1 = diff(moment_cin_3,t) + cross(L1*x0+h1*z1+L2*x2+h2*z3+LG3*x3,m3*a3) + diff(moment_cin_2,t) + cross(L1*x0+h1*z1+LG2*x2,m3*a3) + diff(moment_cin_1,t) + cross(L1*x0,m1*a1);

Cm1 = Moment_dyn_1 - (Cv1 + Cf1 + Mg1);
Cm2 = Moment_dyn_2 - (Cv2 + Cf2 + Mg2);
Cm3 = Moment_dyn_3 - (Cv2 + Cf3 + Mg3);

