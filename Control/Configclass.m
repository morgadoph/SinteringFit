classdef Configclass <handle
    %Configura��es e informa��es forncedidas pelo usu�rio atrav�s da
    %interface utilizada nos c�lculos
    
    properties
        Id
        
        %%%%%%%%%%%%%%%%%%%Op��es de corre��o para Shrinkage%%%%%%%%%%%%%%%
        %Corre��o de To
        ToOk                                                               %Verifica se a corre��o est� selecionada
            ToValue                                                        %Valor de To utilizado na corre��o
        
        %Corre��o de Lo
        LoOk                                                               %Verifica se a corre��o de Lo est� selecionada
            LoMethod                                                       %Determina o m�todo escolhido pelo usu�rio para corre��o
                ToLoValue                                                  %Valor inicial da temperatura usado na corre��o                                                        
                TfLoValue                                                  %Valor final da temperatura usado na corre��o
                ReferenceLo                                                %Curva de refer�ncia utilizada na corre��o
        
        %Corre��o da expans�o t�rmica do terminal
        PushRodOk                                                          %Verifica se a corre��o est� selecionada
            PushRodFile                                                    %Arquivo de dados utilizado para corre��o (T corre��o zeros)
            PushRodFileName                                                %Arquivo que guarda o nome do arquivo de dados
        
        %Corre��o da expans�o t�rmica das amostras
        ExpThermOk                                                         %Verifica se a corre��o est� selecionada
            ExpThermFile                                                   %Arquivo de dados utilizado na corre��o (T corre��o CET)
            ExpThermFileName                                               %Arquivo que guarda o nome do arquivo de dados
        
        %M�todo de c�lculo da retra��o    
                DlMethod                                                   %Verifica qual m�todo � utilizado no c�lculo
        
        %%%%%%%%%%%%%%%%%%%Op��es de corre��o para Densities%%%%%%%%%%%%%%%
        %Corre��o da perda de massa para o c�lculo das densidades
        MassOk                                                             %Verifica se a corre��o est� selecionada
            MassMethod                                                     %Determina o m�todo de corre��o
            MassCorrectionFile                                             %Guarda arquivo de corre��o de perda de massa
            MassCorrectionDone
        
        %Informa��es para o c�lculo da densidade
        Denso                                                              %Densidade Inicial
        DensoUncertainty                                                   %Incerteza da densidade inicial
    
        %Op��es para o c�lculo da densidade
        ShrinkageDerivateOk
        DensitiesOk                                                        %Verifica se o c�lculo � feito
            DensitiesDerivateOk                                            %Verifica se o c�lculo � feito
        DensificationOk                                                    %Verifica se o c�lculo � feito
            DensificationDerivateOk                                        %Verifica se o c�lculo � feito
        InstShrinkageOk                                                    %Verifica se o c�lculo � feito
            InstShrinkageDerivateOk                                        %Verifica se o c�lculo � feito
            DensityDataOk
            DensityDataFile
            DensityDataName
        
       %%%%%%%%%%%%%%%%%Op��es para o c�lculo das incertezas%%%%%%%%%%%%%%%     
       UncertaintyMethod                                                  %Verifica se o c�lculo � feito, 0 => None ; 1 = Resolution ; 2 = ASTMBased
            Resolution                                                     %Resolu��o do equipamento
            CETFile                                                        %Coeficiente de expans�o t�rmico da amostra
            Stringname
            
       %Op��es para an�lise de Arrhenius
       ArrheniusDataOption
       InitDens
       FinalDens
       StepDens
       
       %Op��es para o c�lculo da MSC
       MSCFunction
       MSCMethod
       MSCFitting
       MSCStages
       MSCInitDens1
       MSCInitDens2
       MSCFinalDens1
       MSCFinalDens2
       MSCEnergy
       SelectionQ
     
    end
    
    methods
        function obj = Configclass
                obj.ToOk = 0;                                                             
                obj.LoOk = 0;                                                           
                obj.PushRodOk = 0;                                                      
                obj.ExpThermOk = 0;                                                
                obj.MassOk = 0;                                           
                obj.ShrinkageDerivateOk = 0;
                obj.DensitiesOk = 0;                                           
                obj.DensitiesDerivateOk = 0;                                  
                obj.DensificationOk = 0;                                
                obj.DensificationDerivateOk = 0;                        
                obj.InstShrinkageOk = 0;                      
                obj.InstShrinkageDerivateOk = 0;
                obj.MassCorrectionDone=0;
                obj.DlMethod=0;
                obj.UncertaintyMethod=0;
                obj.Stringname='';
                obj.DensityDataOk=0;
            
        end
    end
    
end

