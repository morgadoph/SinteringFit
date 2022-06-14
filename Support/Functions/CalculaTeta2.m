function Tetao = CalculaTeta2 (HR,TS,DT,Q,TS1)

HR = HR/60;
TS=TS+273.15;
TS1=TS1+273.15;
DT=DT*3600;

R=8.31447e-3;
DeltaT= ((TS-TS1)^2)^(1/2);
ndados= round(DeltaT/HR/20);
dados=zeros(ndados,2);
aux=TS-TS1;
if aux>0
    aux2=1;
elseif aux<0
    aux2=-1;
else
    aux2=0;
end

for i=1:ndados
    dados(i,1)=20*(i-1);
    dados(i,2)=TS1+20*HR*(i-1)*aux2;
end
soma=0;
for k=2:ndados
    soma=soma+(1/dados(k,2)*exp(-Q/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
end
soma2=(1/TS*exp(-Q/(R*TS)))*DT;

Tetao=soma+soma2;

end