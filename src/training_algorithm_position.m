%% Off-Policy Learning
IterMax = 199;  % Number of iterations
kp = 8; kd = 20;
K = [kp kd 0 0 0 0;
    0 0 kp kd 0 0;
    0 0 0 0 kp kd];
w_u=[-K zeros(3,6)]';
% w_u = zeros(PsiLength,3);
vec_w_u_save = [];
w_V_save = [];
vecR=reshape(R,[9,1]);
for i = 1:IterMax
    pw_u = w_u; %save the previous w_V for convergence check
	A = [Phi-intPhi 2*uPsi-2*PsiPsi*kron(pw_u*R,eye(PsiLength))];
    vec_w_u = reshape(pw_u, [PsiLength*3,1]);
	B = -(CostQ_p + PsiPsi*kron(pw_u*R,eye(PsiLength))*vec_w_u);
    B = -(CostQ_p + PsiPsi*kron(pw_u,pw_u)*vecR);
	root = A\B;
	w_V = root(1:PhiLength);
	vec_w_u = root(PhiLength+1:end);
    w_u = reshape(vec_w_u, [PsiLength,3]);
    Iter = i;
    if norm(w_u - pw_u) <= 0.0001
        break
    end
	pw_V = w_V;
    w_V_save = [w_V_save, w_V];
    vec_w_u_save = [vec_w_u_save, vec_w_u]; 
    rA = rank(A);
end
