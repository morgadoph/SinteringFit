%Fun��o que determina a energia de ativa��o e a posi��o da matriz com menor
%RMS poss�vel dentre os ajustes mantendo Q fixo. A fun��o ignora as linhas 
%vazias com Q=0;

%Vari�veis de entrada
%Curva_res - Matriz com duas colunas (Q RMS)

%Vari�veis de sa�da
%imenor - Linhas com dados do melhor ajuste
%Qmenor - Energia de ativa��o que produz melhor ajuste

function [imenor,Qmenor]=Determina_menor (Curva_res, imax)

%Bloco que inicializa vari�veis iniciais
imenor=1;
Resmenor=Curva_res(1,2);
aux=imax-1;

%Bloco que busca menor RMS e atualiza imenor e Qmenor
for i=2:aux
    aux=Curva_res(i,2)-Resmenor;                                             %Vari�vel auxiliar que calcula diferen�a entre RMS dos ajustes
    if aux<0 && Curva_res(i,1)~=0
        imenor=i;
        Resmenor=Curva_res(i,2);
    end
end

Qmenor=Curva_res(imenor,1);
end
        