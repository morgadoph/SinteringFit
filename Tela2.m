function Tela2()

SystemSetUp                                                                %Configura o path
Tela= TelaClass;                                                           %Reserva de memória para variável Tela

%Cria a tela
Tela.CriaTela;                                                             %Cria a Tela Principal
Tela.CriaToolbar;                                                          %Cria as ferramentas na região superior do figure
Tela.Layout2;                                                              %Cria o Layout do módulo 2
Tela.MakeCorArray;                                                         %Cria a sequência de cores utilizada no programa
Tela.ProfilePanelComp;                                                     %Cria os componentes do Profile Panel
Tela.AbaDataComp;                                                          %Cria os componentes da Aba Data
Tela.AbaStrainComp;                                                        %Cria os componentes da Aba Strain
Tela.GraphControl;                                                         %Cria os componentes do controle do gráfico
Tela.CreateGraph;                                                          %Cria os componentes do axes
Tela.AbaCalculusComp;                                                      %Cria os componentes da Aba Calculus
Tela.AbaUncertaintyComp;                                                   %Cria os componentes da Aba Uncertainty
Tela.AbaArrheniusComp;                                                     %Cria os componentes da Aba Arrhenius
Tela.AbaMSCComp;                                                           %Cria os componentes da Aba MSC
Tela.AbaAnalysisComp;                                                      %Cria os componentes da Aba Export


end
