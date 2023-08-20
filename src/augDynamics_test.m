function dXp = augDynamics_tracking_fcn(Xp,u_)
    % dXp = A_*Xp + B_*u_;
    % X_p = [e_p;x_pd]
    a = -0.5;
   Ad = [0 1 0 0 0 0;
      -a^2 0 0 0 0 0;
      0 0 0 1 0 0;
      0 0 -a^2 0 0 0;
      0 0 0 0 0 1;
      0 0 0 0 0 0];
    m = 2; kw = 1; g = 9.8;
    ap = [zeros(2,1) e(2,1)];
    A = [ap zeros(2,4); zeros(2,2) ap zeros(2,2); zeros(2,4) ap];
    B = 1/m*kw*[e(6,2) e(6,4) e(6,6)];
    A_ = [A A-Ad; zeros(6,6) Ad];
    B_ = [B; zeros(6,3)];

    dXp = A_*Xp + B_*u_;
end

function a = e(m, n)
    % Create a (m x 1) vector with 1 in the n th element, and 0s elsewhere
    % m >= n
    a = zeros(m, 1);
    a(n) = 1;
end