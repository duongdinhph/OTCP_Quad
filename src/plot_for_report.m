%% Data with initial controllers 
figure
subplot(3,1,1)
p=plot(t0_save, x_p_save(:,1)- xpd_save(:,1),'r');
p.LineWidth=1.5
legend('e_x')
grid on
subplot(3,1,2)
p=plot(t0_save, x_p_save(:,3)- xpd_save(:,3),'g');
p.LineWidth=1.5
legend('e_y')
grid on
subplot(3,1,3)
p=plot(t0_save, x_p_save(:,5)- xpd_save(:,5),'b');
p.LineWidth=1.5
legend('e_z')
grid on
%% Data convergence of W

norm_wu_save=[];
norm_wV_save=[];
for i=1:size(time_wu,2)
    norm_wu_save=[norm_wu_save, norm(vec_w_u_save(:,i))];
end
for i=1:size(time_wu,2)
    norm_wV_save=[norm_wV_save, norm(w_V_save(:,i))];
end
time_w=time_wu;
for i=1:16
    norm_wu_save=[norm_wu_save,norm_wu_save(end)];
    norm_wV_save=[norm_wV_save,norm_wV_save(end)];
    time_w=[time_w, time_w(end)+1];

end


subplot(2,1,2);

p=plot(time_w, norm_wu_save,'-*')
p(1).LineWidth=1.5;
subplot(2,1,1);
p=plot(time_w, norm_wV_save,'-*')
p(1).LineWidth=1.5;

%% Data with optimal controllers
figure
subplot(3,1,1)
p=plot(t_save, e_d_trained_save(:,1), 'r');
p.LineWidth=1.5;
grid on
subplot(3,1,2)
p=plot(t_save, e_d_trained_save(:,3), 'g');
p.LineWidth=1.5;
grid on
subplot(3,1,3)
p=plot(t_save, e_d_trained_save(:,5), 'b');
p.LineWidth=1.5;
grid on
%% Data xp vs xd
figure
subplot(3,1,1)
p1=plot(t_save, xp_d_save(:,1), 'r--')
p1.LineWidth=1
hold on
p2=plot(t_save, xp_trained_save(:,1), 'b');
p2.LineWidth=1
legend('x_d','x');
subplot(3,1,2)
p1=plot(t_save, xp_d_save(:,3), 'r--')
p1.LineWidth=1
hold on
p2=plot(t_save, xp_trained_save(:,3), 'b');
p2.LineWidth=1
legend('y_d','y');
subplot(3,1,3)
p1=plot(t_save, xp_d_save(:,5), 'r--')
p1.LineWidth=1
hold on
p2=plot(t_save, xp_trained_save(:,5), 'b');
p2.LineWidth=1
legend('z_d','z');
