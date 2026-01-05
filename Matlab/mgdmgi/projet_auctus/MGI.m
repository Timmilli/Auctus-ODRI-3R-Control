function q = MGI(p_des, q0)

    % p_des : [x_d; y_d; z_d]
    % q0    : initial guess [q1; q2; q3]

    max_iter = 1000;
    tol = 1e-6;
    alpha = 1.0;

    
    L1 = 10;
    L2 = 10;
    L3 = 10;
    h1 = 1;
    h2 = 1;

    % ---- Get symbolic-derived functions ----
    [fk_fun, J_fun] = symbolic_model();

    q = q0;

    for k = 1:max_iter

        % Forward kinematics (numeric)
        p = fk_fun([q.' L1 L2 L3 h1 h2]);

        % Error
        e = p_des - p;

        if norm(e) < tol
            fprintf('Converged in %d iterations\n', k);
            fprintf('Motor angles should be q1:%f q2:%f q3:%f\n', mod(q(1)*180/pi,360),mod(q(2)*180/pi,360),mod(q(3)*180/pi,360));
            return;
        end

        % Jacobian (numeric)
        J = J_fun([q.' L1 L2 L3 h1 h2]);

        % Update
        dq = alpha * pinv(J) * e;
        q = q + dq;
    end

    warning('MGI did not converge');
end
