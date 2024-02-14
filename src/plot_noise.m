global noise_freq freqNum
freqNum = size(noise_freq,2);
u_noise = zeros(3,1);
t=0:0.01:20;
for idx=1:freqNum
    u_noise = u_noise + sin(noise_freq(:,idx)*t);
end
plot(t, u_noise)
