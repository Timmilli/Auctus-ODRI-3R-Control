
function Pos = MGD_plot(q1,q2,q3,L1,L2,L3,h1,h2)

theta1 = q1 + pi/2;
theta2 = q2 - pi/2;
theta3 = q3;


% effecteur
x3 = L1 + L2*cos(theta2) + L3*cos(theta2 + theta3);
y3 = -(h1 +h2)*sin(theta1) + L2*sin(theta2)*cos(theta1) + L3*sin(theta2 + theta3)*cos(theta1); 
z3 = (h1 +h2)*cos(theta1) + L2*sin(theta2)*sin(theta1) + L3*sin(theta2 + theta3)*sin(theta1); 

% pivot2 + offset segment2 (h2)
x2 = L1 + L2*cos(theta2);
y2 = -(h1 +h2)*sin(theta1) + L2*sin(theta2)*cos(theta1);
z2 = (h1 +h2)*cos(theta1) + L2*sin(theta2)*sin(theta1);

% pivot2
x2_ = L1 + L2*cos(theta2);
y2_ = -(h1)*sin(theta1) + L2*sin(theta2)*cos(theta1);
z2_ = (h1)*cos(theta1) + L2*sin(theta2)*s   in(theta1);


% pivot1 + offset segment1 (h1)
x1 = L1;
y1 = -h1*sin(theta1);
z1 = h1*cos(theta1);

% pivot0 + offset egment0
x1_ = L1;
y1_ = 0;
z1_ = 0;

% pivot0 
x0 = 0;
y0 = 0;
z0 = 0;

Pos = [ x0 x1_ x1 x2_ x2 x3;
      y0 y1_ y1 y2_ y2 y3;
      z0 z1_ z1 z2_ z2 z3;
    ];

end