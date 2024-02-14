function y = Phi_fcn(X)
% Basis function of Vp 
x1 = X(1); x2 = X(2); x3 = X(3);
x4 = X(4); x5 = X(5); x6 = X(6);
x7 = X(7); x8 = X(8); x9 = X(9);
x10 = X(10); x11 = X(11); x12 = X(12);

y  = [
   x1^2
	  x2^2
	  x3^2
	  x4^2
      x5^2
      x6^2
      x7^2
      x8^2
      x9^2
      x10^2
      x11^2
      x12^2
      x1*x2
     x1*x3
     x1*x4
     x1*x5
     x1*x6
     x1*x7
     x1*x8
     x1*x9
     x1*x10
     x1*x11
     x1*x12
     x2*x3
     x2*x4
     x2*x5
     x2*x6
     x2*x7
     x2*x8
     x2*x9
     x2*x10
     x2*x11
     x2*x12
     x3*x4
     x3*x5
     x3*x6
     x3*x7
     x3*x8
     x3*x9
     x3*x10
     x3*x11
     x3*x12
     x4*x5
     x4*x6
     x4*x7
     x4*x8
     x4*x9
     x4*x10
     x4*x11
     x4*x12
     x5*x6
     x5*x7
     x5*x8
     x5*x9
     x5*x10
     x5*x11
     x5*x12
     x6*x7
     x6*x8
     x6*x9
     x6*x10
     x6*x11
     x6*x12
     x7*x8
     x7*x9
     x7*x10
     x7*x11
     x7*x12
     x8*x9
     x8*x10
     x8*x11
     x8*x12
     x9*x10
     x9*x11
     x9*x12
     x10*x11
     x10*x12
     x11*x12
      ]';