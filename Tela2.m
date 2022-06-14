function Tela2()

SystemSetUp                                                                %Configura o path
Tela= TelaClass;                                                           %Reserva de mem�ria para vari�vel Tela

%Cria a tela
Tela.CriaTela;                                                             %Cria a Tela Principal
Tela.CriaToolbar;                                                          %Cria as ferramentas na regi�o superior do figure
Tela.Layout2;                                                              %Cria o Layout do m�dulo 2
Tela.MakeCorArray;                                                         %Cria a sequ�ncia de cores utilizada no programa
Tela.ProfilePanelComp;                                                     %Cria os componentes do Profile Panel
Tela.AbaDataComp;                                                          %Cria os componentes da Aba Data
Tela.AbaStrainComp;                                                        %Cria os componentes da Aba Strain
Tela.GraphControl;                                                         %Cria os componentes do controle do gr�fico
Tela.CreateGraph;                                                          %Cria os componentes do axes
Tela.AbaCalculusComp;                                                      %Cria os componentes da Aba Calculus
Tela.AbaUncertaintyComp;                                                   %Cria os componentes da Aba Uncertainty
Tela.AbaArrheniusComp;                                                     %Cria os componentes da Aba Arrhenius
Tela.AbaMSCComp;                                                           %Cria os componentes da Aba MSC
Tela.AbaAnalysisComp;                                                      %Cria os componentes da Aba Export


end
