classdef AbaUncertaintyClass<handle
    %ABAUNCERTAINTY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        %Componentes Passivos
        Component
        FundoEsq
        FundoDir
        Panel
        FundoApply
        FundoMessage
        Text
        
        %Componentes Ativos
        rbh
        EditText
        Button
        ApplyButton
    end
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = AbaUncertaintyClass
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Métodos que modificam as propriedades do objeto%%%%%%%%%%%
        function Obj = CriaComponent (Obj, Parent)
            Obj.Component = uiextras.HBox( 'Parent', Parent );
        end
        
        function Obj = CriaObjetos (Obj)
           
            %Fundos
            Obj.FundoEsq = uiextras.VBox('Parent', Obj.Component);
            Obj.FundoDir= uiextras.VBox('Parent', Obj.Component);
            
            %Fundo do Box Esquerdo
            Obj.Panel(1) = ViewConstructor.Panel(Obj.FundoEsq,'Uncertainty');
            Obj.FundoApply = ViewConstructor.Fundo (Obj.FundoEsq);              % Fundo para os botão Apply
            Obj.FundoMessage = ViewConstructor.Fundo (Obj.FundoDir);            % Fundo para mensagem à direita


            %Criação dos Objetos do Panel1
            Obj.Text(2) = ViewConstructor.Text (Obj.Panel(1), [0.05 0.25 0.4 0.15], 'Resolution:');
            Obj.Text(3) = ViewConstructor.Text (Obj.Panel(1), [0.7 0.25 0.2 0.15], '[mm]');
            Obj.Text(4) = ViewConstructor.Text (Obj.Panel(1), [0.17 0.1 0.2 0.15], 'CET File:');
            Obj.rbh(1) = ViewConstructor.RadioButton (Obj.Panel(1), 'None', [0.05 0.8 0.4 0.15],{@UncertConfigFunc,1});
            Obj.rbh(2) = ViewConstructor.RadioButton (Obj.Panel(1), 'Resolution', [0.05 0.65 0.4 0.15],{@UncertConfigFunc,2});
            Obj.rbh(3) = ViewConstructor.RadioButton (Obj.Panel(1), 'ASTM based', [0.05 0.5 0.4 0.15],{@UncertConfigFunc,3});
            Obj.EditText(1) = ViewConstructor.EditText(Obj.Panel(1), [0.4 0.32 0.3 0.10], {@UncertConfigFunc,4});
            Obj.EditText(2) = ViewConstructor.EditText(Obj.Panel(1), [0.4 0.17 0.3 0.1], {@UncertConfigFunc,5});
            Obj.Button(1) = ViewConstructor.Button(Obj.Panel(1),'Add',[0.74 0.16 0.2 0.13],{@UncertConfigFunc, 6});

            
            %Criação do botão Apply
            Obj.ApplyButton = ViewConstructor.Button(Obj.FundoApply,'Apply',[0.35 0.4 0.3 0.25], {@UncertConfigFunc,7});
            
            %Criação da mensagem de espera
            Obj.Text(1) = ViewConstructor.Text (Obj.FundoMessage, [0.1 0.05 0.8 0.75], 'Please wait! This process can take several minutes.');

        end
        
        function Obj = Configure (Obj)
            
            set( Obj.Component, 'Sizes', [240 -1], 'Spacing', 5 ); 
            set( Obj.FundoEsq, 'Sizes', [250 -1], 'Spacing', 5 ); 
           
        end
       
       
    end
    
end

