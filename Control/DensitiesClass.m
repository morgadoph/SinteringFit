classdef DensitiesClass <handle 
    %Estrutura que guarda curvas e vari�veis de interesse calculadas a
    %partir dos dados iniciais
    
    properties
                                
        %%%%%%%%%%%%%%%%%%%%%%Grandezas calculadas%%%%%%%%%%%%%%%%%%%%%%%%%
        %Curva calculada e derivados
        Dens0
        Curve                                                              %Curva de dados (t T dado)
            CurveUnc                                                       %Matriz de covari�ncia dos dados
        MassCorFile                                                        %Matriz ou Array de matrizes fornecidas pelo usu�rio para a corre��o
        IntpMassCorFile                                                    %Array de matrizes utilizadas na corre��o da perda de massa
        RelativeUnc                                                        %Incertezas relativas de cada dado
        StrainRatexRo                                                      %Derivada da retra��o linear vs densidade
        Arrhenius                                                          %Vari�vel Arrhenius vs 1/T
        
        %%%%%%%%%%%%%%%%%C�lculo das derviadas e derivados%%%%%%%%%%%%%%%%%
        %Derivada em rela��o ao tempo
        Derivatet                                                          %Curva obtida pela derivada dos dados em rela��o ao tempo
            SmoothDerivatet                                                %Curva da derivada em rela��o ao tempo suavizada
                SmoothDerivateUnct                                         %Matriz de covari�ncia da derivada em rela��o ao tempo suavizada
                RelativeDerivateUnct                                       %Incerteza relativa da derivada
            SmoothWindowt                                                  %Valor da janela utilizado na suaviza��o da derivada
            
        %An�lise da derivada em rela��o a temperatura
        DerivateT                                                          %Curva obtida pela derivada dos dados em rela��o a temperatura
            SmoothDerivateT                                                 %Curva da derivada em rela��o a temperatura suavizada
                SmoothDerivateUncT                                          %Matriz de covari�ncia da derivada em rela��o a temperatura suavizada
                RelativeDerivateUncT                                       %Incerteza relativa da derivada
            SmoothWindowT                                                   %Valor da janela utilizado na suaviza��o da derivada
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%Atributos n�o utilizados%%%%%%%%%%%%%%%%%%%%%%%%%
        Ymaxt                                                          %Valores m�ximos no eixo y da curva de derivada
        Xmaxt                                                          %Valores m�ximos no eixo x da curva de derivada
        Npicost                                                        %N�mero de picos na curva de derivada em rela��o ao tempo
        YmaxT                                                          %Valores m�ximos no eixo y da curva de derivada
        XmaxT                                                          %Valores m�ximos no eixo x da curva de derivada
        NpicosT                                                        %N�mero de picos na curva de derivada em rela��o a temperatura
        Variation
            
            
        
    end
    
    methods
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%M�todos que calculam as grandezas de interesse%%%%%%%%%
        
        %Calcula a curva de densidade
        
        function Obj = Calc (Obj,Shrinkage,Config)

                %Bloco de atribui��o de vari�veis necess�rias para a fun��o
                Mass_correction = Config.MassOk;
                Acor=Shrinkage.Curve;
                dens0= Obj.Dens0;
                
                
                %Bloco que verifica se corre��o de massa est� selecionada e prepara os arquivos de dados
                if Mass_correction==1
                    
                    %Bloco que arruma o arquivo de perda de massa - futuro pr�processing
                    massa_data=Obj.MassCorFile;
                    massa_data = interpolacao (massa_data);                              %Fun��o que organiza dados e interpola entre as temperaturas de 1 e 1600 graus
                else
                    massa_data =zeros(1500,3);
                    for i=1:1500
                        massa_data(i,1)=i;
                        massa_data(i,2)=1;
                    end
                end


                %Bloco que determina o arquivo de corre��o para perda de massa
                massacor=Determinacor(Acor,massa_data);
                
                %Bloco que calcula as curvas de densidade e densifica��o
                [densidades,mcor] = Calcula_densidades (Acor, dens0, massacor);        %Fun��o que calcula as densidades e a densifica��o das amostras

                %Sa�da de dados
                Obj.Curve=densidades;
                Obj.IntpMassCorFile=mcor;
        end
    
        %Calcula a matriz de covari�ncia das densidades
        
        function Obj = CalcUnc (Obj, Shrinkage, Config)
          
            %Bloco de atribui��o de vari�veis
            Acor=Shrinkage.Curve;
            dens0=[Obj.Dens0 Config.DensoUncertainty];
            massacor=Obj.IntpMassCorFile;
            ndados=size(Acor);
            densidades=Obj.Curve;
            Vcov=Shrinkage.CurveUnc;
            

            %Bloco que constr�i a matriz de covari�ncia dos dados de densidade e de dens0
            V2=dens0(1,2)^2;                                                           
            V1=zeros(ndados(1),1);
            V3=[Vcov V1];
            V4=[V1' V2];
            V=[V3;V4];

            %Bloco que constr�i a matriz de covari�ncia dos dados de densidade, dens0 e dos fatores de corre��o de massa
            massacor(:,2)=0.01*massacor(:,1);
            nV=size(V);
            V5=zeros(nV(1),ndados(1));
            V6=zeros(ndados(1),ndados(1));
            for i=1:ndados(1)
                V6(i,i)=massacor(i,2)^2;
            end
            V7=[V V5];
            V8=[V5' V6];
            V=[V7;V8];

            %Bloco que calcula a matriz transforma��o linear
            C1=zeros(ndados(1),ndados(1));
            C2=zeros(ndados(1),ndados(1));
            for i=1:ndados(1)
                C1(i,i)=-3*densidades(i,3)/(1+Acor(i,3));
                C2(i,i)=densidades(i,3)/massacor(i,1);
            end
            C3=zeros(ndados(1),1);
            C4=densidades(:,3)/dens0(1,1);
            C5=1;
            C6=[C1 C4 C2];
            C7=[C3' C5 C3'];
            C=[C6; C7];


            %Bloco que calcula matriz de covari�ncia das densidades e da densidade inicial
            Vdens=C*V*C';
            
            %Sa�da de dados
            Obj.CurveUnc=Vdens;
            Obj.RelativeUnc=Obj.Curve;
            for i=1:ndados(1)
                Obj.RelativeUnc(i,3)=(Obj.CurveUnc(i,i)^(1/2));
            end
        end
        
        function Obj = CalcDerivatet (Obj)
        
            %Atribui��o de vari�veis
            dados=Obj.Curve;
            ndados=size(dados);
            ndados=ndados(1,1);
            
            %Calculo da derivada da curva
            Derivate=zeros(ndados,2);
            Derivate(:,1)=dados(:,1);
            for i=1:ndados
                if i==1
                    Derivate(i,2)=(dados(i+1,3)-dados(i,3))/(dados(i+1,1)-dados(i,1));
                elseif i==ndados(1,1)
                    Derivate(i,2)=(dados(i,3)-dados(i-1,3))/(dados(i,1)-dados(i-1,1));
                else
                    Derivate(i,2)=1/2*((dados(i+1,3)-dados(i,3))/(dados(i+1,1)-dados(i,1))+(dados(i,3)-dados(i-1,3))/(dados(i,1)-dados(i-1,1)));
                end
            end
            
            %Sa�da de dados
            Obj.Derivatet=Derivate;
        end
        
        function Obj = CalcDerivateT (Obj)
        
            %Atribui��o de vari�veis
            dados=Obj.Curve;
            ndados=size(dados);
            ndados=ndados(1,1);
            
            %Bloco que calcula a derivada da curva
            Derivate=zeros(ndados,2);
            Derivate(:,1)=dados(:,2);
            for i=1:ndados
                if i==1
                    Derivate(i,2)=(dados(i+1,3)-dados(i,3))/(dados(i+1,2)-dados(i,2));
                elseif i==ndados(1,1)
                    Derivate(i,2)=(dados(i,3)-dados(i-1,3))/(dados(i,2)-dados(i-1,2));
                else
                    Derivate(i,2)=1/2*((dados(i+1,3)-dados(i,3))/(dados(i+1,2)-dados(i,2))+(dados(i,3)-dados(i-1,3))/(dados(i,2)-dados(i-1,2)));
                end
            end
            
            %Sa�da de dados
            Obj.DerivateT=Derivate;
        end
        
        function Obj = Smoothingt (Obj)
        
            vizinhos=Obj.SmoothWindowt;
            Dados=Obj.Derivatet;
            ndados=size(Dados);
            ndados=ndados(1,1);
            %Bloco que aplica a suaviza��o pela m�dia dos vizinhos
            Suavizados=Dados;
            for i=1:ndados(1)
                if i< (vizinhos+1)
                    naux=vizinhos-i+1;
                    aux=naux*Dados(1,2);
                    for j=1:(i+vizinhos)
                        aux=aux+Dados(j,2);
                    end
                elseif i> (ndados(1)-vizinhos)
                    naux=i-ndados(1)+vizinhos;
                    aux=naux*Dados(ndados(1),2);
                    for j=(i-vizinhos):ndados(1)
                        aux=aux+Dados(j,2);
                    end
                else
                    aux=0;
                    for j=(i-vizinhos):(i+vizinhos)
                        aux=aux+Dados(j,2);
                    end
                end

                Suavizados(i,2)=aux/(2*vizinhos+1);
            end
            
            %Sa�da de dados
            Obj.SmoothDerivatet=Suavizados;
        
        end
        
        function Obj = SmoothingT (Obj)
        
   
            vizinhos=Obj.SmoothWindowT;
            Dados=Obj.DerivateT;
            ndados=size(Dados);
            ndados=ndados(1,1);
            %Bloco que aplica a suaviza��o pela m�dia dos vizinhos
            Suavizados=Dados;
            for i=1:ndados(1)
                if i< (vizinhos+1)
                    naux=vizinhos-i+1;
                    aux=naux*Dados(1,2);
                    for j=1:(i+vizinhos)
                        aux=aux+Dados(j,2);
                    end
                elseif i> (ndados(1)-vizinhos)
                    naux=i-ndados(1)+vizinhos;
                    aux=naux*Dados(ndados(1),2);
                    for j=(i-vizinhos):ndados(1)
                        aux=aux+Dados(j,2);
                    end
                else
                    aux=0;
                    for j=(i-vizinhos):(i+vizinhos)
                        aux=aux+Dados(j,2);
                    end
                end

                Suavizados(i,2)=aux/(2*vizinhos+1);
            end
            
            %Sa�da de dados
            Obj.SmoothDerivateT=Suavizados;
        
        end
        
        function Obj = CalcDerivateUnct (Obj)
        
            %Cria��o de vari�veis auxiliares
            aux=size(Obj.Curve);
            ndados=aux(1,1);
            dados=Obj.Curve;
            janela = Obj.SmoothWindowt;
            Vdados=Obj.CurveUnc;
            Vdados=Vdados(1:ndados,1:ndados);
            Ct=zeros(ndados,ndados);
            
            %Bloco que propaga a incertezas da derivada
            for i=1:ndados
                if i==1
                    Ct(i,i)=-1/(dados(i+1,1)-dados(i,1));
                    Ct(i,i+1)=1/(dados(i+1,1)-dados(i,1));
                elseif i==ndados
                    Ct(i,i)=1/(dados(i,1)-dados(i-1,1));
                    Ct(i,i)=1/(dados(i,1)-dados(i-1,1));
                else
                    Ct(i,i)=1/2*(-1/(dados(i+1,1)-dados(i,1))+1/(dados(i,1)-dados(i-1,1)));
                    Ct(i,i+1)=1/2*(1/(dados(i+1,1)-dados(i,1)));
                    Ct(i,i-1)=1/2*(-1/(dados(i,1)-dados(i-1,1)));
                end
            end
            
            Vdert=Ct*Vdados*Ct';
            
            %Verifica se suaviza��o foi aplicada e propaga as covari�ncias caso necess�rio
            if janela ==0
                Vtfinal = Vdert;
            else
                %Bloco que calcula as derivadas sem aplicar a suaviza��o para ser utilizada na propaga��o de incertezas
                derivadas = Obj.Derivatet;

                %Bloco que propaga a incerteza da suaviza��o das derivadas
                dadosaux=derivadas(:,1:2);
                [Vtfinal]=V_suave(dadosaux, Vdert, janela);
            end

            %Sa�da de dados
            Obj.SmoothDerivateUnct = Vtfinal;
            Obj.RelativeDerivateUnct=Obj.SmoothDerivatet;
            for i=1:ndados(1)
                Obj.RelativeDerivateUnct(i,2)=(Obj.SmoothDerivateUnct(i,i)^(1/2));
            end
            
        
        end
        
        function Obj = CalcDerivateUncT (Obj)
        
            %Cria��o de vari�veis auxiliares
            aux=size(Obj.Curve);
            ndados=aux(1,1);
            dados=Obj.Curve;
            janela = Obj.SmoothWindowt;
            Vdados=Obj.CurveUnc;
            Vdados=Vdados(1:ndados,1:ndados);
            CT=zeros(ndados,ndados);
            
            %Bloco que propaga a incertezas da derivada
            for i=1:ndados
                if i==1
                    CT(i,i)=-1/(dados(i+1,2)-dados(i,2));
                    CT(i,i+1)=-1/(dados(i+1,2)-dados(i,2));
                elseif i==ndados(1,1)
                    CT(i,i-1)=-1/(dados(i,2)-dados(i-1,2));
                    CT(i,i-1)=-1/(dados(i,2)-dados(i-1,2));
                else
                    CT(i,i)=1/2*(-1/(dados(i+1,2)-dados(i,2))+1/(dados(i,2)-dados(i-1,2)));
                    CT(i,i+1)=1/2*(1/(dados(i+1,2)-dados(i,2)));
                    CT(i,i-1)=1/2*(-1/(dados(i,2)-dados(i-1,2)));
                end
            end
            VderT=CT*Vdados*CT';
            
            %Verifica se suaviza��o foi aplicada e propaga as covari�ncias caso necess�rio
            if janela ==0
                VTfinal = VderT;
            else
                %Bloco que calcula as derivadas sem aplicar a suaviza��o para ser utilizada na propaga��o de incertezas
                derivadas = Obj.DerivateT;

                %Bloco que propaga a incerteza da suaviza��o das derivadas
                dadosaux=derivadas(:,1:2);
                [VTfinal]=V_suave(dadosaux, VderT, janela);
            end

            %Sa�da de dados
            Obj.SmoothDerivateUncT = VTfinal;
            Obj.RelativeDerivateUncT=Obj.SmoothDerivateT;
            for i=1:ndados(1)
                Obj.RelativeDerivateUncT(i,2)=(Obj.SmoothDerivateUncT(i,i)^(1/2));
            end
            
        
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%Fun��es n�o utilizadas at� o momento%%%%%%%%%%%%%%%
        function Obj = CalcMaxt (Obj)
        
            %Bloco que cria vari�veis auxiliares
            Dados=Obj.Derivatet;
            ndados=size(Dados);
            ndados=ndados(1,1);
            maxvalor=Dados(1,2);
            Dados(:,2)=-1*Dados(:,2);
            
            %Bloco que determina o valor de corte na determina��o dos picos
            for i=2:ndados
                if Dados(i,2) > maxvalor
                    maxvalor = Dados(i:2);
                end
            end
            Ycorte=maxvalor*0.001;
            
            %Bloco que busca os picos e determina a quantidade de picos
            [Obj.Ymaxt,locs] = findpeaks (Dados(:,2), 'MINPEAKHEIGHT', Ycorte);
            Obj.Npicost=size(Obj.Ymaxt);
            Obj.Npicost=Obj.Npicost(1,1);
            
            %Bloco que determina as posi��es dos picos
            Obj.Xmaxt=zeros(Obj.Npicost);
            for i=1:Obj.Npicost
                Obj.Xmaxt(i)=Dados(locs(i),1);
            end
            Obj.Ymaxt=-1*Obj.Ymaxt;
            
            
        end
        
        function Obj = CalcMaxT (Obj)
        
            %Bloco que cria vari�veis auxiliares
            Dados=Obj.DerivateT;
            ndados=size(Dados);
            ndados=ndados(1,1);
            maxvalor=Dados(1,2);
            Dados(:,2)=-1*Dados(:,2);
            
            %Bloco que determina o valor de corte na determina��o dos picos
            for i=2:ndados
                if Dados(i,2) > maxvalor
                    maxvalor = Dados(i:2);
                end
            end
            Ycorte=maxvalor*0.01;
            
            %Bloco que busca os picos e determina a quantidade de picos
            [Obj.YmaxT,locs] = findpeaks (Dados(:,2), 'MINPEAKHEIGHT', Ycorte);
            Obj.NpicosT=size(Obj.YmaxT);
            Obj.NpicosT=Obj.NpicosT(1,1);
            
            %Bloco que determina as posi��es dos picos
            Obj.XmaxT=zeros(Obj.NpicosT);
            for i=1:Obj.NpicosT
                Obj.XmaxT(i)=Dados(locs(i),1);
            end
            Obj.YmaxT=-1*Obj.YmaxT;
            
            
        end
        
        function Obj = CalcVariation (Obj)

            %Cria��o de vari�veis auxiliares
            dados = -1*Obj.Curve;
            ndados=size (dados);
            ndados=ndados(1,1);
            max=dados(1,3);
            
            %Determina��o da varia��o m�xima na curva
            for i=1:ndados
                if dados(i,3) > max
                    max = dados(i,3);
                end
            end

            %Sa�da de dados
            Obj.Variation = max;
        end
        
    end

end

