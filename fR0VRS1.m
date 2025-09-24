
function dx = fR0VRS1(t,x)
global Lambda b1 b2 b3 b4 delta g  psi d... 
  sigma1 sigma2 sigma3 sigma4 gH dH...
l1 l2 p ...
bv1 bv2 bv3 bv4  deltav gv psiv ...
phi phiv1 phiv2 phiv3 phiv4 ...
N H  ...
%N=1;
%NG=x(1)+x(2)+x(3);%x(4) son removidos no cuentan como poblacion
%NV=x(5)+x(6)+x(7)+x(8);
%NC=x(10)+x(11);
w=round(x(5)/H); %funcion parte entera
%w=1;
y=abs(sigma1-gH);
%y=1;
%No vacunados
dx1 = Lambda - (b1*x(1)*(x(3)+x(9))./N)*(p./x(11)) - (phiv1+d)*x(1) + psi*x(4) + phi*x(7); %S
dx2 = (b1*x(1)*(x(3)+x(9))./N)*(p./x(11)) - (delta+d)*x(2); %E
dx3 = delta*x(2) - (sigma1 + g + d)*x(3); %I
dx4 = g*x(3) + gH*x(5) - (psi + d)*x(4); %R
%Hospitalizados
dx5 = sigma1*x(3) - (gH + dH)*x(5) - w*y*x(5) + gH*x(6); %H 
dx6 = w*y*x(5) - (gH+dH)*x(6); %Hc
%Vacunados
dx7 = phiv1*x(1) - (bv1*x(7)*(x(3)+x(9))./N)*(p./x(11)) - (phi+d)*x(7) + psiv*x(10); %Sv
dx8 = (bv1*x(7)*(x(3)+x(9))./N)*(p./x(11)) - (deltav + d)*x(8); %Ev 
dx9 = deltav*x(8) - (gv + d)*x(9); %Iv
dx10 = gv*x(9) - (psiv + d)*x(10); %Rv
%Percepcion
dx11 = -l1*(x(11)-p) + l2*(x(3)+x(5)+x(6)+x(9))./N; %p
dx=[dx1;dx2;dx3;dx4;dx5;dx6;dx7;dx8;dx9;dx10;dx11];