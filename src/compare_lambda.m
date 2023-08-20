figure
p=plot(t_save, e_d_trained_save_001(:,1), 'r');
%p.LineWidth=1.5;
hold on
p=plot(t_save, e_d_trained_save_05(:,1), 'g');
hold on
p=plot(t_save, e_d_trained_save_1(:,1), 'b');
legend('\lambda=0.01', '\lambda=0.5', '\lambda=1');
grid on