function J = getJacobian(Theta, L)
% Theta = [theta1 theta2 theta3]
% L = [l1 l2 l3 h1 h2 h3]

theta1 = Theta(1);
theta2 = Theta(2);
theta3 = Theta(3);

l1 = L(1);
l2 = L(2);
l3 = L(3);
h1 = L(4);
h2 = L(5);
h3 = L(6);

A = -sin(theta1)*(l3*sin(theta2+theta3)+l2*sin(theta2))-(h2+h3)*cos(theta1);
B = -(h2+h3)*sin(theta1)+cos(theta1)*(l3*sin(theta2+theta3)+l2*sin(theta2));
C = 0;

D = cos(theta1)*(l3*cos(theta2+theta3)+l2*cos(theta2));
E = sin(theta1)*(l3*cos(theta2+theta3)+l2*cos(theta2));
F = -sin(theta2+theta3)-l2*sin(theta2);

G = l3*cos(theta1)*cos(theta2+theta3);
H = l3*sin(theta1)*cos(theta2+theta3);
I = -sin(theta2+theta3);

J = [A, B, C;
    D, E, F;
    G, H, I];
J = simplify(J)

end