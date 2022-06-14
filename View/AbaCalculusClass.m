classdef AbaCalculusClass <handle
    %ABACALCULUS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %Componentes Passivos
        Component
        FundoEsq
        FundoDir
        Panel
        Text
        
        %Componentes Ativos
        CheckBox
        rbh
        Button
        EditText
        popup
        slider
        ApplyButton
    end
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = AbaCalculusClass
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Métodos que modificam as propriedades do objeto%%%%%%%%%%%
        function Obj = CriaComponent (Obj, Parent)
            Obj.Component = uiextras.HBox( 'Parent', Parent );
        end
        
        function Obj = CriaObjetos (Obj)
           
            %Fundos
            Obj.FundoEsq = uiextras.VBox('Parent', Obj.Component);
            Obj.FundoDir = uiextras.VBox('Parent', Obj.Component);
            
            %Panels Esquerdo
            Obj.Panel(1) = ViewConstructor.Panel(Obj.FundoEsq,'Execute');
            Obj.Panel(2) = ViewConstructor.Panel(Obj.FundoEsq,'Derivates');
            Obj.Panel(3) = ViewConstructor.Fundo(Obj.FundoEsq);
            
            %Panels Direito
            Obj.Panel(4) = ViewConstructor.Panel(Obj.FundoDir,'Densities Parameters');
            Obj.Panel(5) = ViewConstructor.Panel(Obj.FundoDir,'Smoothing');
            
            %Criação de Objetos do Panel1
            Obj.CheckBox(1) = ViewConstructor.Checkbox (Obj.Panel(1), 'Instantaneous Shrinkage', [0.09 0.70 0.80 0.15], 0, {@CalcSelectFunc,1});
            Obj.CheckBox(2) = ViewConstructor.Checkbox (Obj.Panel(1), 'Densities', [0.09 0.45 0.60 0.15], 0, {@CalcSelectFunc,2});
            Obj.CheckBox(3) = ViewConstructor.Checkbox (Obj.Panel(1), 'Densification', [0.09 0.2 0.850 0.15], 0, {@CalcSelectFunc,3});
            
            %Criação de Objetos do Panel2
            Obj.CheckBox(4) = ViewConstructor.Checkbox (Obj.Panel(2), 'Shrinkage', [0.09 0.75 0.850 0.15], 0, {@CalcSelectFunc,4});
            Obj.CheckBox(5) = ViewConstructor.Checkbox (Obj.Panel(2), 'Instantaneous Shrinkage', [0.09 0.55 0.80 0.15], 0, {@CalcSelectFunc,5});
            Obj.CheckBox(6) = ViewConstructor.Checkbox (Obj.Panel(2), 'Densities', [0.09 0.35 0.60 0.15], 0, {@CalcSelectFunc,6});
            Obj.CheckBox(7) = ViewConstructor.Checkbox (Obj.Panel(2), 'Densification', [0.09 0.15 0.850 0.15], 0, {@CalcSelectFunc,7});

            %Criação de Objetos do Panel3
            Obj.ApplyButton = ViewConstructor.Button(Obj.Panel(3),'Apply',[0.35 0.4 0.3 0.30], {@CalcSelectFunc,17});

            %Criação de Objetos do Panel4
            Obj.CheckBox(8) = ViewConstructor.Checkbox (Obj.Panel(4), 'Mass lost correction', [0.09 0.45 0.850 0.15], 0, {@CalcSelectFunc,8});
            Obj.Text(1) = ViewConstructor.Text (Obj.Panel(4), [0.02 0.75 0.4 0.15], 'Green Density:');
            Obj.Text(2) = ViewConstructor.Text (Obj.Panel(4), [0.78 0.75 0.2 0.15], '[g/cm3]');
            Obj.Text(3) = ViewConstructor.Text (Obj.Panel(4), [0.02 0.6 0.4 0.15], 'Uncertainty:');
            Obj.Text(4) = ViewConstructor.Text (Obj.Panel(4), [0.78 0.6 0.2 0.15], '[g/cm3]');
            Obj.EditText(1) = ViewConstructor.EditText(Obj.Panel(4), [0.45 0.82 0.3 0.10], {@CalcSelectFunc,9});
            Obj.EditText(2) = ViewConstructor.EditText(Obj.Panel(4), [0.45 0.67 0.3 0.10], {@CalcSelectFunc,10});
            Obj.rbh(1) = ViewConstructor.RadioButton (Obj.Panel(4), 'Single file', [0.35 0.33 0.4 0.15], {@CalcSelectFunc,11});
            Obj.rbh(2) = ViewConstructor.RadioButton (Obj.Panel(4), 'Multiple file', [0.35 0.22 0.4 0.15], {@CalcSelectFunc,12});
            Obj.Button(1) = ViewConstructor.Button(Obj.Panel(4),'Add',[0.35 0.05 0.25 0.15],{@CalcSelectFunc,13});
            
            %Criação de Objetos do Panel5
            Obj.EditText(3) = ViewConstructor.EditText(Obj.Panel(5), [0.65 0.2 0.3 0.20], {@CalcSelectFunc,14});
            Obj.popup(1) = ViewConstructor.Popupmenu (Obj.Panel(5), [0.05 0.55 0.9 0.15], {'Select curve'}, {@CalcSelectFunc,15});
            Obj.slider(1) = ViewConstructor.Slider (Obj.Panel(5), 1,100, 50, [0.001 0.001 0.4 0.12],  {@CalcSelectFunc,16});

        end
        
        function Obj = Configure (Obj)
            
             set( Obj.Component, 'Sizes', [245 -1], 'Spacing', 5 ); 
             set( Obj.FundoEsq, 'Sizes', [120 150 -1], 'Spacing', 5 ); 
             set( Obj.FundoDir, 'Sizes', [250 -1], 'Spacing', 5 ); 

        end
       
       
    end
    
end

