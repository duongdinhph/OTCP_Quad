%% Off-Policy Learning
IterMax = 1000;  % Number of iterations
kp = 50; kd = 100;
K = [kp kd 0 0 0 0;
    0 0 kp kd 0 0;
    0 0 0 0 kp kd];
w_u=[-K zeros(3,6)]';
vecR = reshape(R, [9,1]);
vec_w_u_save = [];
w_V_save = [];
time_wu=[];
for i = 1:IterMax
    pw_u = w_u;
	A = [Gam-lambda*intGam, 2*uOmg-2*OmgOmg*kron(pw_u*R,eye(OmgLength))];
    vec_w_u = reshape(pw_u, [OmgLength*3,1]);
	B = -(CostQ + OmgOmg*kron(pw_u,pw_u)*vecR);
	root = A\B;
	w_V = root(1:GamLength);
	vec_w_u = root(GamLength+1:end);
    w_u = reshape(vec_w_u, [OmgLength,3]);
    Iter = i;
    if norm(w_u-pw_u) <= 0.001
        break
    end
	pw_V = w_V; %save the previous w_V for convergence check
    w_V_save = [w_V_save, w_V];
    vec_w_u_save = [vec_w_u_save, vec_w_u];  
    time_wu=[time_wu, i];
end
