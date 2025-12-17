function plotDotAndArm(point, L, q)
% plotDotAndArm
% Plots a 3D point and a 3-DOF anthropomorphic arm
% Joint axes:
%   q1 about X0
%   q2 about Z1
%   q3 about Z2
%
% When q = [0 0 0], the arm is fully flat along X0

    % Inputs
    x = point(3);
    y = point(1);
    z = point(2);

    L1 = L(1);
    L2 = L(2);
    L3 = L(3);

    q1 = q(1);
    q2 = q(2);
    q3 = q(3);

    % Rotation matrices
    Rx = @(t) [ 1     0        0;
                0 cos(t) -sin(t);
                0 sin(t)  cos(t) ];

    Rz = @(t) [ cos(t) -sin(t) 0;
                sin(t)  cos(t) 0;
                   0        0  1 ];

    % Base
    P0 = [0; 0; 0];
    R0 = eye(3);

    % Joint 1 (rotation about X0)
    R1 = R0 * Rx(q1);
    P1 = P0 + R1 * [L1; 0; 0];

    % Joint 2 (rotation about Z1)
    R2 = R1 * Rz(q2);
    P2 = P1 + R2 * [L2; 0; 0];

    % Joint 3 (rotation about Z2)
    R3 = R2 * Rz(q3);
    P3 = P2 + R3 * [L3; 0; 0];

    % Arm points
    Xarm = [P0(1) P1(1) P2(1) P3(1)];
    Yarm = [P0(2) P1(2) P2(2) P3(2)];
    Zarm = [P0(3) P1(3) P2(3) P3(3)];

    % Plot
    figure;
    hold on;

    % Arm
    plot3(Xarm, Yarm, Zarm, '-o', ...
        'LineWidth', 3, ...
        'MarkerSize', 7, ...
        'MarkerFaceColor', 'b');

    % Target point
    plot3(x, y, z, 'r.', 'MarkerSize', 25);

    % Formatting
    grid on;
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Anthropomorphic Arm with Custom Joint Axes');

    reach = sum(L);
    xlim([-reach reach]);
    ylim([-reach reach]);
    zlim([-reach reach]);

    view(45, 30);
    hold off;
end
