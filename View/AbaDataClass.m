classdef AbaDataClass<handle
    %ABADATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        %Componentes Passivos
        Component
        Fundo
        FundoTable
        
        %Componentes Ativos
        AddButton
        DataTable
        DeleteHtml
    end
    
    methods
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = AbaDataClass
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%M�todos que modificam as propriedades do objeto%%%%%%%%%%%
        function Obj = CriaComponent (Obj, Parent)
            Obj.Component = uiextras.VBox( 'Parent', Parent );
        end
        
        function Obj = CriaObjetos (Obj)
           
            %Fundos
            Obj.Fundo = ViewConstructor.Fundo (Obj.Component);                                                % Fundo para os bot�es no Vbox Superior
            Obj.FundoTable = uiextras.HBox('Parent', Obj.Component);                                          % Fundo da tabela dividido em 3 HBox
            
            %Bot�es
            Obj.AddButton = ViewConstructor.Button(Obj.Fundo,'Add',[0.05 0.15 0.15 0.55], {@AddData});        % Bot�o Add
            
            %Tabela
            ViewConstructor.Fundo(Obj.FundoTable);                                                        % Espa�o vacio lateral esquerdo da tabela
            Obj.DataTable = ViewConstructor.Table (Obj.FundoTable,{'ID', 'Data Name', 'Lo', 'Show', 'Del'},...
               {'char', 'char','numeric','logical','char'},[false, false, true, true, false],...
               {40 258 80 40 40},[0.05 0.05 0.9 0.75],{@InDataTableEdit},{@InDataTableSelect});               %Tabela de Dados
            ViewConstructor.Fundo(Obj.FundoTable);                                                        % Espa�o vacio lateral direito da tabela
            Obj.DeleteHtml = ['<html><img src="file:/' pwd '/Imagens/Icons/DeleteSmall.png"/></html>']; %Delete icon add data table
            Obj.Configure;
            
            %%%%%%%%%%%%%Callback do bot�o que adiciona arquivos%%%%%%%%%%%
                function AddData(hObject, ~, ~)
                    [name,path] = uigetfile('*.dat','Import File');            %Nome do arquivo de dados
                
                    %M�todo que valida o formato dos dados
                    [valida,file] = Obj.ValidaDados (name, path, hObject);
                    if valida==0
                        return;
                    end
                
                    %Executa m�todos que modificam o Profile
                    ProfileArray.AddCurve (name, file);

                    %Executa m�todos que modificam a aba Strain
                    aux=get(Obj.DataTable,'Data');
                    CurveName=aux{:,2};
                    AbaStrain.RefreshPopup(CurveName);
                                            %CurveName = {ProfileArray(actualprofile).ArrayData.Name};  %Atualiza array com os nomes das curvas - utilizado por outras abas
                                            %set(handleAba2.popup(1),'String',CurveName)                %Atualiza string com os nomes das curvas na aba de corre��o do strain

                                            %Executa m�todos que modificam o controle gr�fico
                                            %set(GraphicControl.popup(2),'String',CurveName)            %Atualiza string do popup de escolha do gr�fico
                end
        
            %-- Mudar cor do ID ou eliminar arquivo de dados experimentais da tabela
            %-- principal. Esses "bot�es" s�o ativados quando o campo � selecionado
                function InDataTableSelect(~,EventData)
                if ~isnan(EventData.Indices)
                    indices= EventData.Indices;
                    line=indices(1,1); col=indices(1,2);
                    if col==1 % create color for id
                        CorArray{ncurvas} = uisetcolor;
                        ProfileArray(actualprofile).ArrayData(line).IdColor = CorArray{ncurvas};
                        ProfileArray(actualprofile).ArrayData(line).ImgColor = FuncColorButtom(CorArray{ncurvas},actualprofile);
                        UpdateDataTable(line,col,ProfileArray(actualprofile).ArrayData(line).ImgColor)
                    elseif col==5 % delete line
                        AddDataTableValue=get(handleAba1.Table1,'Data');
                        AddDataTableValue(line,:)=[];
                        set(handleAba1.Table1,'Data', AddDataTableValue,'ColumnWidth',{40 258 80 40 40});
                        ProfileArray(actualprofile).ArrayData(line) = [];    %deletar a fila do array de objetos...
                        ncurvas=ncurvas-1;
                        % FALTA ATUALIZAR OS POPUPS
   
                    end
                    return;
                end
            end

      
            end
            
        function [valida,file] = ValidaDados (~, name, path, hObject)

            %Verifica se o bot�o cancel foi apertado (name=0)
            if name == 0
                valida=0;
                return;
            end

            %Determina as caracter�sticas do arquivo carregado (nome e tamanho)    
            [~,~,ext]=fileparts(name);                                 %Extens�o do arquivo de dados
            file=load([path name]);                                    %Matriz do arquivo da matriz de dados            
            sizeFile = size(file);                                     %Tamanho da matriz de dados

            %Verifica se a extens�o do arquivo e se a formata��o do arquivo s�o compat�veis 
            if (strcmp (ext,'.dat')+ strcmp (ext,'.txt'))==0 %Verificar a extens�o do arquivo
                errordlg('Bad input data format! Please import a .dat or . txt file.','Warning','modal');
                uicontrol(hObject);
                valida=0;
                return;
            elseif sizeFile(1,2) ~= 3 %Verificar se a matriz possui 3 colunas
                errordlg('File with invalid number of colums. Please import a file with 3 colums.      (t T DL)','Warning','modal');
                uicontrol(hObject);
                valida=0;
                return;
            end

            %Verifica se os dados foram validados
            valida=1;
        end

        function Obj = Configure (Obj)
            
            set( Obj.FundoTable, 'Sizes', [10 -1 10], 'Spacing', 5 ); % Configura��o laterais da tabela
            set( Obj.Component, 'Sizes', [70 -1], 'Spacing', 5 ); % Configura��o Vbox Bot�es / Tabela
        end
        
        function Obj = RefreshVal (Obj, Profile)
            Data2Table = cell(Profile.nCurves,5);
            for i=1:Profile.nCurves
                Data2Table{i,:}=[Profile.ArrayData(i).ImgColor Profile.ArrayData(i).Name '' Profile.ArrayData(i).Show Obj.DeleteHtml];
            end
            set (Obj.DataTable, 'Data', Data2Table);
        end
            
       
    end
    
    
end

