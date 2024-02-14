function dx_Teta = attitude_fcn(x_Teta, u_Teta)
%dx_Teta = F*x_Teta + B_xTeta*u
kw = 1; kt = 1; g = 9.8; lr = 0.2;
Jx = 5.1; Jy = 5.1; Jz = 10.2;
b1 = lr*kw/Jx; b2 = lr*kw/Jy; b3 = kt/Jz;
c11 = 0;
F = [0  1            0 0                0  0              ;
     0 -c11/Jx       0 -c12(x_Teta)     0  -c13(x_Teta)   ;
     0  0            0 1                0  0              ;
     0  -c21(x_Teta) 0 -c22(x_Teta)/Jy  0  -c23(x_Teta)   ;
     0  0            0 0                0  1              ;
     0  -c31(x_Teta) 0 -c32(x_Teta)     0  -c33(x_Teta)/Jz;];
 
B_xTeta = [e(6,2)*b1, e(6,4)*b2, e(6,6)*b3];

dx_Teta = F*x_Teta + B_xTeta*u_Teta;
 
end
%% Aux Fcn

function a = c12(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (Jy-Jz)*(dtheta*cos(phi)*sin(phi) + dpsi*sin(phi)^2*cos(theta))/Jx...
    +((Jz-Jy)*dpsi*cos(phi)^2*cos(theta)-Jx*dpsi*cos(theta))/Jx;
end

function a = c13(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (Jz-Jy)*dpsi*cos(phi)*sin(phi)*cos(theta)^2/Jx;
end

function a = c21(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (Jz-Jy)*(dtheta*cos(phi)*sin(phi) + dpsi*sin(phi)^2*cos(theta))/Jy...
    +((Jy-Jz)*dpsi*cos(phi)^2*cos(theta)+Jx*dpsi*cos(theta))/Jy;
end

function a = c22(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (Jz-Jy)*dphi*cos(phi)*sin(phi)/Jy;
end

function a = c23(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (-Jx*dpsi*sin(theta)*cos(theta) + Jz*dpsi*cos(phi)^2*cos(theta)*sin(theta))/Jy...
    +dpsi*sin(phi)^2*cos(theta)*sin(theta);
end

function a = c31(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = ((Jy-Jz)*dpsi*cos(theta)^2*sin(phi)*cos(phi)-Jx*dtheta*cos(theta))/Jz;
end

function a = c32(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (Jz-Jy)*(dtheta*cos(phi)*sin(phi)*sin(theta)+dphi*sin(phi)^2*cos(theta))/Jz...
    +(Jy-Jz)*(dphi*cos(phi)^2*cos(theta)+Jx*dpsi*sin(theta)*cos(theta))/Jz...
    -Jy*dpsi*sin(phi)^2*sin(theta)*cos(theta)/Jz...
    -dpsi*cos(phi)^2*cos(theta)*sin(theta);
end

function a = c33(x_Teta)
Jx = 5.1; Jy = 5.1; Jz = 10.2;
phi = x_Teta(1);
dphi = x_Teta(2);
theta = x_Teta(3);
dtheta = x_Teta(4);
psi = x_Teta(5);
dpsi = x_Teta(6);
a = (-Jz*dtheta*cos(phi)^2*sin(theta)*cos(theta)-Jy*dtheta*sin(phi)^2*cos(theta)*sin(theta))/Jz...
    +((Jy-Jz)*dphi*cos(phi)*sin(phi)*cos(theta)^2+Jx*dtheta*sin(theta)*cos(theta))/Jz;
end

function a = e(m, n)
    % Create a (m x 1) vector with 1 in the n th element, and 0s elsewhere
    % m >= n
    a = zeros(m, 1);
    a(n) = 1;
end
