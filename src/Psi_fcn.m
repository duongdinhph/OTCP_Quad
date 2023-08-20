function y = Psi_fcn(X)
% Basis function of up
% Derivative of Vp
x1 = X(1); x2 = X(2); x3 = X(3);
x4 = X(4); x5 = X(5); x6 = X(6);
x7 = X(7); x8 = X(8); x9 = X(9);
x10 = X(10); x11 = X(11); x12 = X(12);

y  = [x1
	  x2
	  x3
	  x4
	  x5
	  x6
	  x7
	  x8
	  x9
	  x10
	  x11
	  x12
%       x1^2
%       x2^2
%       x3^2
%       x4^2
%       x5^2
%       x6^2
%       x7^2
%       x8^2
%       x9^2
%       x10^2
%       x11^2
%       x12^2
%       x1*x2
%       x2*x3
%       x3*x4
%       x4*x5
%       x5*x6
%       x6*x7
%       x7*x8
%       x8*x9
%       x9*x10
%       x10*x11
%       x11*x12
%       x1^3
%       x2^3
%       x3^3
%       x4^3
%       x5^3
%       x6^3
%       x7^3
%       x9^3
%       x10^3
%       x11^3
%       x12^3
]';