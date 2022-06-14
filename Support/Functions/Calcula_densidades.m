function [densidades,massacor] = Calcula_densidades (Acor, dens0, massacor)
                %Fun��o que calcula curvas de densidades

                %Vari�veis de entrada
                %Acor - Curvas de deslocamento corrigidas
                %dens0 - Densidades � verde 
                %massacor - Matriz de corre��o de massa

                %Vari�veis de sa�da
                %densidades - densidades corrigidas
                %densifica��o - Curva de densifica��o
                %mcor - matriz com valores de corre��o de massa


                [nlinhas,~]=size(Acor);
                densidades=Acor;
                [mcor] = massacor;
                for j=1:nlinhas
                    densidades(j,3)=mcor(j,1)*(dens0/(1+Acor(j,3))^3);
                end
                
end
            