classdef ProfilePanelClass<handle
    %PROFILEPANELCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        Component
        popup
        button
        
        nprofile
        ProfileArray
        ProfileNameList
        aprofile
        
    end
    
    methods
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = ProfilePanelClass (nprofile, aprofile)
            if nargin > 0
                obj.nprofile=nprofile;
                obj.aprofile=aprofile;
            end
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Métodos que criam os objetos que compõem a tela%%%%%%%%%%%
        function Obj = CriaComponent (Obj, Parent)
            Obj.Component = ViewConstructor.Panel(Parent,'Profile Information');
        end
        
        function Obj = CriaObjetos (Obj)
           
            ViewConstructor.Text (Obj.Component, [0.05 0.58 0.45 0.12], 'Data Processing Profile:');   
            ViewConstructor.Button(Obj.Component,'Add',[0.63 0.50 0.15 0.25],{@ProfileInformationPanel,2});
            Obj.button(2)= ViewConstructor.Button(Obj.Component,'Del',[0.79 0.50 0.15 0.25],{@ProfileInformationPanel,3});   
            Obj.popup(1) = ViewConstructor.Popupmenu (Obj.Component, [0.10 0.3 0.45 0.13] ,'Select Profile',{@ProfileInformationPanel,1});
            set(Obj.popup(1),'Enable','off');
            set(Obj.button(2),'Enable','off');
            Obj.nprofile=0;
            
            %%%%Callback dos objetos%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            function ProfileInformationPanel(~,~, whichHandle)
                switch whichHandle
                    case 1 % Profile Popup menu
                        Obj.Profilechoose;
                        
                    case 2 % Add profile button
                        %Atualiza componentes da interface
                        Obj.Seton;
                        Obj.AddProfile;
            
                    case 3
                        Obj.DelProfile;
                        
                end
    
            end
        end    
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Métodos que modificam as propriedades do objeto%%%%%%%%%%%
        
        function Obj = DelProfile (Obj)
            %Atualiza a variável que guarda os nomes dos profiles
            Selection=get(Obj.popup(1),'Value');
            Obj.ProfileNameList(Selection,:)=[];
            
            %Deleta o Profile
            Obj.ProfileArray(Selection)=[];
                        
            %Atualiza variáveis de cálculo e o popup
            Obj.nprofile = Obj.nprofile -1;
            if Obj.nprofile < 1
                set(Obj.popup(1), 'String', 'Select Profile');       
                Obj.Setoff;
            else
                if Selection ==1
                    set(Obj.popup(1), 'String', Obj.ProfileNameList,'Value',(Selection));
                else
                    set(Obj.popup(1), 'String', Obj.ProfileNameList,'Value',(Selection-1));
                end
            end
            
            %Atualiza o profile selecionado
            Obj.Profilechoose;
            
            %Atualiza os outros componentes da interface
            Obj.RefreshProfile;
        end
       
        function Obj = Seton (Obj)
            set(Obj.popup(1),'Enable','on');
            set(Obj.button(2),'Enable','on');
        end
        
        function Obj = Setoff (Obj)
            set(Obj.popup(1),'Enable','off');
            set(Obj.button(2),'Enable','off');
        end
        
        function Obj = Profilechoose (Obj)
            
            %Determina o perfil atual
            Obj.aprofile = get(Obj.popup(1),'Value');
            
        end
        
        function Obj = RefreshProfile (Obj)
            %Atualiza todos os componentes da interface conforme as escolhas feitas anteriormente
            AbaData.RefreshVal (Obj.ProfileArray(Obj.aprofile));
            AbaStrain.RefreshVal (Obj.ProfileArray(Obj.aprofile));
            AbaCalculus.RefreshVal (Obj.ProfileArray(Obj.aprofile));
            AbaUncertainty.RefreshVal (Obj.ProfileArray(Obj.aprofile));
            AbaExport.RefreshVal (Obj.ProfileArray(Obj.aprofile));
        end
        
        function Obj = AddProfile (Obj)
            
            %Atualiza número de profiles
            Obj.nprofile = Obj.nprofile + 1;
            
            %Reserva de memória para propriedade que guarda os nomes dos profiles
            if Obj.nprofile==1
                Obj.ProfileNameList=cell(1,1);
            else
                Obj.ProfileNameList{Obj.nprofile,1}=[];
            end
                        
            %Atualiza popup e propriedade que guarda os nomes dos profiles
            name = ['Profile' num2str(Obj.nprofile)];
            Obj.ProfileNameList{Obj.nprofile,1}=name;
            set(Obj.popup(1), 'String', Obj.ProfileNameList, 'Value', find(ismember(Obj.ProfileNameList,name)));       
       
            %Atualiza o índice do perfil atual
            Obj.Profilechoose;
       
            %Criação do novo profile
            if Obj.nprofile==1
                Obj.ProfileArray = Profile (Obj.aprofile,0); 
                Obj.ProfileArray.Config = Config; 
                Obj.ProfileArray.ArrayData = Data;
            else
                Obj.ProfileArray(Obj.nprofile) = Profile (Obj.aprofile,0); 
                Obj.ProfileArray(Obj.nprofile).Config = Config; 
                Obj.ProfileArray(Obj.nprofile).ArrayData = Data;
            end
            
            %Atualiza os outros componentes da interface
            Obj.RefreshProfile;
        end
                        
        
    end
    
    
                        
end
    



