classdef AbaExportClass<handle
    %ABAEXPORT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        Component
    end
    
    methods
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = AbaExportClass
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Métodos que modificam as propriedades do objeto%%%%%%%%%%%
        function Obj = CriaComponent (Obj, Parent)
            Obj.Component = uiextras.HBox( 'Parent', Parent );
        end
       
    end
    
    
end

