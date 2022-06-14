function [dados] = interpolacao (data)
                    %Função que interpola dados de uma função de correção no intervalo de
                    %dados. Os valores de correção para fora do intervalo de medida são dados
                    %pelo ajuste polinomial de terceiro grau feito aos dados.

                    %Variáveis de entrada
                    %Data - Função com os valores de correção

                    %Variáveis de saída
                    %dados - Arquivo de correção


                    %Bloco que organiza as linhas em ordem crescente e elimina dados com mesmo x
                    data = sortrows(data);                                  
                    ndados=size(data);
                    if ndados(1,2)==2
                        aux= (data(2,2)-data(1,2))*ones(ndados(1,1),1);
                        data=[data aux];
                    end
                    i=2;
                    while i<=ndados(1)
                        if data(i,1)==data(i-1,1)
                            data(i,:)=[];
                            ndados=size(data);
                        end
                        i=i+1;
                    end

                    %Bloco que interpola dados dentro do intervalo dos dados fornecidos
                    iaux=ceil(data(1,1));
                    iaux2=fix(data(ndados(1),1));
                    dados=zeros(1600,1);
                    for i=1:1600
                        dados(i)=i;
                    end
                    dados(iaux:iaux2,2)= interp1(data(:,1),data(:,2),dados(iaux:iaux2),'spline');
                    dados(iaux:iaux2,3)= interp1(data(:,1),data(:,3),dados(iaux:iaux2),'spline');

                    %Bloco que ajusta os dados iniciais e completa o arquivo de correção com os dados ajustados
                    %//Inserir uma opção na interface que permita escolher o intervalo do ajuste e o grau do polinômio a ajustar
                    T0=550;
                    dadosmmq=[dados(iaux:T0,1) dados(iaux:T0,2)];
                    grau=3;
                    [a] = MMQlinearpoly (dadosmmq,grau);
                    for i=1:(iaux-1)
                        for j=1:(grau+1)
                            dados(i,2)=a(j)*dados(i,1)^(j-1)+dados(i,2);
                        end
                    end
                    dadosmmq=[dados(iaux:T0,1) dados(iaux:T0,3)];
                    grau=3;
                    [a] = MMQlinearpoly (dadosmmq,grau);
                    for i=1:(iaux-1)
                        for j=1:(grau+1)
                            dados(i,3)=a(j)*dados(i,1)^(j-1)+dados(i,3);
                        end
                    end

                    %Bloco que ajusta os dados finais e completa o arquivo de correção com os dados ajustados
                    %//Inserir uma opção na interface que permita escolher o intervalo do ajuste e o grau do polinômio a ajustar
                    T0=1000;
                    dadosmmq=[dados(T0:iaux2,1) dados(T0:iaux2,2)];
                    grau=1;
                    [a] = MMQlinearpoly (dadosmmq,grau);
                    for i=(iaux2+1):1600
                        for j=1:(grau+1)
                            dados(i,2)=a(j)*dados(i,1)^(j-1)+dados(i,2);
                        end
                    end
                    dadosmmq=[dados(T0:iaux2,1) dados(T0:iaux2,2)];
                    grau=3;
                    [a] = MMQlinearpoly (dadosmmq,grau);
                    for i=(iaux2+1):1600
                        for j=1:(grau+1)
                            dados(i,3)=a(j)*dados(i,1)^(j-1)+dados(i,3);
                        end
                    end

                end
