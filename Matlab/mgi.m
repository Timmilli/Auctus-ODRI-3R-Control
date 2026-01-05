function q = MGI(l, h, p_des, q0)

    % p_des : [x_d; y_d; z_d]
    % q0    : initial guess [q1; q2; q3]

    max_iter = 1000;
    tol = 1e-6;
    alpha = 0.1;
    
    % ---- Get symbolic-derived functions ----
    q = q0;

    % gradient descent algorithm
    for k = 1:max_iter

        % Forward kinematics (numeric)
        p = calc_mgd(l, h, q');
        
        % Error
        e = p_des - p;
        
        if norm(e) < tol
            fprintf('Converged in %d iterations\n', k);
            fprintf('Motor angles should be q1:%f q2:%f q3:%f\n', mod(q(1)*180/pi,360),mod(q(2)*180/pi,360),mod(q(3)*180/pi,360));
            return;
        end

        % Jacobian (numeric)
        J = calc_jacobian_mgd(l, h, q');

        % Update
        dq = alpha * pinv(J) * e;
        q = q + dq;
    end

    warning('MGI did not converge');
end

l = [1 1];
h = [1 1 1];
p_des = [0; 2; 1];
q0 = [0; pi/2; -pi/2];
q_star = MGI(l, h, p_des, q0);

MGD = calc_mgd(l, h, q_star')
plotDotAndArm(MGD, h, q_star');
