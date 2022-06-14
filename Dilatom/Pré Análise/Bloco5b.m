
function [grau, correlacao] = Determina_grau_ajuste (parametros, n_dados, chi2)

%Bloco que determina o chi2 te�rico dos ajustes
[media, var] = chi2stat(n_dados);                                          %Determina chi2 m�dio e vari�ncia para n�mero de dados ajustados
chi2teo = media;                                                           %Guarda chi2 m�dio para n�mero de dados utilizados
    

%Bloco que calcula valor do teste z supondo constante do mon�mio de maior grau = 0
zresult=zeros(7);
valorz=zeros(7);
for i=1:7
    h = ztest( param(i,1),0,paraminc(i,2)^(1/2));                          %Efetua o teste z para par�metro = 0 dentro da incerteza alfa=5%
    valorz(i)=param(i,1)/(param(i,2)^(1/2));                               %Calcula o valor da vari�vel z
    zresult(i)=h;                                                          %Guarda resultados do teste z
end


%Bloco que determina grau do polin�mio a se ajustar
grau=1;
for i=1:7
    if zresult(i)==1;
        grau=i;
    end
    
end

%Bloco que calcula coeficiente de correla��o para ajustes corretos
correlacao=1-chi2(grau)/chi2teo;


end


