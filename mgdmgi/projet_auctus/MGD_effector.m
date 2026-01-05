
function p = MGD_effector(q1,q2,q3,L1,L2,L3,h1,h2)

theta1 = q1 + pi/2;%*pi/180 ;
theta2 = q2 - pi/2;%*pi/180 ;
theta3 = q3;%*pi/180 ;

% effecteur
x = L1 + L2*cos(theta2) + L3*cos(theta2 + theta3);
y = -(h1 +h2)*sin(theta1) + L2*sin(theta2)*cos(theta1) + L3*sin(theta2 + theta3)*cos(theta1); 
z = (h1 +h2)*cos(theta1) + L2*sin(theta2)*sin(theta1) + L3*sin(theta2 + theta3)*sin(theta1); 

p = [x;y;z];

end