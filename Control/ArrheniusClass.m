classdef ArrheniusClass <handle
    %Estrutura que guarda as informações necessárias para a análise pelo
    %método de Arrhenius
    
    properties
        ArrheniusDataOption
        InitDens
        FinalDens
        StepDens
        Data
        ActivationEnergies
        Parameters
        ArrheniusFlag
        DataAdjust
        nDataAdjust
        LineAdjust
    end
    
    methods
       
        function Obj = Reset (Obj)
           
            Obj.ArrheniusDataOption=[];
            Obj.ArrheniusDataOption=[];
            Obj.InitDens=[];
            Obj.FinalDens=[];
            Obj.StepDens=[];
            Obj.Data=[];
            Obj.ActivationEnergies=[];
            Obj.Parameters=[];
            Obj.ArrheniusFlag=[];
            Obj.DataAdjust=[];
            Obj.nDataAdjust=[];
            Obj.LineAdjust=[];
            
        end
        
        function Obj = ApplyArrhenius (Obj)
           
            nlinhas=size(Obj.Data);
            ncols=nlinhas(1,2);
            nlinhas=nlinhas(1,1);
            dados=zeros(floor(ncols/2),2);
            ndados=size(dados);
            ndados=ndados(1);
            Obj.ActivationEnergies=zeros(nlinhas,3);
            Obj.Parameters = zeros(nlinhas,2);
            Obj.nDataAdjust=nlinhas;
            dados=sortrows(dados);
            for i=1:nlinhas
               for j=2:2:ncols
                   dados(j/2,1)=Obj.Data(i,j);
                   dados(j/2,2)=Obj.Data(i,j+1);
               end
               Obj.DataAdjust{i}=dados;
               [clin,cang,canginc,~] = MMQlinear2 (dados);
               Obj.Parameters(i,:)=[clin, cang];
               Obj.ActivationEnergies(i,1)=Obj.Data(i,1);
               Obj.ActivationEnergies(i,2)=-cang*8.314472;
               Obj.ActivationEnergies(i,3)=-canginc*8.314472;
               Obj.LineAdjust{i}=zeros(ndados,2);
               Obj.LineAdjust{i}(:,1)=dados(:,1);
               Obj.LineAdjust{i}(:,2)=clin*ones(ndados,1)+cang*dados(:,1);
                
            end
            
        end
        
    end
    
end
