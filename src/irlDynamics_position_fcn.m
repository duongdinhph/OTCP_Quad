function dX = irlDynamics_position_fcn(t,X,lambda,Q,R,noise_freq, u_sim, xp_d)
% X(1:6)  = e_d
% X(7:12) = xp_d
% X(12 + (1:PhiLegngth)) = Phi
% X(12+PhiLength + (1:PsiLength^2)) = PsiPsi;
% X(12+PhiLength + PsiLength^2 +(1:3*PsiLength)) = uPsi;
% X(end) = q
%%
global freqNum;
xp = X(1:6);
e_d=xp-xp_d;
Xp = [e_d; xp_d];
u_noise = zeros(3,1);
for idx=1:freqNum
    u_noise = u_noise + sin(noise_freq(:,idx)*t);
end
% u0 loaded from dataset
kp = 8;
kd = 10;
K = [kp kd 0 0 0 0;
	 0 0 kp kd 0 0;
	 0 0 0 0 kp kd];
u0 = -K*e_d+1*u_noise;
u0=u_sim;
dxp = augDynamics_tracking_fcn(xp,u0);

% Augmented part
intPhi = lambda*Phi_fcn(Xp)'; 
Psi = Psi_fcn(Xp);
PsiPsi = kron(Psi',Psi');
uPsi = kron(R*u0,Psi');
q = Xp'*Q*Xp;

dX = [dxp;
    intPhi;
    PsiPsi;
    uPsi;
    q];
end
