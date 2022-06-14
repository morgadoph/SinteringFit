 classdef MSCClass <handle
    %Estrutura que guarda as informações necessárias para a análise pelo
    %método de MSC
    
    properties
        
        %Função de ajuste e variáveis correlacionadas
        MSCFunction                                                        %Escolha feita pelo usuário da função de ajuste
            PolyGrau                                                           %Grau inicial da varredura do ajuste polinomial caso selecionado
            Function                                                           %Handle da função de ajuste escolhida (caso necessário)
            MSCIniFlag
            exitf
        
        %Estágios de sinterização e variáveis correlacionadas
        MSCStages                                                          %Escolha do usuário entre um ou dois intervalos de ajuste
            MSCInitDens                                                       %Limite inferior do primeiro intervalo de ajuste
            MSCFinalDens                                                      %Limite superior do primeiro intervalo de ajuste
            MSCFinalDens2                                                     %Limite superior do primeiro intervalo de ajuste
            
        %Procedimento de ajuste e variáveis correlacionadas
        MSCFitting                                                         %Escolha do usuário entre varredura de Q ou ajuste de um Q determinado
            SelectionQ                                                         %Valor de Q selecionado pelo usuário caso seja feito o ajuste a um determinado valor
        
        
        %Método utilizado no ajuste final e variáveis correlacionadas
        MSCMethod                                                          %Escolha do usuário se o ajuste é ponderado ou não pelas incertezas
        
        %Dados originais e parâmetros de entrada
        nCurves                                                            %Número de curvas utilizada na construção da curva mestre
        OriginalData                                                       %Dados de (t T Densidade)
        DensificationData                                                  %Dados de (t T Densificação)
        OriginalVcov                                                       %Matriz de covariância dos dados de densidade
        DensificationVcov                                                  %Matriz de covariância dos dados de densificação
        
        %Dados selecionados
        Data                                                              %Dados delimitados pelos limites do primeiro intervalo
        DataVcov                                                          %Matriz de covariância dos dados delimitados pelo primeiro intervalo
        i1
        i2
        i1A
        i2A
        
        %Dados convertidos
        MSCData                                                           %Dados do primeiro intervalo convertidos para as variáveis de ajuste
        MSCData2
        MSCDataVcov                                                       %Matriz de covariância dos dados de ajuste do primeiro intervalo
        MSCDataA                                                           %Dados do primeiro intervalo convertidos para as variáveis de ajuste
        MSCData2A
        
        
        %Dados preparados para o ajuste
        AdjustData                                                        %Dados do primeiro intervalo agregados para ajuste
        AdjustDataVcov                                                    %Matriz de covariância dos dados agregados
        AdjustData2                                                        %Dados do primeiro intervalo agregados para ajuste
        
        
        %Resultados da varredura de Q para o primeiro intervalo
        ResultsScanning                                                   %(Q Resíduo quadrático total) para cada um dos ajustes
        Parameters                                                        %Parâmetros de todos os ajustes realizados utilizando o primeiro intervalo de dados
        Residual                                                          %Resíduo de cada uma das curvas ajustadas
        AuxiliaryResult
        AuxiliaryParameters
        Qmin
        imin
        MSEaux
        Residuoaux
        FinalDegree
        ResultsScanning2                                                   %(Q Resíduo quadrático total) para cada um dos ajustes
        Parameters2                                                        %Parâmetros de todos os ajustes realizados utilizando o primeiro intervalo de dados
        Residual2                                                          %Resíduo de cada uma das curvas ajustadas
        AuxiliaryResult2
        AuxiliaryParameters2
        Qmin2
        imin2
        MSEaux2
        Residuoaux2
        FinalDegree2
        
        
        %Resultados para ajuste a Q selecionado
        FinalResultQ                                                       %(Q Resíduo quadrático total)
        ParametersQ                                                        %Parâmetros do ajuste
        ResidualQ                                                          %Resíduo do ajuste para Q fixo
        
        %Resultados do ajuste final
        GodnessFit                                                         %chi2 reduzido do ajuste final
        ParametersFinal1
        ParametersFinal2
        ParametersFinal                                                    %Parâmetros do ajuste final
        ResultsFinal                                                       %Resultados do ajuste final (RQT Q Incerteza)
        ResidualFinal                                                      %Resíduo do ajuste final
        MSEFinal
        MSCCurve
        UncFinal
        MSCCurve2
        MSCCurveA
        MSC2Final
        MSCCurveFinal
        
        %Variáveis utilizadas na previsão das densidades/perfil de temperaturas
        SinteringMethod                                                    %Determina se a sinterização ocorrerá em uma ou duas etapas (1 ou 2)
        Qanalysis
        
            %Utilizadas para previsão da densidade
            HR12                                                           %Heating Rate da primeira etapa
            DTemp12                                                        %Temperatura de patamar da primeira etapa
            DTime12                                                        %Tempo de patamar da primeira etapa
            HR22                                                           %Heating Rate da segunda etapa
            DTemp22                                                        %Temperatura de patamar da primeira etapa
            DTime22                                                        %Tempo de patamar da segunda etapa
        
        
            %Densidades utilizadas nas previsões
            Dens1                                                          %Densidade da amostra
            Dens2                                                          %Densidade calculada
            Densidadest1
            Densidadest2
            Tetaint
            Tetaol
        
        
    end
    
    methods
       
        function Obj = ApplyMSC (Obj)
           
            if Obj.MSCFitting==1
                Obj.ResetParameters;
                Obj.SelectData;
                Obj.InitialFittingMSC (Obj.SelectionQ);
                Obj.ParametersFinal1=[Obj.SelectionQ;Obj.ParametersQ];
                Obj.ConstructMSC1;
                Obj.MSCIniFlag=0;
                if Obj.MSCStages==2
                    Obj.SelectData2;
                    Obj.ScanningMSC2;
                    Obj.ParametersFinal2 = [Obj.Qmin2;Obj.Parameters2{Obj.imin2}];
                    Obj.ConstructMSC1A;
                    Obj.MSC2Final=Obj.MSCData2;
                    for i=1:Obj.nCurves
                        Obj.MSC2Final{i} = [Obj.MSCData2{i};Obj.MSCData2A{i}];
                    end
                    Obj.MSCCurveFinal=[Obj.MSCCurve2; Obj.MSCCurveA];
                end
            elseif Obj.MSCFitting==2
                Obj.ResetParameters;
                Obj.SelectData;
                Obj.ScanningMSC;
                Obj.ParametersFinal1=[Obj.Qmin;Obj.Parameters{Obj.imin}];
                Obj.ConstructMSC1;
                if Obj.MSCStages==2
                    Obj.SelectData2;
                    Obj.ScanningMSC2;
                    Obj.ParametersFinal2 = [Obj.Qmin2;Obj.Parameters2{Obj.imin2}];
                    Obj.ConstructMSC1A;
                    Obj.MSC2Final=Obj.MSCData2;
                    for i=1:Obj.nCurves
                        Obj.MSC2Final{i} = [Obj.MSCData2{i};Obj.MSCData2A{i}];
                    end
                    Obj.MSCCurveFinal=[Obj.MSCCurve; Obj.MSCCurveA];
                end
                Obj.MSCIniFlag=1;
            else
                Obj.SelectData;
                if Obj.MSCFunction ==2
                    Obj.Determinedegree;
                end
                Obj.FittingFinal;
            end
        end
       
        function Obj = InitialFittingMSC (Obj, Q)
        
            Obj.ConvertData(Q);
            Obj.AgregateData;
            Obj.FittingMSC (Q);
        
        end
        
        function Obj = InitialFittingMSC2 (Obj, Q)
        
            Obj.ConvertDataA(Q);
            Obj.AgregateData2;
            Obj.FittingMSC2 (Q);
        
        end
        
        function Obj = SelectData (Obj)
            Obj.i1=cell(1,Obj.nCurves);
            Obj.i2=cell(1,Obj.nCurves);
            for i=1:Obj.nCurves
                Obj.i1{i} = busca_menordif (Obj.MSCInitDens,Obj.OriginalData{i}(:,3));
                Obj.i2 {i}= busca_menordif (Obj.MSCFinalDens, Obj.OriginalData{i}(:,3));
                Obj.Data{i}=Obj.OriginalData{i};
                if Obj.MSCMethod ==2
                    Obj.DataVcov{i}=Obj.OriginalVcov{i};
                    
                end
            end
            
        end
        
        function Obj = SelectData2 (Obj)
            Obj.i1A=Obj.i2;
            Obj.i2A=cell(1,Obj.nCurves);
            for i=1:Obj.nCurves
                Obj.i1A{i} = Obj.i1A{i}+1;
                Obj.i2A {i}= busca_menordif (Obj.MSCFinalDens2, Obj.OriginalData{i}(:,3));
                Obj.Data{i}=Obj.OriginalData{i};
            end
            
        end
        
        function Obj = ConvertData (Obj, Q)
            
            %Converte dados x para primeiro intervalo de ajuste
            R=8.31447e-3;
            for i=1:Obj.nCurves
            Obj.MSCData{i}=Obj.Data{i};
                ndados= size(Obj.MSCData{i});
                Obj.MSCData{i}(:,2)=Obj.MSCData{i}(:,2)+273.15*ones(ndados(1,1),1);
                soma=0;
                dados=Obj.MSCData{i};
                for k=2:ndados(1)
                    soma=soma+(1/dados(k,2)*exp(-Q/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCData{i}(k,2)=log10(soma);
                end
                Obj.MSCData{i}(1,:)=[];
                Obj.MSCData{i}(:,1)=[];
                aux1=Obj.i1{i}-1;
                if aux1==0
                    aux1=1;
                end
                aux2=Obj.i2{i}-1;
                
                Obj.MSCData{i}=Obj.MSCData{i}(aux1:aux2,:);
            end
            Obj.MSCData = IgualaDadosMSC (Obj.MSCData);
            
        end
        
        function Obj = ConvertDataA (Obj, Q)
            
            %Converte dados x para primeiro intervalo de ajuste
            R=8.31447e-3;
            for i=1:Obj.nCurves
            Obj.MSCDataA{i}=Obj.Data{i};
                ndados= size(Obj.MSCDataA{i});
                Obj.MSCDataA{i}(:,2)=Obj.MSCDataA{i}(:,2)+273.15*ones(ndados(1,1),1);
                soma=0;
                dados=Obj.MSCDataA{i};
                aux3=Obj.i1A{i};
                for k=aux3:ndados(1)
                    soma=soma+(1/dados(k,2)*exp(-Q/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCDataA{i}(k,2)=log10(soma);
                end
                Obj.MSCDataA{i}(1,:)=[];
                Obj.MSCDataA{i}(:,1)=[];
                aux1=Obj.i1A{i}-1;
                if aux1==0
                    aux1=1;
                end
                aux2=Obj.i2A{i}-1;
                
                Obj.MSCDataA{i}=Obj.MSCDataA{i}(aux1:aux2,:);
            end
            Obj.MSCDataA = IgualaDadosMSC (Obj.MSCDataA);
            
        end
        
        function Obj = ConvertData2 (Obj, Q)
            
            %Converte dados x para primeiro intervalo de ajuste
            R=8.31447e-3;
            for i=1:Obj.nCurves
            Obj.MSCData2{i}=Obj.Data{i};
                ndados= size(Obj.MSCData2{i});
                Obj.MSCData2{i}(:,2)=Obj.MSCData2{i}(:,2)+273.15*ones(ndados(1,1),1);
                soma=0;
                dados=Obj.MSCData2{i};
                for k=2:ndados(1)
                    soma=soma+(1/dados(k,2)*exp(-Q/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCData2{i}(k,2)=log10(soma);
                end
                Obj.MSCData2{i}(1,:)=[];
                Obj.MSCData2{i}(:,1)=[];
                aux1=Obj.i1{i}-1;
                if aux1==0
                    aux1=1;
                end
                aux2=Obj.i2{i}-1;
                
                Obj.MSCData2{i}=Obj.MSCData2{i}(aux1:aux2,:);
            end
            Obj.MSCData2 = IgualaDadosMSC (Obj.MSCData2);
            
        end
        
        function Obj = ConvertData2A (Obj, Q)
            
            %Converte dados x para primeiro intervalo de ajuste
            R=8.31447e-3;
            for i=1:Obj.nCurves
            Obj.MSCData2A{i}=Obj.Data{i};
                ndados= size(Obj.MSCData2A{i});
                Obj.MSCData2A{i}(:,2)=Obj.MSCData2A{i}(:,2)+273.15*ones(ndados(1,1),1);
                soma=0;
                dados=Obj.MSCData2A{i};
                aux3=Obj.i1A{i};
                
                for k=2:aux3
                    soma=soma+(1/dados(k,2)*exp(-Obj.ParametersFinal1(1,1)/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Obj.ParametersFinal1(1,1)/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Obj.ParametersFinal1(1,1)/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCData2A{i}(k,2)=log10(soma);
                end
                Obj.Tetaint=soma;
                for k=aux3:ndados(1)
                    soma=soma+(1/dados(k,2)*exp(-Q/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCData2A{i}(k,2)=log10(soma);
                end
                Obj.MSCData2A{i}(1,:)=[];
                Obj.MSCData2A{i}(:,1)=[];
                aux1=Obj.i1A{i}-1;
                if aux1==0
                    aux1=1;
                end
                aux2=Obj.i2A{i}-1;
                
                Obj.MSCData2A{i}=Obj.MSCData2A{i}(aux1:aux2,:);
            end
            Obj.MSCData2A = IgualaDadosMSC (Obj.MSCData2A);
            
        end
        
        function Obj = ConvertData3A (Obj, Q)
            
            %Converte dados x para primeiro intervalo de ajuste
            R=8.31447e-3;
            for i=1:Obj.nCurves
            Obj.MSCData2A{i}=Obj.Data{i};
                ndados= size(Obj.MSCData2A{i});
                Obj.MSCData2A{i}(:,2)=Obj.MSCData2A{i}(:,2)+273.15*ones(ndados(1,1),1);
                soma=0;
                dados=Obj.MSCData2A{i};
                aux3=Obj.i1A{i};
                
                for k=2:aux3
                    soma=soma+(1/dados(k,2)*exp(-Obj.ParametersFinal1(1,1)/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Obj.ParametersFinal1(1,1)/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Obj.ParametersFinal1(1,1)/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCData2A{i}(k,2)=log10(soma);
                end
                if i==1
                    Obj.MSCCurveA(:,1) = log10((10.^(Obj.MSCCurveA(:,1)))+soma*ones(size(Obj.MSCCurveA(:,1))));
                end
                for k=aux3:ndados(1)
                    soma=soma+(1/dados(k,2)*exp(-Q/(R*dados(k,2)))+1/dados(k-1,2)*exp(-Q/(R*dados(k-1,2)))+4/(dados(k,2)+dados(k-1,2))/2*exp(-Q/(R*(dados(k,2)+dados(k-1,2))/2)))/6*(dados(k,1)-dados(k-1,1));
                    Obj.MSCData2A{i}(k,2)=log10(soma);
                end
                Obj.MSCData2A{i}(1,:)=[];
                Obj.MSCData2A{i}(:,1)=[];
                aux1=Obj.i1A{i}-1;
                if aux1==0
                    aux1=1;
                end
                aux2=Obj.i2A{i}-1;
                
                Obj.MSCData2A{i}=Obj.MSCData2A{i}(aux1:aux2,:);
            end
            Obj.MSCData2A = IgualaDadosMSC (Obj.MSCData2A);
            
        end
        
        function Obj = AgregateData (Obj)
            
            ndadostotal1=0;
            ndados=cell(Obj.nCurves,1);
            for i=1:Obj.nCurves
                ndados{i}=size(Obj.MSCData{i});
                ndadostotal1=ndadostotal1+ndados{i};
            end
            
            Obj.AdjustData=zeros(ndadostotal1(1,1),2);
            naux2=0;
            for i=1:Obj.nCurves
                naux1=1+naux2;
                naux2=naux2+ndados{i}(1,1);
                Obj.AdjustData(naux1:naux2,:)=Obj.MSCData{i};
            end
            
        end
        
        function Obj = AgregateData2 (Obj)
            
            ndadostotal1=0;
            ndados=cell(Obj.nCurves,1);
            for i=1:Obj.nCurves
                ndados{i}=size(Obj.MSCDataA{i});
                ndadostotal1=ndadostotal1+ndados{i};
            end
            
            Obj.AdjustData2=zeros(ndadostotal1(1,1),2);
            naux2=0;
            for i=1:Obj.nCurves
                naux1=1+naux2;
                naux2=naux2+ndados{i}(1,1);
                Obj.AdjustData2(naux1:naux2,:)=Obj.MSCDataA{i};
            end
            
        end
        
        function Obj = FittingMSC (Obj,Q)
           
            if Obj.MSCFunction ==1
                Obj.Function=@sigmoidal;
                xmeio=Determina_meio (Obj.AdjustData(:,1));
                x0=[Obj.AdjustData(1,2);xmeio;1];
                [Parametros]= nlinfit2(Obj.AdjustData(:,1), Obj.AdjustData(:,2), Obj.Function, x0);
                Obj.RegressionAnalysis (Parametros);
                nparam=4;
            elseif Obj.MSCFunction==2
                [Parametros,~,m1]=polyfit(Obj.AdjustData(:,1), Obj.AdjustData(:,2),Obj.PolyGrau);
                [Parametros]=ScaleBackParameters(Parametros,m1);
                Parametros=Parametros';
                Obj.RegressionAnalysis (Parametros);
                nparam=Obj.PolyGrau+2;
            else
                errordlg('Invalid interface options','Warning','modal');
                uicontrol(hObject);
                return;
            end
            
                ndados=size(Obj.AdjustData);
                ndados=ndados(1,1);
              
            if Obj.MSCFitting==1
                
                Obj.FinalResultQ=[Q Obj.MSEaux];
                Obj.ParametersQ=Parametros;
                Obj.ResidualQ=Obj.Residuoaux;
                Obj.GodnessFit=0;
                for i=1:Obj.nCurves
                    Obj.GodnessFit=Obj.GodnessFit+(Obj.ResidualQ{i}'*Obj.ResidualQ{i});
                end
                Obj.GodnessFit = Obj.GodnessFit/(ndados-nparam);
                Obj.UncFinal=0;
                Obj.ParametersFinal=Obj.ParametersQ;
            else
                Obj.AuxiliaryResult=[Q Obj.MSEaux];
                Obj.AuxiliaryParameters=Parametros;
            end
               
            
        end
        
        function Obj = FittingMSC2 (Obj,Q)
           
            if Obj.MSCFunction ==1
                Obj.Function=@sigmoidal;
                xmeio=Determina_meio (Obj.AdjustData2(:,1));
                x0=[Obj.AdjustData2(1,2);xmeio;1];
                [Parametros]= nlinfit2(Obj.AdjustData2(:,1), Obj.AdjustData2(:,2), Obj.Function, x0);
                Obj.RegressionAnalysis2 (Parametros);
            elseif Obj.MSCFunction==2
                [Parametros,~,m1]=polyfit(Obj.AdjustData2(:,1), Obj.AdjustData2(:,2),Obj.PolyGrau);
                [Parametros]=ScaleBackParameters(Parametros,m1);
                Parametros=Parametros';
                Obj.RegressionAnalysis2 (Parametros);
            else
                errordlg('Invalid interface options','Warning','modal');
                uicontrol(hObject);
                return;
            end
            
            Obj.AuxiliaryResult2=[Q Obj.MSEaux2];
            Obj.AuxiliaryParameters2=Parametros;
               
            
        end
        
        function Obj = RegressionAnalysis (Obj, Parametros)
            
            Dados=cell(Obj.nCurves,1);
            Obj.Residuoaux=cell(1,Obj.nCurves);
            ndados= size(Obj.AdjustData);
            ndados=ndados(1,1);
            
            for i=1:Obj.nCurves
                if Obj.MSCFunction ==1
                    Dados{i}= sigmoidal (Parametros,Obj.MSCData{i}(:,1));
                else
                    Dados{i}= polinomial (Parametros,Obj.MSCData{i}(:,1));
                end
            end
            
            Obj.MSEaux=0;
            for i=1:Obj.nCurves
                Obj.Residuoaux{1,i}=Obj.MSCData{i}(:,2)-Dados{i};
                Obj.MSEaux=Obj.MSEaux+(Obj.Residuoaux{1,i})'*Obj.Residuoaux{1,i};
            end
            nparam=size(Parametros);
            nparam=nparam(1,1);
            Obj.MSEaux=Obj.MSEaux/(ndados-nparam);
            
        end
        
        function Obj = RegressionAnalysis2 (Obj, Parametros)
            
            Dados=cell(Obj.nCurves,1);
            Obj.Residuoaux2=cell(1,Obj.nCurves);
            ndados= size(Obj.AdjustData2);
            ndados=ndados(1,1);
            
            for i=1:Obj.nCurves
                if Obj.MSCFunction ==1
                    Dados{i}= sigmoidal (Parametros,Obj.MSCDataA{i}(:,1));
                else
                    Dados{i}= polinomial (Parametros,Obj.MSCDataA{i}(:,1));
                end
            end
            
            Obj.MSEaux2=0;
            for i=1:Obj.nCurves
                Obj.Residuoaux2{1,i}=Obj.MSCDataA{i}(:,2)-Dados{i};
                Obj.MSEaux2=Obj.MSEaux2+(Obj.Residuoaux2{1,i})'*Obj.Residuoaux2{1,i};
            end
            nparam=size(Parametros);
            nparam=nparam(1,1);
            Obj.MSEaux2=Obj.MSEaux2/(ndados-nparam);
            
        end
        
        function Obj = SortScan (Obj)
            
            Q=Obj.ResultsScanning(:,1);
            ndados=size(Q);
            ndados=ndados(1,1);
            Ordem=zeros(ndados,1);
            for i=1:ndados
                imenor=1;
                ndados2=size(Q);
                ndados2=ndados2(1,1);
                k=1;
                while k<=ndados2
                    if Q(k)<Q(imenor)
                        imenor=k;
                    end
                    k=k+1;
                end
                Ordem(i)=imenor;
                Q(imenor)=[];
            end
            
            aux1=Obj.ResultsScanning;
             aux2=Obj.ResultsScanning;
            for i=1:ndados
                aux2(i,:)=aux1(Ordem(i),:);
                aux1(Ordem(i),:)=[];
            end
            Obj.ResultsScanning=aux2;
            
            aux1=Obj.Residual;
            aux2=Obj.Residual;
            for i=1:ndados
                aux2{i}=aux1{Ordem(i)};
                aux1(Ordem(i),:)=[];
            end
            Obj.Residual=aux2;
            
            
        end
        
        function Obj = SortScan2 (Obj)
            
            Q=Obj.ResultsScanning2(:,1);
            ndados=size(Q);
            ndados=ndados(1,1);
            Ordem=zeros(ndados,1);
            for i=1:ndados
                imenor=1;
                ndados2=size(Q);
                ndados2=ndados2(1,1);
                k=1;
                while k<=ndados2
                    if Q(k)<Q(imenor)
                        imenor=k;
                    end
                    k=k+1;
                end
                Ordem(i)=imenor;
                Q(imenor)=[];
            end
            
            aux1=Obj.ResultsScanning2;
             aux2=Obj.ResultsScanning2;
            for i=1:ndados
                aux2(i,:)=aux1(Ordem(i),:);
                aux1(Ordem(i),:)=[];
            end
            Obj.ResultsScanning2=aux2;
            
            aux1=Obj.Residual2;
            aux2=Obj.Residual2;
            for i=1:ndados
                aux2{i}=aux1{Ordem(i)};
                aux1(Ordem(i),:)=[];
            end
            Obj.Residual2=aux2;
            
            
        end
        
        function Obj = ScanningMSC (Obj)
           
            %Inicialização de variáveis
            i=1;
            Obj.ResultsScanning=zeros(125,2);
            Obj.Parameters=cell(125,1);
            Obj.Residual = cell(125,Obj.nCurves);
            Obj.Parameters = cell(125,1);
            
            %Primeira varredura
            for Q=100:50:5000
                Obj.InitialFittingMSC (Q);
                Obj.ResultsScanning(i,:)=Obj.AuxiliaryResult;
                Obj.Parameters{i}=Obj.AuxiliaryParameters;
                Obj.Residual{i}=Obj.Residuoaux;
                i=i+1;
            end
            
            %Segundo loop
            [~,Qmenor]=Determina_menor (Obj.ResultsScanning,i);
            Qaux1=Qmenor-40;
            Qaux2=Qmenor-5;
            for Q=Qaux1:5:Qaux2
                Obj.InitialFittingMSC (Q);
                Obj.ResultsScanning(i,:)=Obj.AuxiliaryResult;
                Obj.Parameters{i}=Obj.AuxiliaryParameters;
                Obj.Residual{i}=Obj.Residuoaux;
                i=i+1;
            end
            Qaux1=Qmenor+5;
            Qaux2=Qmenor+40;
            for Q=Qaux1:5:Qaux2
                Obj.InitialFittingMSC (Q);
                Obj.ResultsScanning(i,:)=Obj.AuxiliaryResult;
                Obj.Parameters{i}=Obj.AuxiliaryParameters;
                Obj.Residual{i}=Obj.Residuoaux;
                i=i+1;
            end
            
            %Terceiro Loop
            [~,Qmenor]=Determina_menor (Obj.ResultsScanning,i);
            Qaux1=Qmenor-5;
            Qaux2=Qmenor-1;
            for Q=Qaux1:1:Qaux2
                Obj.InitialFittingMSC (Q);
                Obj.ResultsScanning(i,:)=Obj.AuxiliaryResult;
                Obj.Parameters{i}=Obj.AuxiliaryParameters;
                Obj.Residual{i}=Obj.Residuoaux;
                i=i+1;
            end
            Qaux1=Qmenor+1;
            Qaux2=Qmenor+5;
            for Q=Qaux1:1:Qaux2
                Obj.InitialFittingMSC (Q);
                Obj.ResultsScanning(i,:)=Obj.AuxiliaryResult;
                Obj.Parameters{i}=Obj.AuxiliaryParameters;
                Obj.Residual{i}=Obj.Residuoaux;
                i=i+1;
            end
            
            [Obj.imin,Obj.Qmin]=Determina_menor (Obj.ResultsScanning,i-1);
            Obj.SortScan;
            
        end
        
        function Obj = ScanningMSC2 (Obj)
        %Inicialização de variáveis
            i=1;
            Obj.ResultsScanning2=zeros(125,2);
            Obj.Parameters2=cell(125,1);
            Obj.Residual2 = cell(125,Obj.nCurves);
            Obj.Parameters2 = cell(125,1);
            
            %Primeira varredura
            for Q=100:50:5000
                Obj.InitialFittingMSC2 (Q);
                Obj.ResultsScanning2(i,:)=Obj.AuxiliaryResult2;
                Obj.Parameters2{i}=Obj.AuxiliaryParameters2;
                Obj.Residual2{i}=Obj.Residuoaux2;
                i=i+1;
            end
            
            %Segundo loop
            [~,Qmenor]=Determina_menor (Obj.ResultsScanning2,i);
            Qaux1=Qmenor-40;
            Qaux2=Qmenor-5;
            for Q=Qaux1:5:Qaux2
                Obj.InitialFittingMSC2 (Q);
                Obj.ResultsScanning2(i,:)=Obj.AuxiliaryResult2;
                Obj.Parameters2{i}=Obj.AuxiliaryParameters2;
                Obj.Residual2{i}=Obj.Residuoaux2;
                i=i+1;
            end
            Qaux1=Qmenor+5;
            Qaux2=Qmenor+40;
            for Q=Qaux1:5:Qaux2
                Obj.InitialFittingMSC2 (Q);
                Obj.ResultsScanning2(i,:)=Obj.AuxiliaryResult2;
                Obj.Parameters2{i}=Obj.AuxiliaryParameters2;
                Obj.Residual2{i}=Obj.Residuoaux2;
                i=i+1;
            end
            
            %Terceiro Loop
            [~,Qmenor]=Determina_menor (Obj.ResultsScanning2,i);
            Qaux1=Qmenor-5;
            Qaux2=Qmenor-1;
            for Q=Qaux1:1:Qaux2
                Obj.InitialFittingMSC2 (Q);
                Obj.ResultsScanning2(i,:)=Obj.AuxiliaryResult2;
                Obj.Parameters2{i}=Obj.AuxiliaryParameters2;
                Obj.Residual2{i}=Obj.Residuoaux2;
                i=i+1;
            end
            Qaux1=Qmenor+1;
            Qaux2=Qmenor+5;
            for Q=Qaux1:1:Qaux2
                Obj.InitialFittingMSC2 (Q);
                Obj.ResultsScanning2(i,:)=Obj.AuxiliaryResult2;
                Obj.Parameters2{i}=Obj.AuxiliaryParameters2;
                Obj.Residual2{i}=Obj.Residuoaux2;
                i=i+1;
            end
            
            [Obj.imin2,Obj.Qmin2]=Determina_menor (Obj.ResultsScanning2,i-1);
            Obj.SortScan2;
            
        end
        
        function Obj = Determinedegree (Obj)
           
            Obj.ConvertData(Obj.Qmin);
            Obj.AgregateData;
            RSSaj=zeros(Obj.PolyGrau,1);
            Fvalor=zeros(Obj.PolyGrau,1);
            pF=zeros(Obj.PolyGrau,1);
            ndados=size(Obj.AdjustData);
            for i=1:Obj.PolyGrau
                [Parametros,~,m1]=polyfit(Obj.AdjustData(:,1), Obj.AdjustData(:,2),i);
                [Parametros]=ScaleBackParameters(Parametros,m1);
                Parametros=Parametros';
                Obj.RegressionAnalysis (Parametros);
                RSSaj(i)=Obj.MSEaux;
                Obj.AuxiliaryResult=Parametros;
                
                %Bloco que verifica significância do ajuste
                alfa=0.3134;
                if i>=2
                    Fvalor(i)= (RSSaj(i-1))^2/RSSaj(i)^2;
                    pF(i) =fcdf(Fvalor(i),ndados(1,1)-i-2,ndados(1,1)-i-1);
                    if pF(i)<(1-alfa/2)
                        Obj.FinalDegree=i-1;
                        break;
                    end
                    if i==Obj.PolyGrau
                        Obj.FinalDegree=i;
                    end
                end
            end
                
            
            
        end
        
        function Obj = FittingFinal (Obj)
            
            %Determina chutes iniciais
            if Obj.MSCFunction==2
                aux=8-Obj.FinalDegree;
                aux2=Obj.AuxiliaryResult(aux:8,1);
                x0=[Obj.Qmin; aux2];
            elseif Obj.MSCFunction==1
                x0=[Obj.Qmin; Obj.Parameters{Obj.imin}];
            else
                aux=Obj.AuxiliaryResult;
                x0=[Obj.Qmin; aux'];
            end
            %Determina os dados utilizados no ajuste
            dados=cell(1,Obj.nCurves);
            Vcov=cell(1,Obj.nCurves);
            for i=1:Obj.nCurves
                dados{i}=Obj.Data{i}(Obj.i1{i}:Obj.i2{i},:);
                if Obj.MSCMethod==2
                    Vcov{i}=Obj.DataVcov{i}(Obj.i1{i}:Obj.i2{i}, Obj.i1{i}:Obj.i2{i});
                end
            end
            
            if Obj.MSCMethod==2
                [dados, Vcov] = IgualaDadosMSC2 (dados, Vcov);
            else
                dados = IgualaDadosMSC (dados);
            end
            
            
            %Determina o tamanho dos arquivos de dados
            ndadostotal1=0;
            ndados=cell(Obj.nCurves,1);
            for i=1:Obj.nCurves
                ndados{i}=size(dados{i});
                ndadostotal1=ndadostotal1+ndados{i};
            end
            
            %Junta os arquivos de dados em uma matriz
            Obj.AdjustData=zeros(ndadostotal1(1,1),3);
            naux2=0;
            for i=1:Obj.nCurves
                naux1=1+naux2;
                naux2=naux2+ndados{i}(1,1);
                Obj.AdjustData(naux1:naux2,:)=dados{i};
            end
            
            %Bloco que junta a matriz de covariância se opção for selecionada
            if Obj.MSCMethod==2
                Obj.AdjustDataVcov=zeros(ndadostotal1(1,1),ndadostotal1(1,1));
                naux2=0;
                for i=1:Obj.nCurves
                    naux1=1+naux2;
                    naux2=naux2+ndados{i}(1,1);
                    Obj.AdjustDataVcov(naux1:naux2,naux1:naux2)=Vcov{i};
                end
            end
            
            %Montagem da função de ajuste
            if Obj.MSCFunction ==1
                if Obj.MSCMethod==1
                    funcaow= @(x0,S)sigmoidal2(x0,S);
                    [Obj.ParametersFinal,Obj.ResidualFinal,~,Covfinal,~,Obj.exitf]= nlinfit2({Obj.AdjustData(:,1:2),ndados},Obj.AdjustData(:,3),funcaow, x0);%Efetua o ajuste dos parâmetros
                else
                    funcaow= @(x0,S) sqrt(diag(inv(Obj.AdjustDataVcov))).*sigmoidal2(x0,S);
                    dados=sqrt(diag(inv(Obj.AdjustDataVcov))).*Obj.AdjustData(:,3);
                    [Obj.ParametersFinal,Obj.ResidualFinal,~,Covfinal,~,Obj.exitf]= nlinfit2({Obj.AdjustData(:,1:2),ndados},dados,funcaow, x0);%Efetua o ajuste dos parâmetros
                end
                if Obj.exitf==1
                    errordlg('Fit not sucessful','Warning','modal');
                    uicontrol(hObject);
                    Obj.MSCIniFlag=2;
                    return;
                end
                [std]=nlparci(Obj.ParametersFinal,Obj.ResidualFinal,'covar',Covfinal,'alpha',0.3134);    %Determina o intervalo de confiança de 1 sigma
                Obj.UncFinal=Obj.ParametersFinal(1,1)-std(1,1);
            elseif Obj.MSCFunction==2
                if Obj.MSCMethod==1
                    funcaow=@(x0,S)polinomial2 (x0,S);
                    [Obj.ParametersFinal,Obj.ResidualFinal,~,Covfinal,~,Obj.exitf]= nlinfit2({Obj.AdjustData(:,1:2),ndados,Obj.FinalDegree},Obj.AdjustData(:,3),funcaow, x0);%Efetua o ajuste dos parâmetros
                else
                    funcaow=@(x0,S) sqrt(diag(inv(Obj.AdjustDataVcov))).*polinomial2 (x0,S);
                    dados=sqrt(diag(inv(Obj.AdjustDataVcov))).*Obj.AdjustData(:,3);
                    [Obj.ParametersFinal,Obj.ResidualFinal,~,Covfinal,~,Obj.exitf]= nlinfit2({Obj.AdjustData(:,1:2),ndados,Obj.FinalDegree},dados,funcaow, x0);%Efetua o ajuste dos parâmetros
                end
                if Obj.exitf==1
                    errordlg('Fit not sucessful','Warning','modal');
                    uicontrol(hObject);
                    Obj.MSCIniFlag=2;
                    return;
                end
                [std]=nlparci(Obj.ParametersFinal,Obj.ResidualFinal,'covar',Covfinal,'alpha',0.3134);    %Determina o intervalo de confiança de 1 sigma
                Obj.UncFinal=Obj.ParametersFinal(1,1)-std(1,1);
                Obj.ParametersFinal = ScaleBackParameters2 (Obj.ParametersFinal, ndados, Obj.AdjustData(:,1:2), Obj.FinalDegree);
            else
                errordlg('Invalid interface options','Warning','modal');
                uicontrol(hObject);
                return;
            end
            
        
            %Analise do ajuste final
            Obj.MSEFinal= Obj.ResidualFinal'*Obj.ResidualFinal;
            ntotal=0;
            for i=1:Obj.nCurves
                ntotal=ntotal+ndados{i}(1,1);
            end
            nparam = size(Obj.ParametersFinal);
            nparam=nparam(1,2);
            
            Obj.GodnessFit=Obj.MSEFinal/(ntotal-nparam);
            Obj.ConstructMSC;
        end
        
        function Obj = ConstructMSC (Obj)
           
            Obj.ConvertData(Obj.ParametersFinal(1,1));
            Obj.AgregateData;
            nparam=size(Obj.ParametersFinal);
            nparam=nparam(1,1);
            dados=sortrows(Obj.AdjustData(:,1));
            Obj.MSCCurve2(:,1)=dados;
            if Obj.MSCFunction ==1
                Obj.MSCCurve2(:,2)=sigmoidal(Obj.ParametersFinal(2:nparam,:),dados);
            else
                Obj.MSCCurve2(:,2)=polinomial(Obj.ParametersFinal(2:nparam,:),dados);
            end
            
        end
        
        function Obj = ConstructMSC1 (Obj)
           
            Obj.ConvertData(Obj.ParametersFinal1(1,1));
            Obj.AgregateData;
            nparam=size(Obj.ParametersFinal1);
            nparam=nparam(1,1);
            dados=sortrows(Obj.AdjustData(:,1));
            Obj.MSCCurve(:,1)=dados;
            if Obj.MSCFunction ==1
                Obj.MSCCurve(:,2)=sigmoidal(Obj.ParametersFinal1(2:nparam,:),dados);
            else
                Obj.MSCCurve(:,2)=polinomial(Obj.ParametersFinal1(2:nparam,:),dados);
            end
            Obj.ConvertData2(Obj.ParametersFinal1(1,1));
            if Obj.MSCFitting==1
                Obj.ParametersFinal=[Obj.SelectionQ; Obj.ParametersFinal];
                Obj.MSCCurve2=Obj.MSCCurve;
            end
            
        end
        
        function Obj = ConstructMSC1A (Obj)
           
            Obj.ConvertData2A(Obj.ParametersFinal2(1,1));
            Obj.AgregateData2;
            nparam=size(Obj.ParametersFinal2);
            nparam=nparam(1,1);
            dados=sortrows(Obj.AdjustData2(:,1));
            Obj.MSCCurveA(:,1)=dados;
            if Obj.MSCFunction ==1
                Obj.MSCCurveA(:,2)=sigmoidal(Obj.ParametersFinal2(2:nparam,:),dados);
            else
                Obj.MSCCurveA(:,2)=polinomial(Obj.ParametersFinal2(2:nparam,:),dados);
            end
            
            Obj.ConvertData3A(Obj.ParametersFinal2(1,1));
            ndados2=size(Obj.MSCCurve);
            i=1;
            while Obj.MSCCurveA(i,2) <= Obj.MSCCurve(ndados2(1,1),2)
                Obj.MSCCurveA(i,:)=[];
            end
            Obj.MSCCurveA(1,:)=[];
        end
        
        function Obj = ResetParameters (Obj)
        Obj.Data=[];                                                              
        Obj.DataVcov=[];                                                          
        
        %Dados convertidos
        Obj.MSCData =[];                                                       
        Obj.MSCDataVcov =[]; 
        Obj.MSCDataA =[];
        Obj.MSCData2 =[];
        Obj.MSCData2A =[];
        
        %Indicadores de dados selecionados
        Obj.i1=[];
        Obj.i2=[];
        Obj.i1A=[];
        Obj.i2A=[];
        
        %Dados preparados para o ajuste
        Obj.AdjustData =[];                                                        
        Obj.AdjustDataVcov =[]; 
        Obj.AdjustData2 =[];
        
        %Resultados da varredura de Q para o primeiro intervalo
        Obj.ResultsScanning =[];                                                   
        Obj.Parameters =[];                                                       
        Obj.Residual =[];                                                         
        Obj.AuxiliaryResult =[];
        Obj.AuxiliaryParameters =[];
        Obj.Qmin =[];
        Obj.imin =[];
        Obj.MSEaux =[];
        Obj.Residuoaux =[];
        Obj.FinalDegree =[];
        Obj.ResultsScanning2 =[];                                                   
        Obj.Parameters2 =[];                                                       
        Obj.Residual2 =[];                                                         
        Obj.AuxiliaryResult2 =[];
        Obj.AuxiliaryParameters2 =[];
        Obj.Qmin2 =[];
        Obj.imin2 =[];
        Obj.MSEaux2 =[];
        Obj.Residuoaux2 =[];
        
        %Resultados para ajuste a Q selecionado
        Obj.FinalResultQ =[];                                                     
        Obj.ParametersQ =[];                                                        
        Obj.ResidualQ =[];                                                          
        
        %Resultados do ajuste final
        Obj.GodnessFit =[];                                                          
        Obj.ParametersFinal =[];
        Obj.ParametersFinal1 =[];
        Obj.ResultsFinal =[];                                                       
        Obj.ResidualFinal =[];                                                      
        Obj.MSEFinal =[];
        Obj.MSCCurve =[];
        Obj.MSCCurve2 =[];
        Obj.UncFinal =[];
        Obj.ParametersFinal2 =[];
        Obj.MSCCurveA =[];
        Obj.MSCCurveFinal =[];
          
            
        end
        
        function Obj = ApplyAnalysis2 (Obj)
            
            
            Tetao= CalculaTeta(Obj.HR12, Obj.DTemp12, Obj.DTime12,Obj.ParametersFinal1(1,1));
            if Obj.SinteringMethod==2 
                if Obj.Qanalysis==1
                    Tetao2= CalculaTeta2(Obj.HR22, Obj.DTemp22, Obj.DTime22,Obj.ParametersFinal1(1,1), Obj.DTemp12);
                    Tetao=Tetao+Tetao2;
                    Tetao=log10(Tetao);
                    Obj.Dens2 = CalculaDensidade (Tetao, Obj.ParametersFinal1, Obj.MSCFunction);
                    Obj.Tetaol= Tetao;
                else
                    Tetao2= CalculaTeta2(Obj.HR22, Obj.DTemp22, Obj.DTime22,Obj.ParametersFinal2(1,1), Obj.DTemp12);
                    Tetaofinal=Tetao+Tetao2;
                    Tetao=log10(Tetao);
                    Dens0 = CalculaDensidade (Tetao, Obj.ParametersFinal1, Obj.MSCFunction);
                    Tetaofinal=log10(Tetaofinal);
                    Obj.Dens2 = CalculaDensidade2 (Tetaofinal, Obj.ParametersFinal2, Obj.MSCFunction,Dens0);
                    Obj.Tetaol= Tetaofinal;
                end
            else
                Tetao=log10(Tetao);
                Obj.Dens2 = CalculaDensidade (Tetao, Obj.ParametersFinal1, Obj.MSCFunction);
                Obj.Tetaol= Tetao;
            end
            
            
        end
        
        function Obj = SinteringMap1 (Obj)
           
            t=0.001;
            j=1;
            Obj.Densidadest1=cell(7,1);
            while t<=1000
                Obj.Densidadest1{j}=zeros(40,2);
                i=1;
                for T=800:20:1600
                    Tetao= CalculaTeta(10, T, t,Obj.ParametersFinal1(1,1));
                    Tetao=log10(Tetao);
                    Obj.Densidadest1{j}(i,1)=T;
                    Obj.Densidadest1{j}(i,2)= CalculaDensidade (Tetao, Obj.ParametersFinal1, Obj.MSCFunction);
                    i=i+1;
                end
                j=j+1;
                t=t*10;
            end
            
        end
        
        function Obj = SinteringMap2 (Obj)
           
            Dens0 = Obj.MSCFinalDens;
            Tetao1=Obj.Tetaint;
            t=0.001;
            j=1;
            Obj.Densidadest2=cell(7,1);
            while t<=1000
                Obj.Densidadest2{j}=zeros(40,2);
                i=1;
                for T=800:20:1600
                    Tetao2= CalculaTeta2(10, T, t,Obj.ParametersFinal2(1,1),Obj.DTemp12);
                    Tetaofinal= Tetao1+Tetao2;
                    Tetaofinal=log10(Tetaofinal);
                    Obj.Densidadest2{j}(i,1)=T;
                    Obj.Densidadest2{j}(i,2)= CalculaDensidade2 (Tetaofinal, Obj.ParametersFinal2, Obj.MSCFunction, Dens0);
                    i=i+1;
                end
                j=j+1;
                t=t*10;
            end
            
        end
        
            
    end
        
    
end