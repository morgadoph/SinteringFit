function F = polinomial (parametros, dadosx)

grau=size(parametros);
grau=grau(1,1)-1;
ndados=size(dadosx);
%Bloco de análise
nfator=grau+1;                                                   %nfator = número de parâmetros ajustados
%Criação da matriz de planejamento
X=zeros(ndados(1,1),nfator);                                             %X = matriz de planejamento
for i=1:ndados(1,1)
    k=1;
    for j=nfator:-1:1
        X(i,k)=dadosx(i)^(j-1); 
        k=k+1;
    end
end
F=X*parametros;

end