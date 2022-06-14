function Densidade = CalculaDensidade2 (Tetao, x0, funcao, dens0)

if funcao==1
 
    Densidade = dens0+(100-dens0)/(1+exp((-Tetao+x0(3))/x0(4))); 

else
   
    nfator=size(x0);
    nfator=nfator(1,1)-1;
    x0(1)=dens0;
    %Criação da matriz de planejamento
    X=zeros(1,nfator);                                             %X = matriz de planejamento
    k=1;
    for j=nfator:-1:1
        X(1,k)=Tetao^(j-1); 
        k=k+1;
    end
    Densidade=X*x0(2:(nfator+1),1);

end


end