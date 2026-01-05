function [fk_fun, J_fun] = symbolic_model()

    syms q1 q2 q3 real
    syms L1 L2 L3 h1 h2 real positive
    % -------- MGD effector with offset --------
    theta1 = q1;% + pi/2;
    theta2 = q2;% - pi/2;
    theta3 = q3;
    
    x = L1 + L2*cos(theta2) + L3*cos(theta2 + theta3);
    y = -(h1 +h2)*sin(theta1) + L2*sin(theta2)*cos(theta1) + L3*sin(theta2 + theta3)*cos(theta1); 
    z = (h1 +h2)*cos(theta1) + L2*sin(theta2)*sin(theta1) + L3*sin(theta2 + theta3)*sin(theta1); 

    p = [x;y;z];
    % -------- Jacobian --------
    J = jacobian(p, [q1 q2 q3]);

    % -------- Convert to numeric functions --------
    fk_fun = matlabFunction(p, 'Vars', {[q1 q2 q3 L1 L2 L3 h1 h2]});
    J_fun  = matlabFunction(J, 'Vars', {[q1 q2 q3 L1 L2 L3 h1 h2]});
end
