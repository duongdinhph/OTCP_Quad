a = -0.5;
Ad = [0 0 a 0 0 0;
  0 0 0 a 0 0;
  -a 0 0 0 0 0;
  0 -a 0 0 0 0;
  0 0 0 0 0 1;
  0 0 0 0 0 0];
m = 2; kw = 1; g = 9.8;
ap = [zeros(2,1) e(2,1)];
A = [ap zeros(2,4); zeros(2,2) ap zeros(2,2); zeros(2,4) ap];
B = 1/m*kw*[e(6,2) e(6,4) e(6,6)];
A_ = [A A-Ad; zeros(6,6) Ad];
B_ = [B; zeros(6,3)];

Lambda = 0.5;
R = eye(3);
Qe = 100*eye(6);
Q = [Qe zeros(6,6); zeros(6,12)];

function a = e(m, n)
    % Create a (m x 1) vector with 1 in the n th element, and 0s elsewhere
    % m >= n
    a = zeros(m, 1);
    a(n) = 1;
end