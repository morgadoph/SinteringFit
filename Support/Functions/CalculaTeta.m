function Tetao = CalculaTeta (HR,TS,DT,Q)

HR = HR/60;
TS=TS+273.15;
DT=DT*3600;

R=8.31447e-3;
DeltaT= TS-293.15;
ndados= round(DeltaT/HR/20);
dados=zeros(ndados,2);

for i=1:ndados
    dados(i,1)=20*(i-1);
    dados(i,2)=293.15+20*HR*(i-1);
end
soma=0;
for k=2:ndados
    A0=1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)));
    Aint=1/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2));
    Afinal=1/dados(k,2)*exp(-Q/(R*dados(k,2)));
    soma=soma+(Afinal+A0+4*Aint)/6*(dados(k,1)-dados(k-1,1));
end
soma2=(1/TS*exp(-Q/(R*TS)))*DT;

Tetao=soma+soma2;

end


                