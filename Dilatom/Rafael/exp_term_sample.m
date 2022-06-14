%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fun��o que determina expans�o t�rmica da amostra e j� calcula covari�ncia
%entre dados e par�metros

function [alfasample, Vpdados]=exp_term_sample(dadosx, dadosy, fatores, L0std, aux1L0, aux2L0, param)

%Bloco que prepara vari�veis utilizadas na fun��o
ndados=size(dadosy);
[graut,ncol]=size(fatores);
[graus,ncols]=size(param);
Eterminal=zeros(ndados);
Etotal=zeros(ndados);
Esample=zeros(ndados);

%Bloco que calcula expans�o t�rmica do pushrod
for i=1:ndados
    aux=2*L0std-aux1L0-dadosy(i);
    Et=0;
    for j=1:graut
        Et=Et+fatores(j)*(dadosx(j)-dadosx(ndados))^j;
    end
    Eterminal(i)=Et*aux;
end

%Bloco que calcula expans�o t�rmica total
for i=1:ndados
    Es=0;
    aux=graus-1;
    for j=1:aux
        Es=Es+param(j+1)*(dadosx(i)-dadosx(ndados))^(j+1);
    end
    Etotal(i)=Es;
end

Esample(i)=Etotal(i)-Eterminal(i);


end
