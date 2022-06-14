%**************Fun��o que corrigi os valores da retra��o pelo L0*************************

function [dadoscor] = corrigiL0 (dados, n_linhas, correcao, L0, j)

    dadoscor = dados;
    for i=1:n_linhas
        dadoscor(i,3)=(dados(i,3)-correcao(j,1))/(L0(j,1)+correcao(j,1));
        dadoscor(i,4)=((1/(L0(j,1)+correcao(j,1))*dados(i,4))^2+((dadoscor(i,3)-correcao(j,1))/((L0(j,1)+correcao(j,1))^2)*L0(j,2))^2+((dados(i,3)+L0(j,1))/((L0(j,1)+correcao(j,1))^2)*correcao(j,2))^2)^(1/2);
    end
end


