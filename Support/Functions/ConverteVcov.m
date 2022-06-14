function Vtrans = ConverteVcov (Vcov,dados)

ndados=size(Vcov);
ndados=ndados(1,1);

C1=zeros(ndados,ndados);
for i=1:ndados
    C1(i,i)=-1/(dados(i,3));
end

Vtrans = C1*Vcov*C1';

end
