classdef Data <handle
    %Estrutura que armazena outras estruturas utilizadas no c�lculos.
    
    properties
        Id                                                                 %Identifica��o
        
        %Estrutura de dados que armazena dados da tabela (DataInit)
        Name                                                               %Nome do arquivo de dados
        Show                                                               %Status: 0 - N�o � mostrada no gr�fico 1- � mostrada no gr�fico
        IdColor                                                            %Cor selecionada para mostrar os dados
        ImgColor                                                           %String com HTML da imagem embutida 
        Lo                                                                 %Comprimento inicial da amostra
        File                                                               %Matriz de dados
        
        %Estrutura que cont�m os dados inseridos pelo usu�rio
            Shrinkage                                                      %Estrutura de dados que guarda vari�veis associadas a retra��o linear
                InstShrinkage                                              %Estrutura de dados que guarda vari�veis associadas a retra��o linear instant�nea
                Densities                                                  %Estrutura de dados que guarda vari�veis associada a densidade
                    Densification                                          %Estrutura de dados que guarda vari�veis associadas a densifica��o
            
    end
    
    methods
        function obj = Data(Name, IdColor, File, Show)
            if nargin > 0
                obj.File = File;
                obj.Name = Name;
                obj.Show = Show;
                obj.IdColor = IdColor;
                obj.Shrinkage = ShrinkageClass;
                obj.InstShrinkage = InstShrinkageClass;
                obj.Densities = DensitiesClass;
                obj.Densification = DensificationClass;
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%Fun��es utilizadas para compor Densification%%%%%%%%%%
        
        function Obj=Calc_Densification (Obj)


            %Bloco de atribui��o de dados necess�rios para a fun��o
            densidades= Obj.Densities.Curve;
            dens0= Obj.Densities.Dens0;
            nlinhas=size(densidades);
            nlinhas=nlinhas(1,1);

            %Bloco que calcula a densifica��o
            densificacao=densidades;
            for j=1:nlinhas
                densificacao(j,3)=100*(densidades(j,3)-dens0)/(100-dens0);
            end
            Obj.Densification.Curve=densificacao;
                
        end
        
        function Obj = CalcUnc_Densification (Obj)
            
            %Bloco que calcula a densifica��o
            densidades=Obj.Densities.Curve;
            dens0=Obj.Densities.Dens0;
            Vdens=Obj.Densities.CurveUnc;
            ndados=size(densidades);
            ndados=ndados(1,1);

            %Bloco que constr�i matriz de transforma��o linear
            C1= 1/(100-dens0)*eye(ndados(1),ndados);
            C2=zeros(ndados(1),1);
            for i=1:ndados(1)
                C2(i)= (-100+densidades(i,3))/(100-dens0)^2;
            end
            C=[C1 C2];

            %Bloco que calcula a matriz de covari�ncia dos dados
            Vdensif = C*Vdens*C';
            Obj.Densification.CurveUnc=Vdensif;
            Obj.Densification.RelativeUnc=Obj.Densification.Curve;
            for i=1:ndados(1)
                Obj.Densification.RelativeUnc(i,3)=(Obj.Densification.CurveUnc(i,i)^(1/2));
            end
        end
   
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%Fun��es utilizadas para compor InstShrinkage%%%%%%%%%%
        
        function Obj = Calc_Linst (Obj)
            
            %Bloco de atribui��o de vari�veis necessarias para a fun��o
            Acor=Obj.Shrinkage.Curve;
            
            %Bloco de c�lculo de Dl/Linst
            Linst=Acor;
            nlinhas=size(Acor);
            Linst(:,3)=Acor(:,3)./(ones(nlinhas(1,1),1)+Acor(:,3));
            Obj.InstShrinkage.Curve=Linst;
            
        end
        
        function Obj = CalcUnc_Linst (Obj)
        
            %Bloco de atribui��o de vari�veis iniciais
            Acor=Obj.Shrinkage.Curve;
            ndados=size(Acor);
            ndados=ndados(1,1);
            
            %Cria��o da matriz de transforma��o linear 
            C=zeros(ndados,ndados);
            for i=1:ndados
                C(i,i)=1/(1+Acor(i,3))^2;
            end
            
            %Atribui��o da matriz de covari�ncia
            V=Obj.Shrinkage.CurveUnc;
            
            %Calculo da matriz de covari�ncia dos dados
            Vcov=C*V*C';
            Obj.InstShrinkage.CurveUnc=Vcov;
            Obj.InstShrinkage.RelativeUnc=Obj.InstShrinkage.Curve;
            for i=1:ndados(1)
                Obj.InstShrinkage.RelativeUnc(i,3)=(Obj.InstShrinkage.CurveUnc(i,i)^(1/2));
            end
            
        end
        
    end
    
end

