function Parametros =  ScaleBackParameters (Parameters,mu)

nfator= size(Parameters);
nfator=nfator(1,2);
m=mu(1,1);
stv=mu(2,1);
a=zeros(8,1);
j=8;
Parametros=zeros(1,8);

while nfator>0
    a(j)=Parameters(1,nfator);
    nfator=nfator-1;
    j=j-1;
end
Parametros(1,1)= a(1)/stv^7;
Parametros(1,2)= -7*a(1)*m/stv^7     +a(2)/stv^6;
Parametros(1,3)= 21*a(1)*m^2/stv^7   -6*a(2)*m/stv^6    +a(3)/stv^5;
Parametros(1,4)= -35*a(1)*m^3/stv^7  +15*a(2)*m^2/stv^6 -5*a(3)*m/stv^5    +a(4)/stv^4;
Parametros(1,5)= 35*a(1)*m^4/stv^7   -20*a(2)*m^3/stv^6 +10*a(3)*m^2/stv^5 -4*a(4)*m/stv^4   +a(5)/stv^3;
Parametros(1,6)= -21*a(1)*m^5/stv^7  +15*a(2)*m^4/stv^6 -10*a(3)*m^3/stv^5 +6*a(4)*m^2/stv^4 -3*a(5)*m/stv^3   +a(6)/stv^2;
Parametros(1,7)= 7*a(1)*m^6/stv^7    -6*a(2)*m^5/stv^6  +5*a(3)*m^4/stv^5  -4*a(4)*m^3/stv^4 +3*a(5)*m^2/stv^3 -2*a(6)*m/stv^2 +a(7)/stv;
Parametros(1,8)= -a(1)*m^7/stv^7      +a(2)*m^6/stv^6   -a(3)*m^5/stv^5    +a(4)*m^4/stv^4   -a(5)*m^3/stv^3   +a(6)*m^2/stv^2 -a(7)*m/stv +a(8);




end
