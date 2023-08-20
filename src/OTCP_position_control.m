close all 
% Reference
% dxp_d =  Ad*xp_d
% dxp = A*p + B*up_
load('last_data_position.mat')
T_step = 0.01;
T_end = 20;
global freqNum noise_freq;
a = 0.5; % a is frequency of desired trajectory 
% xp_d = [2*sin(a*t) 2*a*cos(a*t) 2*cos(a*t) -2*a*sin(a*t) 0.8*t 0.8];
Ad = [0 1 0 0 0 0;
      -a^2 0 0 0 0 0;
      0 0 0 1 0 0;
      0 0 -a^2 0 0 0;
      0 0 0 0 0 1;
      0 0 0 0 0 0];

% e_d = x-x_d;
% Xp = [e_d; x_d]; 
% dXp = A_*Xp + B_*up_

lambda = 0.01;
R = 1*eye(3);
Qe = 100*eye(6);
Q = [Qe zeros(6,6); zeros(6,12)];

%Phi(X) is a vector-Base function of V; 
%   PhiLength = length of Phi_fcn
%   w_Vp = vector weight of Vp; PhiLengthx1 --> Vp = w_Vp'*Phi_fcn()
%Psi(X) is a vector-Base function of u; 
%   PsiLength = length of Psi_fcn 
%   w_up = vector weight of up; PsiLengthx3 --> u = w_up'*Psi_fcn()
 
intPhi = [];
PsiPsi = [];
uPsi = [];
Phi = [];
CostQ_p = [];
t_save = [];
x_p_save = [];
xpd_save = [];
t0_save = [];

PhiLength = numel(Phi_fcn(zeros(1,12))); %Lenght of Phi
PsiLength = numel(Psi_fcn(zeros(1,12))); %Lenght of Psi
explo_noise_freq = 100*(rand(3,1)-0.5);
% Numfreq=500;
% freq1 = (-1+2*rand(Numfreq,1))*100;
% freq2 = (-1+2*rand(Numfreq,1))*100;
% freq3 = (-1+2*rand(Numfreq,1))*100;
% noise_freq = [freq1, freq2, freq3]';
load('noise_gud1.mat');
freqNum = size(noise_freq,2);
N = 20/T_step; %Number of window data collection


xp0 = [2 0 0 0 -1 0]';
xp_d0 = [0 2*a 2 0 0 0.8]';
e_d0 = xp0 - xp_d0;
X = [xp0' zeros(1,1+PhiLength+PsiLength^2+3*PsiLength)];
%% Online Data Collection
% X(1:6)  = e_d
% X(7:12) = xp_d
% X(12 + (1:PhiLegngth)) = Phi
% X(12+PhiLength + (1:PsiLength^2)) = PsiPsi;
% X(12+PhiLength + PsiLength^2 +(1:3*PsiLength)) = uPsi;
% X(end) = q
u_sim=out.u_sim;
for i = 1:N
    t_start = T_step*(i-1);
    t_end=T_step*i;%Start_Time	
    xp_d_start = [2*sin(a*t_start) 2*a*cos(a*t_start),...
     2*cos(a*t_start) -2*a*sin(a*t_start) 0.8*t_start 0.8]';
     xp_d_end = [2*sin(a*t_end) 2*a*cos(a*t_end),...
     2*cos(a*t_end) -2*a*sin(a*t_end) 0.8*t_end 0.8]';
 
%     t_end = T_step*i;	 %End_Time
%     xp_d_end = [6*sin(a*t_end) 6*a*cos(a*t_end),...
%      6*cos(a*t_end) -6*a*sin(a*t_end) 0.8*t_end 0.8]';
 
    % Update Data
    u_sim_i=u_sim(i,:)';
    [t,X] = ode45(@(t,X)irlDynamics_position_fcn(t,X,lambda,Q,R,noise_freq,u_sim_i, xp_d_end),...
        [i-1,i]*T_step,...
        [X(end,1:6) zeros(1,1+PhiLength+PsiLength^2+3*PsiLength)]);
    %Expand x_Teta to X_Teta
    Phi = [Phi;
        Phi_fcn([X(end,1:6)-xp_d_end',xp_d_end'])-Phi_fcn([X(1,1:6)-xp_d_start', xp_d_start'])];
    intPhi = [intPhi;
        X(end,6 + (1:PhiLength))];
    PsiPsi = [PsiPsi;
		X(end,6+PhiLength + (1:PsiLength^2))];
    uPsi = [uPsi;
        X(end,6+PhiLength + PsiLength^2 +(1:3*PsiLength))];
    CostQ_p = [CostQ_p;
        X(end,end)];			                                                              
	x_p_save = [x_p_save;
		X(end,1:6)];
    xpd_save=[xpd_save;
        xp_d_start'];
    t0_save = [t0_save;
        T_step*i];
    time = i*T_step
end


plot(t0_save, x_p_save(:,1));
figure

plot(t0_save, x_p_save(:,3));
figure

plot(t0_save, x_p_save(:,5));



%% Off-Policy Learning
IterMax = 199;  % Number of iterations
kp = 12; kd = 15;
K = [kp kd 0 0 0 0;
    0 0 kp kd 0 0;
    0 0 0 0 kp kd];
w_u=[-K zeros(3,6)]';
% w_u = zeros(PsiLength,3);
vec_w_u_save = [];
w_V_save = [];
time_wu=[];
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
    time_wu=[time_wu, i];
    rA = rank(A);
end
% 
% %% Test Results
% e_d_trained = e_d0';
% e_d_trained_save = [e_d_trained];
% xp_trained_save = [xp0'];
% xp_d_save = [xp_d0'];
% t_save = [0];
% N1 = 40/T_step;
% for i=1:N1
% 	t_end = T_step*(i);  %End_time of Loop	
%     xp_d_end = [2*sin(a*t_end) 2*a*cos(a*t_end),...
%      2*cos(a*t_end) -2*a*sin(a*t_end) 0.8*t_end 0.8]';
%     [t, e_d_trained] = ode45(@(t,e_d_trained)trained_error_position_fcn(t,e_d_trained,w_u),...
%     	[i-1,i]*T_step, e_d_trained(end,:));
% 	e_d_trained_save = [e_d_trained_save; 
%         e_d_trained(end,:)];
%     xp_trained_save = [xp_trained_save; 
%         e_d_trained(end,:) + xp_d_end];
% 	xp_d_save = [xp_d_save; 
%         xp_d_end'];
% 	t_save = [t_save; T_step*i];
%     currTime = i*T_step
% end
% 
% plot(t_save, e_d_trained_save(:,1), 'r');
% hold on;
% plot(t_save, e_d_trained_save(:,3), 'g');
% hold on;
% plot(t_save, e_d_trained_save(:,5), 'b');
% 
% function de_d_trained = trained_error_position_fcn(t,e_d_trained,w_u)
%     a = 0.5;
%     xp_d = [2*sin(a*t) 2*a*cos(a*t) 2*cos(a*t) -2*a*sin(a*t) 0.8*t 0.8]';
% 	Xp = [e_d_trained; xp_d];
% 	u = w_u'*Psi_fcn(Xp)';
% 	dXp = augDynamics_tracking_fcn(Xp,u);
%     de_d_trained = dXp(1:6);
% end
% 
% function a = e(m, n)
%     % Create a (m x 1) vector with 1 in the n th element, and 0s elsewhere
%     % m >= n
%     a = zeros(m, 1);
%     a(n) = 1;
% end
% 
% 
