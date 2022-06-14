%Função que determina a energia de ativação e a posição da matriz com menor
%RMS possível dentre os ajustes mantendo Q fixo. A função ignora as linhas 
%vazias com Q=0;

%Variáveis de entrada
%Curva_res - Matriz com duas colunas (Q RMS)

%Variáveis de saída
%imenor - Linhas com dados do melhor ajuste
%Qmenor - Energia de ativação que produz melhor ajuste

function [imenor,Qmenor]=Determina_menor (Curva_res, imax)

%Bloco que inicializa variáveis iniciais
imenor=1;
Resmenor=Curva_res(1,2);
aux=imax-1;

%Bloco que busca menor RMS e atualiza imenor e Qmenor
for i=2:aux
    aux=Curva_res(i,2)-Resmenor;                                             %Variável auxiliar que calcula diferença entre RMS dos ajustes
    if aux<0 && Curva_res(i,1)~=0
        imenor=i;
        Resmenor=Curva_res(i,2);
    end
end

Qmenor=Curva_res(imenor,1);
end
        