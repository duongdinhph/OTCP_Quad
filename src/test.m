
%% Test Results
e_d_trained = e_d0';
e_d_trained_save = [e_d_trained];
xp_trained_save = [xp0'];
xp_d_save = [xp_d0'];
t_save = [0];
N1 = 40/T_step;
for i=1:N1
	t_end = T_step*(i);  %End_time of Loop	
    xp_d_end = [2*sin(a*t_end) 2*a*cos(a*t_end),...
     2*cos(a*t_end) -2*a*sin(a*t_end) 0.8*t_end 0.8]';
    [t, e_d_trained] = ode45(@(t,e_d_trained)trained_error_position_fcn(t,e_d_trained,w_u),...
    	[i-1,i]*T_step, e_d_trained(end,:));
	e_d_trained_save = [e_d_trained_save; 
        e_d_trained(end,:)];
    xp_trained_save = [xp_trained_save; 
        e_d_trained(end,:) + xp_d_end'];
	xp_d_save = [xp_d_save; 
        xp_d_end'];
	t_save = [t_save; T_step*i];
    currTime = i*T_step
end

plot(t_save, e_d_trained_save(:,1), 'r');
hold on;
plot(t_save, e_d_trained_save(:,3), 'g');
hold on;
plot(t_save, e_d_trained_save(:,5), 'b');

function de_d_trained = trained_error_position_fcn(t,e_d_trained,w_u)
    a = 0.5;
    xp_d = [2*sin(a*t) 2*a*cos(a*t) 2*cos(a*t) -2*a*sin(a*t) 0.8*t 0.8]';
	Xp = [e_d_trained; xp_d];
	u = w_u'*Psi_fcn(Xp)';
	dXp = augDynamics_test(Xp,u);
    de_d_trained = dXp(1:6);
end

function a = e(m, n)
    % Create a (m x 1) vector with 1 in the n th element, and 0s elsewhere
    % m >= n
    a = zeros(m, 1);
    a(n) = 1;
end

