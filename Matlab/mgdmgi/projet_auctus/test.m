%% denavit hartenberg
%entrée : [theta1 theta2 theta3]
%sortie : [x y z]

syms L1 L2 L3 h1 h2
syms theta1 theta2 theta3

syms x y z
x_world = [x; y; z];   % column vector

DH = [0 L1 0 theta1;
      theta2 L2 h1 0;
      theta3 L3 h2 0];

%% TEST DE CALCUL DIRECT

L1 = 10;
L2 = 10;
L3 = 10;
h1 = 1;
h2 = 1;

theta1 = 90*pi/180;
theta2 = -135*pi/180;
theta3 = 90*pi/180;

x3 = L1 + L2*cos(theta2) + L3*cos(theta2 + theta3);
y3 = -(h1 +h2)*sin(theta1) + L2*sin(theta2)*cos(theta1) + L3*sin(theta2 + theta3)*cos(theta1); 
z3 = (h1 +h2)*cos(theta1) + L2*sin(theta2)*sin(theta1) + L3*sin(theta2 + theta3)*sin(theta1); 

x2 = L1 + L2*cos(theta2);
y2 = -(h1 +h2)*sin(theta1) + L2*sin(theta2)*cos(theta1);
z2 = (h1 +h2)*cos(theta1) + L2*sin(theta2)*sin(theta1);

x2_ = L1 + L2*cos(theta2);
y2_ = -(h1)*sin(theta1) + L2*sin(theta2)*cos(theta1);
z2_ = (h1)*cos(theta1) + L2*sin(theta2)*sin(theta1);

x1 = L1;
y1 = -h1*sin(theta1);
z1 = h1*cos(theta1);

x1_ = L1;
y1_ = 0;
z1_ = 0;

x0 = 0;
y0 = 0;
z0 = 0;


P = [ x0 x1_ x1 x2_ x2 x3;
      y0 y1_ y1 y2_ y2 y3;
      z0 z1_ z1 z2_ z2 z3;
    ];

%% MGD + PLOTTING

clc
clear all

L1 = 10;
L2 = 10;
L3 = 10;
h1 = 1;
h2 = 1;

P = MGD_plot(0, pi/4, -pi/2, L1, L2, L3, h1, h2);

figure
hold on

% Premier segment → RED
plot3(P(1,1:2), P(2,1:2), P(3,1:2), '-or', ...
      'LineWidth', 2, 'MarkerSize', 8)

% Second segment → BLUE
plot3(P(1,2:4), P(2,2:4), P(3,2:4), '-ob', ...
      'LineWidth', 2, 'MarkerSize', 8)

% Dernier segment → GREEN
plot3(P(1,4:6), P(2,4:6), P(3,4:6), '-og', ...
      'LineWidth', 2, 'MarkerSize', 8)

view(3)
grid on
axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
title("MGD")
hold off

%% test MGI

clc
clear all


L1 = 10;
L2 = 10;
L3 = 10;
h1 = 1;
h2 = 1;

p_des = [10;-2;-14.1421];
q_0 = [0;0;0];

q_final = MGI(p_des, q_0);

P = MGD_plot(q_final(1), q_final(2), q_final(3), L1, L2, L3, h1, h2);

figure
hold on

% Premier segment → RED
plot3(P(1,1:2), P(2,1:2), P(3,1:2), '-or', ...
      'LineWidth', 2, 'MarkerSize', 8)

% Second segment → BLUE
plot3(P(1,2:4), P(2,2:4), P(3,2:4), '-ob', ...
      'LineWidth', 2, 'MarkerSize', 8)

% Dernier segment → GREEN
plot3(P(1,4:6), P(2,4:6), P(3,4:6), '-og', ...
      'LineWidth', 2, 'MarkerSize', 8)

view(3)
grid on
axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
title("MGI")
hold off
