A = [0 1 0 0;
    -5 -0.5 0 -0.5;
    0 0 0 1;
    0 0 -5 0];
B = [0 1 0 0]';
Qe = 100*eye(2);
R = 1;
Lambda = 0.01;
Q = [Qe zeros(2,2); zeros(2,4)];
% Solve ARE
% K0 = [0 2 0 0];
% IterMax = ;
% K = K0;
% for i=1:IterMax
%     Ak = A-B*K;
%     LeftSide = Lambda*kron(eye(4),eye(4))-(kron(Ak',eye(4))+kron(eye(4),Ak));
%     Q_ = Q + K'*R*K;
%     RightSide = reshape(Q_, [16,1]);
%     vecP = pinv(LeftSide)*RightSide;
%     P = reshape(vecP, [4,4]);
%     K_new = inv(R)*B'*P;
%     if norm(K_new - K) < 0.1
%         break
%     end
%     K = K_new;
% end
H = [A -B*B';-Q -A'];
eig(H)