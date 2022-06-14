classdef AbaCreepClass<handle
    %ABACREEP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        %Componentes Passivos
        Component
        FundoEsq
        FundoDir
        FundoApply
        Text
        
        %Componentes Ativos
        Panel
        CheckBox
        ApplyButton
        EditText
        rbh
        popup
        Button
        
    end
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = AbaCreepClass
            
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
            
            %Criação dos panel
            Obj.Panel(1)=ViewConstructor.Panel(Obj.FundoEsq,'Correction');
            Obj.Panel(2)=ViewConstructor.Panel(Obj.FundoDir,'T0');
            Obj.Panel(3)=ViewConstructor.Panel(Obj.FundoDir,'L0');
            Obj.Panel(4)=ViewConstructor.Panel(Obj.FundoDir,'Push Rod Expansion');
            Obj.Panel(5)=ViewConstructor.Panel(Obj.FundoDir,'Simple Expansion');
            
            %Criação do fundo e do botão para Apply 
            Obj.FundoApply= ViewConstructor.Fundo (Obj.FundoEsq);          % Fundo para os botões no Vbox Superior 
            Obj.ApplyButton = ViewConstructor.Button(Obj.FundoApply,'Apply',[0.35 0.4 0.3 0.20], {@CorrectionConfigFunc,5});
             
            %Criação dos objetos do panel1
            Obj.CheckBox(1) = ViewConstructor.Checkbox (Obj.Panel(1), 'To', [0.03 0.85 0.30 0.10], 0, {@CorrectionConfigFunc,1});
            Obj.CheckBox(2) = ViewConstructor.Checkbox (Obj.Panel(1), 'Lo', [0.03 0.65 0.30 0.10], 0, {@CorrectionConfigFunc,2});
            Obj.CheckBox(3) = ViewConstructor.Checkbox (Obj.Panel(1), 'Push Rod Thermal Expansion', [0.03 0.45 0.850 0.10], 0, {@CorrectionConfigFunc,3});
            Obj.CheckBox(4) = ViewConstructor.Checkbox (Obj.Panel(1), 'Sample Thermal Expansion', [0.03 0.25 0.850 0.10], 0, {@CorrectionConfigFunc,4});
            Obj.CheckBox(5) = ViewConstructor.Checkbox (Obj.Panel(1), 'DlMethod', [0.03 0.05 0.850 0.10], 0, {@CorrectionConfigFunc,14});
            
            %Criação dos objetos do panel2
            Obj.Text(1) = ViewConstructor.Text (Obj.Panel(2), [0.15 0.35 0.2 0.35], 'To Value:');
            Obj.Text(2) = ViewConstructor.Text (Obj.Panel(2), [0.8 0.35 0.1 0.35], '[oC]');
            Obj.EditText(1) = ViewConstructor.EditText(Obj.Panel(2), [0.4 0.35 0.34 0.42],{@CorrectionConfigFunc,6});
            
            %Criação dos objetos do panel3
            Obj.rbh(1) = ViewConstructor.RadioButton (Obj.Panel(3), 'Extrapolation method', [0.25 0.83 0.7 0.15],{@CorrectionConfigFunc,7});
            Obj.rbh(2) = ViewConstructor.RadioButton (Obj.Panel(3), 'Translation method', [0.25 0.7 0.7 0.15],{@CorrectionConfigFunc,8});
            Obj.Text(3) = ViewConstructor.Text (Obj.Panel(3), [0.1 0.45 0.25 0.15], 'To Value:');
            Obj.Text(4) = ViewConstructor.Text (Obj.Panel(3), [0.75 0.45 0.25 0.15], '[oC]');
            Obj.Text(5) = ViewConstructor.Text (Obj.Panel(3), [0.1 0.25 0.25 0.15], 'Tf Value:');
            Obj.Text(6) = ViewConstructor.Text (Obj.Panel(3), [0.75 0.25 0.25 0.15], '[oC]');
            Obj.Text(7) = ViewConstructor.Text (Obj.Panel(3), [0.03 0.06 0.45 0.12], 'Reference curve:');          
            Obj.EditText(2) = ViewConstructor.EditText(Obj.Panel(3), [0.35 0.48 0.45 0.15],{@CorrectionConfigFunc,9});
            Obj.EditText(3) = ViewConstructor.EditText(Obj.Panel(3), [0.35 0.28 0.45 0.15],{@CorrectionConfigFunc,10});
            Obj.popup(1) = ViewConstructor.Popupmenu (Obj.Panel(3), [0.45 0.08 0.48 0.13] ,'Select curve',{@CorrectionConfigFunc,11});
            
            %Criação dos objetos do panel4
            Obj.Text(8) = ViewConstructor.Text (Obj.Panel(4), [0.05 0.35 0.1 0.35], 'File:');           
            Obj.Text(10) = ViewConstructor.Text(Obj.Panel(4), [0.18 0.35 0.53 0.35],'');
            Obj.Button(1) = ViewConstructor.Button(Obj.Panel(4),'Add',[0.75 0.31 0.22 0.48],{@CorrectionConfigFunc,12});
            
            %Criação dos objetos do panel5
            Obj.Text(9) = ViewConstructor.Text (Obj.Panel(5), [0.05 0.35 0.1 0.35], 'File:');
            Obj.Text(11) = ViewConstructor.Text(Obj.Panel(5), [0.18 0.35 0.53 0.35],'');
            Obj.Button(2) = ViewConstructor.Button(Obj.Panel(5),'Add',[0.75 0.31 0.22 0.48],{@CorrectionConfigFunc,13});   
        end
        
        function Obj = Configure (Obj)
            
            set( Obj.Component, 'Sizes', [240 -1], 'Spacing', 5 ); 
            set( Obj.FundoEsq, 'Sizes', [200 -1], 'Spacing', 5 ); 
            set( Obj.FundoDir, 'Sizes', [70 175 70 -1], 'Spacing', 5 ); 

        end
       
       
    end
    
    
end

