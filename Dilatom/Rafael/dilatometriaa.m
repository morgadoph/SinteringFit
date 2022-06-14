clc

%Bloco de entrada de dados
%************** Cada curva é dividida em dois arquivos de 4/3 colunas:
%******** Aquecimento (Tempo(s), Temperatura (Celsius), Deslocamento, incerteza)
%******** Resfriamento (Temperatura (Celsius), Deslocamento, incerteza)
n_linhas=zeros(4,2);                                                       %Número de linhas dos arquivos de entrada (aquec., refr.)
n_col=zeros(4,2);                                                          %Número de colunas dos arquivos de entrada
load 'curva1.dat';                                                         %Arquivo de entrada para aquecimento                                                     
load 'curva1res.dat';                                                      %Arquivo de entrada para resfriamento
[n_linhas(1,1),n_col(1,1)]=size(curva1);                                   %Determina número de linhas no aquecimento para loops
[n_linhas(1,2),n_col(1,2)]=size(curva1res);                                %Determina número de linhas no resfriamento para loops
load 'curva2.dat';
load 'curva2res.dat';
[n_linhas(2,1),n_col(2,1)]=size(curva2);
[n_linhas(2,2),n_col(2,2)]=size(curva2res);
load 'curva3.dat';
load 'curva3res.dat';
[n_linhas(3,1),n_col(3,1)]=size(curva3);
[n_linhas(3,2),n_col(3,2)]=size(curva3res);
load 'curva4.dat';
load 'curva4res.dat';
[n_linhas(4,1),n_col(4,1)]=size(curva4);
[n_linhas(4,2),n_col(4,2)]=size(curva4res);
load 'inicial.dat';                                                        %Arquivo com parâmetros iniciais - 4 colunas (1coluna *L0, 3coluna *r0, Incertezas) 
fator_massa=0.99;                                                          %Fator multiplicativo para correção da perda de massa

%Bloco que faz ajustes de expansão térmica não levando em consideração covariância 
chi2=zeros(7,4);
[a1_1,chi2(1,1)]=MMQpolinomial(curva1res,1);    [a1_2,chi2(1,2)]=MMQpolinomial(curva2res,1);    [a1_3,chi2(1,3)]=MMQpolinomial(curva3res,1);    [a1_4,chi2(1,4)]=MMQpolinomial(curva4res,1);
[a2_1,chi2(2,1)]=MMQpolinomial(curva1res,2);    [a2_2,chi2(2,2)]=MMQpolinomial(curva2res,2);    [a2_3,chi2(2,3)]=MMQpolinomial(curva3res,2);    [a2_4,chi2(2,4)]=MMQpolinomial(curva4res,2);
[a3_1,chi2(3,1)]=MMQpolinomial(curva1res,3);    [a3_2,chi2(3,2)]=MMQpolinomial(curva2res,3);    [a3_3,chi2(3,3)]=MMQpolinomial(curva3res,3);    [a3_4,chi2(3,4)]=MMQpolinomial(curva4res,3);
[a4_1,chi2(4,1)]=MMQpolinomial(curva1res,4);    [a4_2,chi2(4,2)]=MMQpolinomial(curva2res,4);    [a4_3,chi2(4,3)]=MMQpolinomial(curva3res,4);    [a4_4,chi2(4,4)]=MMQpolinomial(curva4res,4);
[a5_1,chi2(5,1)]=MMQpolinomial(curva1res,5);    [a5_2,chi2(5,2)]=MMQpolinomial(curva2res,5);    [a5_3,chi2(5,3)]=MMQpolinomial(curva3res,5);    [a5_4,chi2(5,4)]=MMQpolinomial(curva4res,5);
[a6_1,chi2(6,1)]=MMQpolinomial(curva1res,6);    [a6_2,chi2(6,2)]=MMQpolinomial(curva2res,6);    [a6_3,chi2(6,3)]=MMQpolinomial(curva3res,6);    [a6_4,chi2(6,4)]=MMQpolinomial(curva4res,6);
[a7_1,chi2(7,1)]=MMQpolinomial(curva1res,7);    [a7_2,chi2(7,2)]=MMQpolinomial(curva2res,7);    [a7_3,chi2(7,3)]=MMQpolinomial(curva3res,7);    [a7_4,chi2(7,4)]=MMQpolinomial(curva4res,7);

%bloco que prepara vaiáveis para teste z
param = zeros(7,4);                                                        %Guarda valores das constantes multiplicaitvas dos monômios de maior grau ajustado
param=[ a1_1(2,1)    a1_2(2,1)    a1_3(2,1)    a1_4(2,1);
        a2_1(3,1)    a2_2(3,1)    a2_3(3,1)    a2_4(3,1);
        a3_1(4,1)    a3_2(4,1)    a3_3(4,1)    a3_4(4,1);
        a4_1(5,1)    a4_2(5,1)    a4_3(5,1)    a4_4(5,1);
        a5_1(6,1)    a5_2(5,1)    a5_3(6,1)    a5_4(6,1);
        a6_1(7,1)    a6_2(7,1)    a6_3(7,1)    a6_4(7,1);
        a7_1(8,1)    a7_2(8,1)    a7_3(8,1)    a7_4(8,1)];
paraminc = zeros(7,4);                                                     %Guarda as incertezas das constantes multiplicaitvas dos monômios de maior grau ajustado
paraminc=[ a1_1(2,2)    a1_2(2,2)    a1_3(2,2)    a1_4(2,2);
           a2_1(3,2)    a2_2(3,2)    a2_3(3,2)    a2_4(3,2);
           a3_1(4,2)    a3_2(4,2)    a3_3(4,2)    a3_4(4,2);
           a4_1(5,2)    a4_2(5,2)    a4_3(5,2)    a4_4(5,2);
           a5_1(6,2)    a5_2(5,2)    a5_3(6,2)    a5_4(6,2);
           a6_1(7,2)    a6_2(7,2)    a6_3(7,2)    a6_4(7,2);
           a7_1(8,2)    a7_2(8,2)    a7_3(8,2)    a7_4(8,2)];
         
%Bloco que determina o chi2 teórico dos ajustes
chi2teo=zeros(7,4);
for i=1:7
    for j=1:4
        [media, var] = chi2stat(n_linhas(j,2)-(i+1));                      %Determina chi2 médio e variância para número de dados ajustados
        chi2teo(i,j) = media;                                              %Guarda chi2 médio para número de dados utilizados
    end
end

%Bloco que calcula valor do teste z supondo constante do monômio de maior grau = 0
zresult=zeros(7,4);
valorz=zeros(7,4);
for i=1:7
    for j=1:4
        h = ztest( param(i,j),0,paraminc(i,j)^(1/2));                            %Efetua o teste z para parâmetro = 0 dentro da incerteza alfa=5%
        valorz(i,j)=param(i,j)/(param(i,j)^(1/2));
        zresult(i,j)=h;                                                    %Guarda resultados do teste z
    end
end

%Bloco que determina grau do polinômio a se ajustar
grau=[1 1 1 1];
for i=1:7
    for j=1:4
        if zresult(i,j)==1;
        grau(1,j)=i;
        end
    end
end

%Bloco que calcula coeficiente de correlação para ajustes corretos
correlacao=zeros(1,4);
for i=1:4
    correlacao(1,i)=1-chi2(grau(1,i),i)/chi2teo(grau(1,i),i);
end

%Bloco que calcula matriz de variância dos dados e prepara dados para MMQ polinomial com covariância
V1=zeros(n_linhas(1,2),n_linhas(1,2));    dadosx1=zeros(n_linhas(1,2),1);    dadosy1=zeros(n_linhas(1,2),1);
V2=zeros(n_linhas(2,2),n_linhas(2,2));    dadosx2=zeros(n_linhas(2,2),1);    dadosy2=zeros(n_linhas(2,2),1);
V3=zeros(n_linhas(3,2),n_linhas(3,2));    dadosx3=zeros(n_linhas(3,2),1);    dadosy3=zeros(n_linhas(3,2),1);
V4=zeros(n_linhas(4,2),n_linhas(4,2));    dadosx4=zeros(n_linhas(4,2),1);    dadosy4=zeros(n_linhas(4,2),1);
for i=1:n_linhas(1,2)
    for j=1:n_linhas(1,2)
        dadosx1(i,1)=curva1res(i,1);
        dadosy1(i,1)=curva1res(i,2);
        if i==j
            V1(i,i)=curva1res(i,3)^2;
        else
            V1(i,j)=correlacao(1,1)*curva1res(i,3)*curva1res(j,3);
        end
    end
end
for i=1:n_linhas(2,2)
    for j=1:n_linhas(2,2)
        dadosx2(i,1)=curva2res(i,1);
        dadosy2(i,1)=curva2res(i,2);
        if i==j
            V2(i,i)=curva2res(i,3)^2;
        else
            V2(i,j)=correlacao(1,2)*curva2res(i,3)*curva2res(j,3);
        end
    end
end
for i=1:n_linhas(3,2)
    for j=1:n_linhas(3,2)
        dadosx3(i,1)=curva3res(i,1);
        dadosy3(i,1)=curva3res(i,2);
        if i==j
            V3(i,i)=curva3res(i,3)^2;
        else
            V3(i,j)=correlacao(1,1)*curva3res(i,3)*curva3res(j,3);
        end
    end
end
for i=1:n_linhas(4,2)
    for j=1:n_linhas(4,2)
        dadosx4(i,1)=curva4res(i,1);
        dadosy4(i,1)=curva4res(i,2);
        if i==j
            V4(i,i)=curva4res(i,3)^2;
        else
            V4(i,j)=correlacao(1,1)*curva4res(i,3)*curva4res(j,3);
        end
    end
end


%Bloco que ajusta dados utilizando MMQ com dados covariantes
chi2cov=zeros(7,4);
[a1_1cov,chi2cov(1,1)]=MMQpolcov(dadosx1, dadosy1, V1, 1);    [a1_2cov,chi2cov(1,2)]=MMQpolcov(dadosx2, dadosy2, V2, 1);    [a1_3cov,chi2cov(1,3)]=MMQpolcov(dadosx3, dadosy3, V3, 1);    [a1_4cov,chi2cov(1,4)]=MMQpolcov(dadosx4, dadosy4, V4, 1);
[a2_1cov,chi2cov(2,1)]=MMQpolcov(dadosx1, dadosy1, V1, 2);    [a2_2cov,chi2cov(2,2)]=MMQpolcov(dadosx2, dadosy2, V2, 2);    [a2_3cov,chi2cov(2,3)]=MMQpolcov(dadosx3, dadosy3, V3, 2);    [a2_4cov,chi2cov(2,4)]=MMQpolcov(dadosx4, dadosy4, V4, 2);
[a3_1cov,chi2cov(3,1)]=MMQpolcov(dadosx1, dadosy1, V1, 3);    [a3_2cov,chi2cov(3,2)]=MMQpolcov(dadosx2, dadosy2, V2, 3);    [a3_3cov,chi2cov(3,3)]=MMQpolcov(dadosx3, dadosy3, V3, 3);    [a3_4cov,chi2cov(3,4)]=MMQpolcov(dadosx4, dadosy4, V4, 3);
[a4_1cov,chi2cov(4,1)]=MMQpolcov(dadosx1, dadosy1, V1, 4);    [a4_2cov,chi2cov(4,2)]=MMQpolcov(dadosx2, dadosy2, V2, 4);    [a4_3cov,chi2cov(4,3)]=MMQpolcov(dadosx3, dadosy3, V3, 4);    [a4_4cov,chi2cov(4,4)]=MMQpolcov(dadosx4, dadosy4, V4, 4);
[a5_1cov,chi2cov(5,1)]=MMQpolcov(dadosx1, dadosy1, V1, 5);    [a5_2cov,chi2cov(5,2)]=MMQpolcov(dadosx2, dadosy2, V2, 5);    [a5_3cov,chi2cov(5,3)]=MMQpolcov(dadosx3, dadosy3, V3, 5);    [a5_4cov,chi2cov(5,4)]=MMQpolcov(dadosx4, dadosy4, V4, 5);
[a6_1cov,chi2cov(6,1)]=MMQpolcov(dadosx1, dadosy1, V1, 6);    [a6_2cov,chi2cov(6,2)]=MMQpolcov(dadosx2, dadosy2, V2, 6);    [a6_3cov,chi2cov(6,3)]=MMQpolcov(dadosx3, dadosy3, V3, 6);    [a6_4cov,chi2cov(6,4)]=MMQpolcov(dadosx4, dadosy4, V4, 6);
[a7_1cov,chi2cov(7,1)]=MMQpolcov(dadosx1, dadosy1, V1, 7);    [a7_2cov,chi2cov(7,2)]=MMQpolcov(dadosx2, dadosy2, V2, 7);    [a7_3cov,chi2cov(7,3)]=MMQpolcov(dadosx3, dadosy3, V3, 7);    [a7_4cov,chi2cov(7,4)]=MMQpolcov(dadosx4, dadosy4, V4, 7);

%bloco que prepara vaiáveis para teste z
paramcov = zeros(7,4);                                                        %Guarda valores das constantes multiplicaitvas dos monômios de maior grau ajustado
paramcov=[ a1_1cov(2,1)    a1_2cov(2,1)    a1_3cov(2,1)    a1_4cov(2,1);
           a2_1cov(3,1)    a2_2cov(3,1)    a2_3cov(3,1)    a2_4cov(3,1);
           a3_1cov(4,1)    a3_2cov(4,1)    a3_3cov(4,1)    a3_4cov(4,1);
           a4_1cov(5,1)    a4_2cov(5,1)    a4_3cov(5,1)    a4_4cov(5,1);
           a5_1cov(6,1)    a5_2cov(5,1)    a5_3cov(6,1)    a5_4cov(6,1);
           a6_1cov(7,1)    a6_2cov(7,1)    a6_3cov(7,1)    a6_4cov(7,1);
           a7_1cov(8,1)    a7_2cov(8,1)    a7_3cov(8,1)    a7_4cov(8,1)];
paraminccov = zeros(7,4);                                                     %Guarda as incertezas das constantes multiplicaitvas dos monômios de maior grau ajustado
paraminccov=[ a1_1cov(2,2)    a1_2cov(2,2)    a1_3cov(2,2)    a1_4cov(2,2);
              a2_1cov(3,2)    a2_2cov(3,2)    a2_3cov(3,2)    a2_4cov(3,2);
              a3_1cov(4,2)    a3_2cov(4,2)    a3_3cov(4,2)    a3_4cov(4,2);
              a4_1cov(5,2)    a4_2cov(5,2)    a4_3cov(5,2)    a4_4cov(5,2);
              a5_1cov(6,2)    a5_2cov(5,2)    a5_3cov(6,2)    a5_4cov(6,2);
              a6_1cov(7,2)    a6_2cov(7,2)    a6_3cov(7,2)    a6_4cov(7,2);
              a7_1cov(8,2)    a7_2cov(8,2)    a7_3cov(8,2)    a7_4cov(8,2)];
         
%Bloco que calcula valor do teste z supondo constante do monômio de maior grau = 0 e dados covariantes
zresultcov=zeros(7,4);
valorzcov=zeros(7,4);
for i=1:7
    for j=1:4
        h = ztest( paramcov(i,j),0,paraminccov(i,j)^(1/2));                            %Efetua o teste z para parâmetro = 0 dentro da incerteza alfa=5%
        valorzcov(i,j)=paramcov(i,j)/(paramcov(i,j)^(1/2));
        zresultcov(i,j)=h;                                                    %Guarda resultados do teste z
    end
end

%Bloco que determina grau do polinômio a se ajustar
graucov=[1 1 1 1];
for i=1:7
    for j=1:4
        if zresultcov(i,j)==1;
        graucov(1,j)=i;
        end
    end
end








%Bloco que determina ´arquivo com menor número de linhas
nmin=n_linhas(1,1);
for i=2:4
    if n_linhas(i,i)<nmin
        nmin=n_linhas(i,1);
    end
end


%Bloco que calcula o comprimento instantâneo "L", o deslocamento "desloc" e a retração instantânea "rinst" corrigidos para cada curva
L1=zeros(n_linhas(1,1),1);  desloc1=zeros(n_linhas(1,1),1);  rinst1=zeros(n_linhas(1,1),1);  
L2=zeros(n_linhas(2,1),1);  desloc2=zeros(n_linhas(2,1),1);  rinst2=zeros(n_linhas(2,1),1);  
L3=zeros(n_linhas(3,1),1);  desloc3=zeros(n_linhas(3,1),1);  rinst3=zeros(n_linhas(3,1),1);  
L4=zeros(n_linhas(4,1),1);  desloc4=zeros(n_linhas(4,1),1);  rinst4=zeros(n_linhas(4,1),1);  
for i=1:n_linhas(1,1)
    L1(i,1)=inicial(1,1)+curva1(i,3);                         %Comprimento instantâneo
    L1(i,2)=(inicial(1,2)^2+curva1(i,4)^2)^(1/2);
    creep(i,1)=curva1(i,3)/inicial(1,1);                                 %Deslocamento
    creepinst1(i,1)=curva1(i,1)/L1(i,1);                                      %Retração instantânea
end
for i=1:n_linhas(2,1)
    L2(i,1)=curva2(i,3)*inicial(2,1)+inicial(2,1);                         %Comprimento instantâneo
    desloc2(i,1)=curva2(i,3)*inicial(2,1);                                 %Deslocamento
    rinst2(i,1)=desloc2(i,1)/L2(i,1);                                      %Retração instantânea
end
for i=1:n_linhas(3,1)
    L3(i,1)=curva3(i,3)*inicial(3,1)+inicial(3,1);                         %Comprimento instantâneo
    desloc3(i,1)=curva3(i,3)*inicial(3,1);                                 %Deslocamento
    rinst3(i,1)=desloc3(i,1)/L3(i,1);                                      %Retração instantânea
end
for i=1:n_linhas(4,1)
    L4(i,1)=curva4(i,3)*inicial(4,1)+inicial(4,1);                         %Comprimento instantâneo
    desloc4(i,1)=curva4(i,3)*inicial(4,1);                                 %Deslocamento
    rinst4(i,1)=desloc4(i,1)/L4(i,1);                                      %Retração instantânea
end


%Bloco que calcula variáveis auxiliares para determinação de incerteza das derivadas
%tempo i,i-2                    Temperatura i,i-2                 
auxt1=zeros(n_linhas(1,1),2);  auxT1=zeros(n_linhas(1,1),2);
auxt2=zeros(n_linhas(2,1),2);  auxT2=zeros(n_linhas(2,1),2);
auxt3=zeros(n_linhas(3,1),2);  auxT3=zeros(n_linhas(3,1),2);
auxt4=zeros(n_linhas(4,1),2);  auxT4=zeros(n_linhas(4,1),2);
for i=3:n_linhas(1,1)
    auxt1(i,1)=curva1(i,4)/(curva1(i,1)-curva1(i-2,1));
    auxt1(i,2)=-curva1((i-2),4)/(curva1(i,1)-curva1(i-2,1));
    auxT1(i,1)=curva1(i,4)/(curva1(i,2)-curva1(i-2,2));
    auxT1(i,2)=-curva1((i-2),4)/(curva1(i,2)-curva1(i-2,2));
end
for i=3:n_linhas(2,1)
    auxt2(i,1)=curva2(i,4)/(curva2(i,1)-curva2(i-2,1));
    auxt2(i,2)=-curva2((i-2),4)/(curva2(i,1)-curva2(i-2,1));
    auxT2(i,1)=curva2(i,4)/(curva2(i,2)-curva2(i-2,2));
    auxT2(i,2)=-curva2((i-2),4)/(curva2(i,2)-curva2(i-2,2));
end
for i=3:n_linhas(3,1)
    auxt3(i,1)=curva3(i,4)/(curva3(i,1)-curva3(i-2,1));
    auxt3(i,2)=-curva3((i-2),4)/(curva3(i,1)-curva3(i-2,1));
    auxT3(i,1)=curva3(i,4)/(curva3(i,2)-curva3(i-2,2));
    auxT3(i,2)=-curva3((i-2),4)/(curva3(i,2)-curva3(i-2,2));
end
for i=3:n_linhas(4,1)
    auxt4(i,1)=curva4(i,4)/(curva4(i,1)-curva4(i-2,1));
    auxt4(i,2)=-curva4((i-2),4)/(curva4(i,1)-curva4(i-2,1));
    auxT4(i,1)=curva4(i,4)/(curva4(i,2)-curva4(i-2,2));
    auxT4(i,2)=-curva4((i-2),4)/(curva4(i,2)-curva4(i-2,2));
end


%Bloco que calcula a derivada da retração linear em função do tempo e temperatura e suas incertezas
deriva1=zeros(n_linhas(1,1)-1,4);
deriva2=zeros(n_linhas(2,1)-1,4);
deriva3=zeros(n_linhas(3,1)-1,4);
deriva4=zeros(n_linhas(4,1)-1,4);                                               %Derivadas da retração linear - 1coluna *Tempo, 3coluna *Temperatura, Incertezas
for i=3:n_linhas(1,1)
    deriva1(i-1,1)=(curva1(3,i)-curva1(3,i-2))/(curva1(1,i)-curva1(1,i-2));     %Deriva curva1 em relação ao tempo
    deriva1(i-1,3)=(curva1(3,i)-curva1(3,i-2))/(curva1(2,i)-curva1(2,i-2));     %Deriva curva1 em relação a temperatura
    deriva2(i-1,1)=(curva2(3,i)-curva2(3,i-2))/(curva2(1,i)-curva2(1,i-2));     %Deriva curva2 em relação ao tempo
    deriva2(i-1,3)=(curva2(3,i)-curva2(3,i-2))/(curva2(2,i)-curva2(2,i-2));     %Deriva curva2 em relação a temperatura
    deriva3(i-1,1)=(curva3(3,i)-curva3(3,i-2))/(curva3(1,i)-curva3(1,i-2));     %Deriva curva3 em relação ao tempo
    deriva3(i-1,3)=(curva3(3,i)-curva3(3,i-2))/(curva3(2,i)-curva3(2,i-2));     %Deriva curva3 em relação a temperatura
    deriva4(i-1,1)=(curva4(3,i)-curva4(3,i-2))/(curva4(1,i)-curva4(1,i-2));     %Deriva curva4 em relação ao tempo
    deriva4(i-1,3)=(curva4(3,i)-curva4(3,i-2))/(curva4(2,i)-curva4(2,i-2));     %Deriva curva4 em relação a temperatura
    deriva1(i-1,2)=(auxt1(i,1)^2+auxt1(i,2)^2+2*auxt1(i,1)*auxt1(i,2))^(1/2);   %incerteza deriva em relação ao tempo
    deriva1(i-1,4)=(auxT1(i,1)^2+auxT1(i,2)^2+2*auxT1(i,1)*auxT1(i,2))^(1/2);   %incerteza deriva em relação a temperatura
    deriva2(i-1,2)=(auxt2(i,1)^2+auxt2(i,2)^2+2*auxt2(i,1)*auxt2(i,2))^(1/2);   %incerteza deriva em relação ao tempo
    deriva2(i-1,4)=(auxT2(i,1)^2+auxT2(i,2)^2+2*auxT2(i,1)*auxT2(i,2))^(1/2);   %incerteza deriva em relação a temperatura
    deriva3(i-1,2)=(auxt3(i,1)^2+auxt3(i,2)^2+2*auxt3(i,1)*auxt3(i,2))^(1/2);   %incerteza deriva em relação ao tempo
    deriva3(i-1,4)=(auxT3(i,1)^2+auxT3(i,2)^2+2*auxT3(i,1)*auxT3(i,2))^(1/2);   %incerteza deriva em relação a temperatura
    deriva4(i-1,2)=(auxt4(i,1)^2+auxt4(i,2)^2+2*auxt4(i,1)*auxt4(i,2))^(1/2);   %incerteza deriva em relação ao tempo
    deriva4(i-1,4)=(auxT4(i,1)^2+auxT4(i,2)^2+2*auxT4(i,1)*auxT4(i,2))^(1/2);   %incerteza deriva em relação a temperatura
end


%Bloco que calcula as curvas das derivadas após smoothing (Adjacent average) e suas incertezas

