classdef TelaClass <handle
    %TELAPRINCIPAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    
        %Layout
        Tela
        Fundo
        
        %Lado Esquerdo do Layout
        LadoEsquerdo
        FundoEsquerdo
        EsquerdoSup
        EsquerdoInt
        EsquerdoInf
        
        %Lado Direito do Layout
        LadoDireito
        FundoDireito
        DireitoSup
        DireitoInf
        
        %Componentes principais do Layout
        PanelLogo
        ProfilePanel
        AbaData
        AbaStrain
        AbaCalculus
        AbaUncertainty
        AbaAnalysis
        AbaArrhenius
        AbaMSC
        DDensity
        
        %Variáveis utilizadas por vários componentes
        CorArray
        
        %Componentes do Profile Panel
        popupPP
        buttonPP
        ButtonSave
        ButtonLoad
        
        %Características do Profile
        nprofile
        nprofiletotal
        ProfileArray
        ProfileNameList
        Aprofile
        
        %Componentes da Aba Data
        FundoTable1
        FundoTable2
        AddButton
        DataTable
        DeleteHtml
        
        %Componentes da Aba Strain
        FundoEsqStrain
        FundoDirStrain
        Panel2
        FundoApply
        ApplyBStrain
        Button2
        Text2
        popup2
        rbh2
        EditText2
        CheckBox2
        
        %Componentes da Aba Calculations
        FundoEsqCalc
        FundoDirCalc
        Panel3
        FundoApply2
        ApplyButton2
        CheckBox3
        Text3
        EditText3
        rbh3
        Popup3
        Button3
        Slider3
        Tela3
        
        %Componentes da Aba Uncertainty
        EditText4
        Panel4
        rbh4
        Text4
        ApplyButtonUnc
        FundoEsqUnc
        FundoDirUnc
        FundoMessage
        Button4
        Stringname
        
        %Componentes da Aba Arrhenius
        Panel7
        FundoEsqArr
        FundoDirArr
        rbh7
        Text7
        EditText7
        ListBox7
        Button7
        FundoArr1
        
        %Componentes da Aba MSC
        FundoEsqMSC
        FundoDirMSC
        Panel8
        Text8
        EditText8
        rbh8
        ListBox8
        Button8
        FundoMSC1
        Popup8
                
        %Componentes da Aba Analysis
        Panel9
        Text9
        EditText9
        rbh9
        FundoAnl1
        FundoAnl2
        FundoAnl3
        Button9
        
        
        %Componentes do GraphControl
        Margem1
        Margem2
        Margem3
        Cabecalho
        Cabecalho2
        Espaco
        FundoEsqGraph
        FundoDirGraph
        Panel6
        Text6
        Popup6
        ListBox6
        GraphText
        ListGraphBox
        Button6
        Listsize
        
        %Componentes do GraphAxes
        GraphAxes
        Curva
        
    end
    
    methods
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%Construtor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = TelaClass
            obj.nprofiletotal=0;
           
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%Funções que modificam a Tela%%%%%%%%%%%%%%%%%%%%%%%%%
        function Obj= CriaToolbar (Obj)

            set(0,'Showhidden','on');
            set(Obj.Tela,'Toolbar','figure');
            ch = get(gcf,'children');
            UT = get(ch,'children');
            delete(UT(1));
            delete(UT(2));
            delete(UT(5));
            delete(UT(16));
            delete(UT(15));
            delete(UT(14));
            delete(UT(13));
            delete(UT(6));
            
        end
            
        function Obj = CriaTela (Obj)
            Obj.Tela = figure('Position',[50 50 1000 609],'Name','SinteringFit',...
                'Color', Colors.Branco ,'MenuBar','none','NumberTitle','off');
            
        end
        
        function Obj = Maximizee (Obj)
            maximize(gcf);
        end
        
        function Obj = Layout2 (Obj)
            %%%Cria tela de fundo
            Obj.Fundo= uiextras.HBox( 'Parent', Obj.Tela);
            
            %%%Divide o fundo em lado direito e esquerdo
            Obj.LadoEsquerdo=uiextras.VBoxFlex( 'Parent', Obj.Fundo);
            Obj.LadoDireito= uiextras.BoxPanel( 'Title', 'Graph', 'Parent', Obj.Fundo,'TitleColor',Colors.Azulclaro);
            set( Obj.Fundo, 'Sizes', [500 -1], 'Spacing', 5 );             % Configura o tamanho da janela
            set( Obj.LadoDireito, 'DockFcn', {@nDock, 1} );
            
            %%%Cria lado direito da tela
            Obj.FundoDireito = uiextras.VBoxFlex( 'Parent', Obj.LadoDireito);
            %Direito Superior
            Obj.DireitoSup=ViewConstructor.Fundo (Obj.FundoDireito);
            set(Obj.DireitoSup,'BackgroundColor',Colors.Branco);
            %Direito Inferior
            Obj.DireitoInf= uiextras.VBox(  'Parent', Obj.FundoDireito);
            %Configuração
            set( Obj.FundoDireito, 'Sizes', [-4 -1], 'Spacing', 5,'MinimumSizes',[300 150]);    
            
            %%%Cria lado esquerdo da tela
            Obj.FundoEsquerdo= uiextras.VBoxFlex( 'Parent', Obj.LadoEsquerdo);
            %Esquerdoo Superior
            Obj.EsquerdoSup= uiextras.HBox( 'Parent', Obj.FundoEsquerdo);
            Obj.PanelLogo = ViewConstructor.Fundo (Obj.EsquerdoSup); 
            Obj.ProfilePanel=ViewConstructor.Panel(Obj.EsquerdoSup,'Profile Information');
            set( Obj.EsquerdoSup, 'Sizes', [-1 -2], 'Spacing', 5 );          % Tamanho das colunas
            %Esquerdo Intermediário
            Obj.EsquerdoInt= uiextras.TabPanel('Parent',Obj.FundoEsquerdo,'BackgroundColor',[0.97 0.97 0.97],'TabSize',60,'Padding', 5,...
                'ForegroundColor',Colors.Preto);
            Obj.AbaData= uiextras.VBox( 'Parent', Obj.EsquerdoInt);
            Obj.AbaStrain= uiextras.HBox( 'Parent', Obj.EsquerdoInt );
            Obj.AbaCalculus = uiextras.HBox( 'Parent', Obj.EsquerdoInt );
            Obj.AbaUncertainty = uiextras.HBox( 'Parent', Obj.EsquerdoInt );
            Obj.AbaArrhenius = uiextras.HBox( 'Parent', Obj.EsquerdoInt );
            Obj.AbaMSC = uiextras.HBox( 'Parent', Obj.EsquerdoInt );
            Obj.AbaAnalysis = uiextras.HBox( 'Parent', Obj.EsquerdoInt );
            %Esquerdo Inferior
            ViewConstructor.Fundo (Obj.FundoEsquerdo);                      % Espaço vazio embaixo das abas... Reservado para mensagens
            %Configuração
            set(Obj.FundoEsquerdo, 'Sizes', [120 430 -1], 'Spacing', 5 );     % Tamanho das linhas do lado esquerdo
            set (Obj.EsquerdoInt, 'TabNames',{'Data', 'Strain', 'Calculations', 'Uncertainty', 'Arrhenius', 'MSC', 'Analysis'},...
                'SelectedChild', 1);
            
                %-- Separar ou juntar os gráficos das abas de análise de dados  
                function nDock( ~, ~, whichpanel )
                    Obj.LadoDireito.IsDocked = ~Obj.LadoDireito.IsDocked;% Set the flag
                    if Obj.LadoDireito.IsDocked
                        newfig = get( Obj.LadoDireito, 'Parent' ); % Put it back into the layout
                        set( Obj.LadoDireito, 'Parent', Obj.Fundo );
                        delete( newfig );
                    else 
                        pos = getpixelposition( Obj.LadoDireito ); % Take it out of the layout
                        newfig = figure( ...
                            'Name', get( Obj.LadoDireito, 'Title' ), ...
                            'NumberTitle', 'off', 'MenuBar', 'none', ...
                            'Toolbar', 'none', 'Position',[50 50 1000 609],...
                            'CloseRequestFcn', {@nDock, whichpanel} );
                        figpos = get( newfig, 'Position' );
                        set( newfig, 'Position', [figpos(1,1:2), pos(1,3:4)] );
                        set( Obj.LadoDireito, 'Parent', newfig, ...
                            'Units', 'Normalized', 'Position', [0 0 1 1] );
                    end 
                end 
            
        end
        
        function Obj = MakeCorArray (Obj)
            Obj.CorArray{1}=Colors.Preto;
            Obj.CorArray{2}=Colors.Vermelho; 
            Obj.CorArray{3}=Colors.Azul;
            Obj.CorArray{4}=Colors.Verde;
            Obj.CorArray{5}=Colors.Laranja;
            Obj.CorArray{6}=Colors.Amarelo;
            Obj.CorArray{7}=Colors.Magenta;
            Obj.CorArray{8}=Colors.Cyan;
            Obj.CorArray{9}=Colors.Amarelototal;
            Obj.CorArray{10}=Colors.Verdetotal;
            Obj.CorArray{11}=Colors.Rosa;
            Obj.CorArray{12}=Colors.Roxo;
            Obj.CorArray{13}=Colors.Marrom;
            Obj.CorArray{14}=Colors.Azulclaro;
            Obj.CorArray{15}=Colors.Amarelomarrom;
            Obj.CorArray{16}=Colors.Branco;
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%Métodos utilizados pelo Profile Panel%%%%%%%%%%%%%%

        function Obj = ProfilePanelComp (Obj)
           
            ViewConstructor.Text (Obj.ProfilePanel, [0.05 0.58 0.45 0.12], 'Data Processing Profile:');   
            ViewConstructor.Button(Obj.ProfilePanel,'Add',[0.63 0.50 0.15 0.25],{@ProfileInformationPanel,2});
            Obj.buttonPP(1)= ViewConstructor.Button(Obj.ProfilePanel,'Del',[0.79 0.50 0.15 0.25],{@ProfileInformationPanel,3});   
            Obj.popupPP(1) = ViewConstructor.Popupmenu (Obj.ProfilePanel, [0.10 0.3 0.45 0.13] ,'Select Profile',{@ProfileInformationPanel,1});
            Obj.ButtonSave = ViewConstructor.Button(Obj.ProfilePanel,'Save',[0.63 0.15 0.15 0.25], {@SaveData});      % Botão 
            Obj.ButtonLoad = ViewConstructor.Button(Obj.ProfilePanel,'Load',[0.79 0.15 0.15 0.25], {@LoadData});      % Botão 
            set(Obj.popupPP(1),'Enable','off');
            set(Obj.buttonPP(1),'Enable','off');
            Obj.nprofile=0;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%Callbacks%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%Callback dos objetos%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            function ProfileInformationPanel(~,~, whichHandle)
                switch whichHandle
                    case 1 % Profile Popup menu
                        Obj.Profilechoose;
                        
                    case 2 % Add profile button
                        %Atualiza componentes da interface
                        Obj.SetPPon;
                        Obj.AddProfile;
            
                    case 3 %Delete profile button
                        Obj.DelProfile;
                        
                end
    
            end
            
                function SaveData(~,~) %SaveData(self,~,~)
                      [fileName,pathName]=uiputfile('.mat','Save object to MAT file');
                      if fileName ==0
                          return;
                      end
                      obj = Obj.ProfileArray(Obj.Aprofile); %#ok<NASGU>
                      save(fullfile(pathName,fileName),'obj');
                       
                end

                function LoadData(~, ~, ~)
                    [name,path] = uigetfile('*.mat','Import File'); %Nome do arquivo de dados
                    if name ==0
                          return;
                    end
                    tmp = load(fullfile(path,name));

                    Obj.nprofile = Obj.nprofile + 1; %Atualiza número de profiles
                    Obj.nprofiletotal = Obj.nprofiletotal + 1; %Atualiza número de profiles

                    %Reserva de memória para propriedade que guarda os nomes dos profiles
                    if Obj.nprofile==1
                        Obj.ProfileNameList=cell(1,1);
                    else
                        Obj.ProfileNameList{Obj.nprofile,1}=[];
                    end
                    
                    %Atualiza popup e propriedade que guarda os nomes dos profiles
                    name = ['Profile' num2str(Obj.nprofiletotal)];
                    Obj.ProfileNameList{Obj.nprofile,1}=name;
                    set(Obj.popupPP(1),'Value', 1);
                    set(Obj.popupPP(1), 'Value', find(ismember(Obj.ProfileNameList,name)),'String', Obj.ProfileNameList );       

                    Obj.SetPPon;
                    Obj.Profilechoose2; %Atualiza o índice do perfil atual
                    
                    %Carrega as informações no novo profile
                    if Obj.nprofile==1
                        Obj.ProfileArray = tmp.obj; 
                    else
                        Obj.ProfileArray(Obj.nprofile) = tmp.obj; 
                    end
                    
                    Obj.RefreshProfile; %Atualiza os outros componentes da interface
                    Obj.RefreshGraph; %Atualiza o gráfico
                    Obj.RefreshListBox2;
                end
            
        end
        
        function Obj = DelProfile (Obj)
            
            %Atualiza a variável que guarda os nomes dos profiles
            Selection=get(Obj.popupPP(1),'Value');
            Obj.ProfileNameList(Selection,:)=[];
            
            %Deleta o Profile
            Obj.ProfileArray(Selection)=[];
                        
            %Atualiza variáveis de cálculo e o popup
            Obj.nprofile = Obj.nprofile -1;
            if Obj.nprofile < 1
                set(Obj.popupPP(1), 'String', 'Select Profile');       
                Obj.SetPPoff;
                Obj.ResetInterface;
            else
                if Selection ==1
                    set(Obj.popupPP(1), 'Value',(Selection),'String', Obj.ProfileNameList);
                else
                    set(Obj.popupPP(1), 'Value',(Selection-1), 'String', Obj.ProfileNameList);
                end
            end
            
            %Atualiza o profile selecionado
            Obj.Profilechoose;
            
        end
       
        function Obj = SetPPon (Obj)
            
            %Torna acessível o profile panel
            set(Obj.popupPP(1),'Enable','on');
            set(Obj.buttonPP(1),'Enable','on');
            set (Obj.AddButton, 'Enable', 'on');
            set (Obj.Popup6(1), 'Enable', 'on');
            set (Obj.Popup6(2), 'Enable', 'on');
        end
        
        function Obj = SetPPoff (Obj)
            
            %Torna inacessível o profile panel
            set(Obj.popupPP(1),'Enable','off');
            set(Obj.buttonPP(1),'Enable','off');
            set (Obj.AddButton, 'Enable', 'off');
            set (Obj.Popup6(1), 'Enable', 'off');
            set (Obj.Popup6(2), 'Enable', 'off');
            
        end
        
        function Obj = Profilechoose (Obj)
            
            %Determina o perfil atual
            Obj.Aprofile = get(Obj.popupPP(1),'Value');
            %Atualiza os outros componentes da interface
            if Obj.nprofile > 0
                Obj.RefreshProfile;
                Obj.RefreshGraph;
                
            else
                %Reseta o programa
                Obj.ResetInterface;
            end
                        
        end
        
        function Obj = Profilechoose2 (Obj)
            
            %Determina o perfil atual
            Obj.Aprofile = get(Obj.popupPP(1),'Value');
        end
        
        function Obj = RefreshProfile (Obj)
            Obj.RefreshTable;
            Obj.RefreshStrainAba;
            Obj.RefreshCalculusAba;
            Obj.RefreshAbaUncertainty;
            Obj.EnableAbaArr;
            Obj.EnableAbaMSC;
            Obj.RefreshAbaAnalysis;
        end
        
        function Obj = AddProfile (Obj)
            
            %Atualiza número de profiles
            Obj.nprofile = Obj.nprofile + 1;
            Obj.nprofiletotal = Obj.nprofiletotal + 1;
            
            %Reserva de memória para propriedade que guarda os nomes dos profiles
            if Obj.nprofile==1
                Obj.ProfileNameList=cell(1,1);
            else
                Obj.ProfileNameList{Obj.nprofile,1}=[];
            end
                        
            %Atualiza popup e propriedade que guarda os nomes dos profiles
            name = ['Profile' num2str(Obj.nprofiletotal)];
            Obj.ProfileNameList{Obj.nprofile,1}=name;
            set(Obj.popupPP(1), 'String', Obj.ProfileNameList, 'Value', find(ismember(Obj.ProfileNameList,name)));       
       
            %Atualiza o índice do perfil atual
            Obj.Profilechoose2;
       
            %Criação do novo profile
            if Obj.nprofile==1
                Obj.ProfileArray = Profile (Obj.Aprofile,0); 
                Obj.ProfileArray.Config = Configclass; 
            else
                Obj.ProfileArray(Obj.nprofile) = Profile (Obj.Aprofile,0); 
                Obj.ProfileArray(Obj.nprofile).Config = Configclass; 
            end
            
            %Atualiza os outros componentes da interface
            Obj.RefreshProfile;
            Obj.RefreshGraph;
            set (Obj.ListBox6, 'Value', 1);
            
        end
        
        function Obj = ResetInterface (Obj)
            
            %Reseta os flags das abas
            if Obj.nprofile>0
                Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag=0;
                Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag=0;
                Obj.ProfileArray(Obj.Aprofile).MSCFlag=0;
                Obj.ProfileArray(Obj.Aprofile).DensityFlag=0;
                Obj.ProfileArray(Obj.Aprofile).ArrheniusFlag=0;
                Obj.ProfileArray(Obj.Aprofile).Config.LoMethod=[];
            end
            
            %Reseta a interface
            Obj.RefreshTable;
            Obj.ResetStrainAba;
            Obj.ResetAbaDensities;
            Obj.ResetAbaMSC;
            Obj.ResetAbaArrhenius;
            Obj.ResetAbaUncertainty;
            Obj.ResetGraph;
            Obj.ResetAbaAnalysis;
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%Funções que criam os componentes da aba Data%%%%%%%%%%%%%
        %%%%%%%%%%
        
        function Obj = AbaDataComp (Obj)
        
            %Fundos
            Obj.FundoTable1 = ViewConstructor.Fundo (Obj.AbaData);                                                % Fundo para os botões no Vbox Superior
            Obj.FundoTable2 = uiextras.HBox('Parent', Obj.AbaData);                                               % Fundo da tabela dividido em 3 HBox
            Obj.AddButton = ViewConstructor.Button(Obj.FundoTable1,'Add',[0.05 0.15 0.15 0.55], {@AddData});      % Botão Add
            ViewConstructor.Fundo(Obj.FundoTable2);                                                               % Espaço vazio lateral esquerdo da tabela
            Obj.DataTable = ViewConstructor.Table (Obj.FundoTable2,{'ID', 'Data Name', 'Green Density','Lo', 'Show', 'Del'},...
               {'char', 'char','numeric', 'numeric', 'logical','char'},[false, false, true, true, true, false],...
               {40 158 100 80 40 40},[0.05 0.05 0.9 0.75],{@InDataTableEdit},{@InDataTableSelect});                   %Tabela de Dados
            ViewConstructor.Fundo(Obj.FundoTable2);                                                                   % Espaço vazio lateral direito da tabela
            Obj.DeleteHtml = ['<html><img src="file:/' pwd '/Imagens/Icons/DeleteSmall.png"/></html>'];           %Delete icon add data table
            set( Obj.FundoTable2, 'Sizes', [10 -1 10], 'Spacing', 5 ); % Configuração laterais da tabela
            set( Obj.AbaData, 'Sizes', [70 -1], 'Spacing', 5 ); % Configuração Vbox Botões / Tabela
            set (Obj.AddButton, 'Enable', 'off');
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%Callbacks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %Adiciona novo conjunto de dados a tabela
                function AddData(hObject, ~, ~)
                    [name,path] = uigetfile('*.dat','Import File');            %Nome do arquivo de dados
                    
                    %Método que valida o formato dos dados
                    [valida,file] = Obj.ValidaDados (name, path, hObject);
                    if valida==0
                        return;
                    end
                
                    %Executa métodos que modificam o Profile
                    Obj.ResetInterface;
                    Obj.AddCurve (name, file);
                    aux1 = 3;
                    aux2 = get (Obj.ListBox6, 'String');
                    aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                    Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                    Obj.GraphData;
                    set (Obj.ListBox6, 'Value', 3);
                    
                    %Executa método que atualiza os dados da tabela e permite o acesso a aba strain
                    Obj.RefreshTable;
                    Obj.EnablePanel21 ('on');
                    set(Obj.CheckBox2(5),'Enable','off');
                    set(Obj.ApplyBStrain, 'Enable', 'on');
                    
                end
        
                %Muda cor do ID ou elimina conjunto de dados da tabela
                function InDataTableSelect(~,EventData)
                    if ~isnan(EventData.Indices)
                        indices= EventData.Indices;
                        line=indices(1,1); col=indices(1,2);
                        if col==1 % create color for id
                            Obj.MudaIdColor (line);
                            
                        elseif col==6 % delete line
                            Obj.DeleteCurve (line); 
                            
                            
                        end
                        return;
                    end
                end
                
                %Atualiza o Lo ou o Show
                function InDataTableEdit(~,EventData)
                    indices = EventData.Indices;
                    line=indices(1,1);
                    col=indices(1,2); 
                    
                    
                    if col==4 %Edit Lo Value
                        if ~isnan(EventData.NewData)
                            Obj.ProfileArray(Obj.Aprofile).ArrayData(line).Lo=EventData.NewData;
                            Obj.RefreshTable;
                        else
                            errordlg('You must enter a numeric value','Bad Input','modal');
                        end    
                    
                        
                    elseif col==3
                        if ~isnan(EventData.NewData)
                            Obj.ProfileArray(Obj.Aprofile).ArrayData(line).Densities.Dens0=EventData.NewData;
                            Obj.RefreshTable;
                        else
                            errordlg('You must enter a numeric value','Bad Input','modal');
                        end    
                        
                    elseif col==5 % Select Show Checkbox
                        Obj.ProfileArray(Obj.Aprofile).ArrayData(line).Show = EventData.NewData;
                        nshow=0;
                        for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                            if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==1
                                nshow=nshow+1;
                            end
                        end
                        CurvesNames=cell(nshow,1);
                        CurveName = {Obj.ProfileArray(Obj.Aprofile).ArrayData.Name};
                        n=1;
                        for j=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                            if Obj.ProfileArray(Obj.Aprofile).ArrayData(j).Show==1
                                CurvesNames{n}=CurveName{j};
                                n=n+1;
                            end
                        end
                        Obj.RefreshGraph;

                    end
                end
         
      
        end
            
        function Obj = DeleteCurve (Obj, line)

            %Bloco que modifica a tabela
            Data2Table=get(Obj.DataTable,'Data');
            Data2Table(line,:)=[];
            set(Obj.DataTable,'Data', Data2Table,'ColumnWidth',{40 158 100 80 40 40});
            Obj.ProfileArray(Obj.Aprofile).ArrayData(line) = [];    %deletar a fila do array de objetos...
            Obj.ProfileArray(Obj.Aprofile).nCurves=Obj.ProfileArray(Obj.Aprofile).nCurves-1;
            
            %Bloco que atualiza listbox da aba strain
            if line == Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo
                Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo=1;
                Obj.RefreshStrainPopup;
            elseif line < Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo
                Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo=Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo-1;
                Obj.RefreshStrainPopup;
            end
            Obj.RefreshGraph;
            
            %%%%%%%%Bloco que verifica se todas curvas foram apagadas
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                Obj.ResetInterface;
            end
        end
        
        function Obj = MudaIdColor (Obj, line)
            
            %Determina o profile a modificar
            profile=Obj.Aprofile;
            
            %Modifica a cor da curva escolhida
            aux = uisetcolor;
            aux2=size(aux);
            if aux ==0 
                if aux2(1,2)==1
                    return;
                end
            end
            Obj.ProfileArray(profile).ArrayData(line).IdColor = aux;
            Obj.FuncColorButton(aux,line);
            
            %Atualiza a tabela e o grafico
            Obj.RefreshTable;
            Obj.RefreshGraph;
                    
        end

        function [valida,file] = ValidaDados (~, name, path, hObject)

            %Verifica se o botão cancel foi apertado (name=0)
            if name == 0
                valida=0;
                file=0;
                return;
            end

            %Determina as características do arquivo carregado (nome e tamanho)    
            [~,~,ext]=fileparts(name);                                 %Extensão do arquivo de dados
            file=load([path name]);                                    %Matriz do arquivo da matriz de dados            
            sizeFile = size(file);                                     %Tamanho da matriz de dados

            %Verifica se a extensão do arquivo e se a formatação do arquivo são compatíveis 
            if (strcmp (ext,'.dat')+ strcmp (ext,'.txt'))==0 %Verificar a extensão do arquivo
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
        
        function Obj = AddCurve (Obj, name, file)
            
            %Atualização de variáveis e atribuição de propriedades
            Obj.ProfileArray(Obj.Aprofile).nCurves=Obj.ProfileArray(Obj.Aprofile).nCurves+1;
            
            %Atribuição da curva
            i=Obj.ProfileArray(Obj.Aprofile).nCurves;
            if i==1
                Obj.ProfileArray(Obj.Aprofile).ArrayData=Data(name,Obj.CorArray{i},file,true);
                Obj.FuncColorButton (Obj.CorArray{i},i);
            else
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i)=Data(name,Obj.CorArray{i},file,true);
                Obj.FuncColorButton(Obj.CorArray{i},i);
            end
            
            %Atualiza a aba strain e o gráfico
            Obj.RefreshStrainPopup;
            Obj.ProfileArray(Obj.Aprofile).GraphFlag(1,1)=1;
            Obj.ProfileArray(Obj.Aprofile).GraphFlag(2,1)=1;
            Obj.RefreshListBox;
            
                        
        end
        
        function Obj = FuncColorButton (Obj, Cor, line)
            
            %Gera a imagem com a cor escolhida
            profile=Obj.Aprofile;
            Image = ones([12 12]);    % square composed of index "1"s IndataTable 
            colormap(1,:) = Cor; % index "1" -> red
            folder=pwd;
            arquivo = [folder '/Imagens/Colors/IdColor' num2str(line) 'Profile' num2str(profile) '.png'];
            imwrite(Image,colormap,arquivo);
            Obj.ProfileArray(profile).ArrayData(line).ImgColor = ['<html><img src="file:/' pwd '/Imagens/Colors/IdColor' num2str(line) 'Profile' num2str(profile) '.png"/></html>'];      
        end

        function Obj = RefreshTable (Obj)
            
            %Atualiza todas as informaçoes da tabela
            set (Obj.DataTable, 'Data', []);
            if Obj.nprofile >0
                Data2Table = cell(Obj.ProfileArray(Obj.Aprofile).nCurves,6);
                for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                    Obj.FuncColorButton(Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor,i);
                    Data2Table(i,:)={Obj.ProfileArray(Obj.Aprofile).ArrayData(i).ImgColor,Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Name, Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Dens0, Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Lo,Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show,Obj.DeleteHtml};
                end
            set (Obj.DataTable, 'Data', Data2Table);
            end
        end
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%Funções que criam os componentes da aba Strain%%%%%%%%%%%  
        
        function Obj = AbaStrainComp (Obj)
        
            %Fundos
            Obj.FundoEsqStrain = uiextras.VBox('Parent', Obj.AbaStrain);
            Obj.FundoDirStrain= uiextras.VBox('Parent', Obj.AbaStrain);
            
            %Criação dos panel
            Obj.Panel2(1)=ViewConstructor.Panel(Obj.FundoEsqStrain,'Correction');
            Obj.Panel2(2)=ViewConstructor.Panel(Obj.FundoDirStrain,'T0');
            Obj.Panel2(3)=ViewConstructor.Panel(Obj.FundoDirStrain,'L0');
            Obj.Panel2(4)=ViewConstructor.Panel(Obj.FundoDirStrain,'Push Rod Expansion');
            Obj.Panel2(5)=ViewConstructor.Panel(Obj.FundoDirStrain,'Simple Expansion');
            
            %Criação do fundo e do botão para Apply 
            Obj.FundoApply= ViewConstructor.Fundo (Obj.FundoEsqStrain);          % Fundo para os botões no Vbox Superior 
            Obj.ApplyBStrain = ViewConstructor.Button(Obj.FundoApply,'Apply',[0.35 0.4 0.3 0.20], {@CorrectionConfigFunc,5});
             
            %Criação dos objetos do panel1
            Obj.CheckBox2(1) = ViewConstructor.Checkbox (Obj.Panel2(1), 'To', [0.03 0.85 0.30 0.10], 0, {@CorrectionConfigFunc,1});
            Obj.CheckBox2(2) = ViewConstructor.Checkbox (Obj.Panel2(1), 'Lo', [0.03 0.65 0.30 0.10], 0, {@CorrectionConfigFunc,2});
            Obj.CheckBox2(3) = ViewConstructor.Checkbox (Obj.Panel2(1), 'Push Rod Thermal Expansion', [0.03 0.45 0.850 0.10], 0, {@CorrectionConfigFunc,3});
            Obj.CheckBox2(4) = ViewConstructor.Checkbox (Obj.Panel2(1), 'Sample Thermal Expansion', [0.03 0.25 0.850 0.10], 0, {@CorrectionConfigFunc,4});
            Obj.CheckBox2(5) = ViewConstructor.Checkbox (Obj.Panel2(1), 'DlMethod', [0.03 0.05 0.850 0.10], 0, {@CorrectionConfigFunc,14});
            
            %Criação dos objetos do panel2
            Obj.Text2(1) = ViewConstructor.Text (Obj.Panel2(2), [0.15 0.35 0.2 0.35], 'To Value:');
            Obj.Text2(2) = ViewConstructor.Text (Obj.Panel2(2), [0.8 0.35 0.1 0.35], '[oC]');
            Obj.EditText2(1) = ViewConstructor.EditText(Obj.Panel2(2), [0.4 0.35 0.34 0.42],{@CorrectionConfigFunc,6});
            
            %Criação dos objetos do panel3
            Obj.rbh2(1) = ViewConstructor.RadioButton (Obj.Panel2(3), 'Extrapolation method', [0.25 0.83 0.7 0.15],{@CorrectionConfigFunc,7});
            Obj.rbh2(2) = ViewConstructor.RadioButton (Obj.Panel2(3), 'Translation method', [0.25 0.7 0.7 0.15],{@CorrectionConfigFunc,8});
            Obj.Text2(3) = ViewConstructor.Text (Obj.Panel2(3), [0.1 0.45 0.25 0.15], 'To Value:');
            Obj.Text2(4) = ViewConstructor.Text (Obj.Panel2(3), [0.75 0.45 0.25 0.15], '[oC]');
            Obj.Text2(5) = ViewConstructor.Text (Obj.Panel2(3), [0.1 0.25 0.25 0.15], 'Tf Value:');
            Obj.Text2(6) = ViewConstructor.Text (Obj.Panel2(3), [0.75 0.25 0.25 0.15], '[oC]');
            Obj.Text2(7) = ViewConstructor.Text (Obj.Panel2(3), [0.03 0.06 0.45 0.12], 'Reference curve:');          
            Obj.EditText2(2) = ViewConstructor.EditText(Obj.Panel2(3), [0.35 0.48 0.45 0.15],{@CorrectionConfigFunc,9});
            Obj.EditText2(3) = ViewConstructor.EditText(Obj.Panel2(3), [0.35 0.28 0.45 0.15],{@CorrectionConfigFunc,10});
            Obj.popup2(1) = ViewConstructor.Popupmenu (Obj.Panel2(3), [0.45 0.08 0.48 0.13] ,'Select curve',{@CorrectionConfigFunc,11});
            
            %Criação dos objetos do panel4
            Obj.Text2(8) = ViewConstructor.Text (Obj.Panel2(4), [0.05 0.35 0.1 0.35], 'File:');           
            Obj.Text2(10) = ViewConstructor.Text(Obj.Panel2(4), [0.18 0.35 0.53 0.35],'');
            set(Obj.Text2(10),'BackgroundColor',Obj.CorArray{16});
            Obj.Button2(1) = ViewConstructor.Button(Obj.Panel2(4),'Add',[0.75 0.31 0.22 0.48],{@CorrectionConfigFunc,12});
            
            %Criação dos objetos do panel5
            Obj.Text2(9) = ViewConstructor.Text (Obj.Panel2(5), [0.05 0.35 0.1 0.35], 'File:');
            Obj.Text2(11) = ViewConstructor.Text(Obj.Panel2(5), [0.18 0.35 0.53 0.35],'');
            set(Obj.Text2(11),'BackgroundColor',Obj.CorArray{16});
            Obj.Button2(2) = ViewConstructor.Button(Obj.Panel2(5),'Add',[0.75 0.31 0.22 0.48],{@CorrectionConfigFunc,13});
            
            %Configura aba
            set( Obj.AbaStrain, 'Sizes', [240 -1], 'Spacing', 5 ); 
            set( Obj.FundoEsqStrain, 'Sizes', [200 -1], 'Spacing', 5 ); 
            set( Obj.FundoDirStrain, 'Sizes', [70 175 70 -1], 'Spacing', 5 ); 
            Obj.EnablePanel21 ('off');
            Obj.EnablePanel22 ('off');
            Obj.EnablePanel23 ('off');
            Obj.EnablePanel24 ('off');
            Obj.EnablePanel25 ('off');
            set (Obj.ApplyBStrain, 'Enable', 'off');
            
                function CorrectionConfigFunc(hObject, ~, whichHandle)
                    switch whichHandle
                        case 1 % Checkbox To Is Selected
                            Obj.ProfileArray(Obj.Aprofile).Config.ToOk = get(hObject,'Value');
                            if Obj.ProfileArray(Obj.Aprofile).Config.ToOk == 1
                                Obj.EnablePanel22('on');
                            else
                                Obj.EnablePanel22('off');
                            end
                            
                        case 2 % Checkbox Lo Is Selected
                            Obj.ProfileArray(Obj.Aprofile).Config.LoOk = get(hObject,'Value');
                            if Obj.ProfileArray(Obj.Aprofile).Config.LoOk == 1
                                set(Obj.rbh2(1),'Enable','on','Value',0); 
                                set(Obj.rbh2(2),'Enable','on','Value',0);
                            else
                                Obj.EnablePanel23('off');
                            end
                            
                        case 3 % Checkbox PushRodExp Is Selected
                            Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk = get(hObject,'Value');
                            if Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk == 1
                                Obj.EnablePanel24('on');
                                if Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk==1
                                    set(Obj.CheckBox2(5),'Enable','on','Value',1);
                                    Obj.ProfileArray(Obj.Aprofile).Config.DlMethod=1;
                                end
                            else
                                Obj.EnablePanel24('off');
                                set(Obj.CheckBox2(5),'Enable','off','Value',0);
                                Obj.ProfileArray(Obj.Aprofile).Config.DlMethod=0;
                            end
                            
                        case 4 % Checkbox SampleExpan Is Selected
                            Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk = get(hObject,'Value');
                            if Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk == 1
                                Obj.EnablePanel25('on');
                                if Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk==1
                                    set(Obj.CheckBox2(5),'Enable','on','Value',1);
                                    Obj.ProfileArray(Obj.Aprofile).Config.DlMethod=1;
                                end
                            else
                                Obj.EnablePanel25('off');
                                set(Obj.CheckBox2(5),'Enable','off','Value',0);
                                Obj.ProfileArray(Obj.Aprofile).Config.DlMethod=0;
                            end
                            
                        case 5 %Apply button
                            Data= get (Obj.DataTable, 'Data');
                            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                                if isempty (Data{i,4}) ==1
                                    errordlg('Please enter with L0 values','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                            end
                            Obj.ProfileArray(Obj.Aprofile).ApplyShrinkage;
                            
                            %Atualização do gráfico
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(3)=1;
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(4)=1;
                            for i=5:40
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(i,1)=0;
                            end
                            Obj.RefreshListBox;
                            set (Obj.ListBox6, 'Value', 5);
                            aux1 = 5;
                            aux2 = get (Obj.ListBox6, 'String');
                            aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                            Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                            Obj.GraphData;
                            for i=2:3
                                set (Obj.Text4(i), 'Enable', 'on');
                            end
                            
                            %Permite o acesso a aba Calculations
                            Obj.ResetAbaDensities;
                            Obj.ResetAbaMSC;
                            Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag=1;
                            Obj.ProfileArray(Obj.Aprofile).DensityFlag=0;
                            Obj.ProfileArray(Obj.Aprofile).DensityDerFlag=0;
                            Obj.ProfileArray(Obj.Aprofile).ShrinkageDerFlag=0;
                            Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag=0;
                            Obj.ProfileArray(Obj.Aprofile).MSCFlag=0;
                            Obj.EnablePanel31 ('on');
                            set (Obj.CheckBox3(4),'Enable', 'on');
                            
                            
                            %Permite o acesso a aba de incertezas
                            Obj.ResetAbaUncertainty;
                            Obj.EnablePanel41 ('on');
                            for i=1:2
                                set(Obj.rbh4(i), 'Enable', 'on');
                            end
                            set (Obj.rbh4(1), 'Value', 1);
                            Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod=0;
                            Obj.RefreshAbaUncertainty;
                            
                            %Atualiza valores do L0 na tabela de dados
                            Obj.RefreshTable;
                            
                            %Reseta as abas posteriores
                            Obj.ResetAbaArrhenius;
                            Obj.ProfileArray(Obj.Aprofile).MSCFlag=0;
                            Obj.ResetAbaAnalysis;
                            
            
                        case 6 %T0 Value
                            Obj.ProfileArray(Obj.Aprofile).Config.ToValue = str2double(get(hObject,'String'));
                            
                        case 7 %Radio Button L0 Method - Extrapolation
                            if get(hObject,'Value') == 0
                                set(Obj.rbh2(1),'Value',1);
                            end
                            set(Obj.rbh2(2),'Value',0);
                            Obj.ProfileArray(Obj.Aprofile).Config.LoMethod = 0; % 0 = Exploration Method
                            Obj.EnablePanel23 ('on');
                            set(Obj.popup2(1),'Enable','off');
                              
                        case 8 %Radio Button L0 Method - Translation
                            if get(hObject,'Value') == 0
                                set(Obj.rbh2(2),'Value',1);
                            end
                            set(Obj.rbh2(1),'Value',0);
                            Obj.ProfileArray(Obj.Aprofile).Config.LoMethod = 1; % 1 = Translation Method
                            Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo=1;
                            set(Obj.popup2(1),'Value',1);
                            Obj.EnablePanel23 ('on');
                            Obj.RefreshStrainPopup;
                            
                        case 9 %T0L0Value - EditText
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).Config.ToLoValue = str2double(get(hObject,'String'));
                            
                            
                        case 10 %TfL0Value
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).Config.TfLoValue = str2double(get(hObject,'String'));
                            
                            
                        case 11 %Popup
                            curvesArray = get(hObject,'String');
                            curveSelected=curvesArray(get(hObject,'Value'));
                            Data=get(Obj.DataTable,'Data');
                            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                                if (strcmp(curveSelected,Data(i,2)))==1
                                    indice=i;
                                    break;
                                end
                            end
                            Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo = indice;
                            
                        case 12 %Botão Add do PushRod Expansion
                            [name,path] = uigetfile('*.dat','Import File');    %Nome do arquivo de dados
                            if name ~= 0
                                [~,~,ext]=fileparts(name);                  %Extensão do arquivo de dados
                                file=load([path name]);                     %Matriz do arquivo da matriz de dados            
                                sizeFile = size(file);                      %Tamanho da matriz de dados
                                if (strcmp (ext,'.dat')+ strcmp (ext,'.txt'))==0 %Verificar a extensão do arquivo
                                    errordlg('Bad input data format! Please import a .dat or . txt file.','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                elseif sizeFile(1,2) ~= 3 %Verificar se a matriz possui 3 colunas
                                    errordlg('File with invalid number of colums. Please import a file with 3 colums.      (t T DL)','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                                Obj.ProfileArray(Obj.Aprofile).Config.PushRodFile = file;
                                Obj.ProfileArray(Obj.Aprofile).Config.PushRodFileName = name;
                                set(Obj.Text2(10),'String', name,'HorizontalAlignment','left'); % Atualização dos valores apresentados na tela
                            end
                            
                        case 13 %Botão Add do Sample Thermal Expansion
                            [name,path] = uigetfile('*.dat','Import File');    %Nome do arquivo de dados
                            if name ~= 0
                                [~,~,ext]=fileparts(name);
                                file=load([path name]);                            %Matriz do arquivo da matriz de dados            
                                sizeFile = size(file);                      %Tamanho da matriz de dados
                                if (strcmp (ext,'.dat')+ strcmp (ext,'.txt'))==0 %Verificar a extensão do arquivo
                                    errordlg('Bad input data format! Please import a .dat or . txt file.','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                elseif sizeFile(1,2) ~= 3 %Verificar se a matriz possui 2 colunas
                                    errordlg('File with invalid number of colums. Please import a file with 3 colums.      (t T DL)','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                                Obj.ProfileArray(Obj.Aprofile).Config.ExpThermFile = file;
                                Obj.ProfileArray(Obj.Aprofile).Config.ExpThermFileName = name;
                                set(Obj.Text2(11),'String', name,'HorizontalAlignment','left'); % Atualização dos valores apresentados na tela
                            end
                            
                        case 14 % Checkbox To Is Selected
                            Obj.ProfileArray(Obj.Aprofile).Config.DlMethod = get(hObject,'Value');
                    end
                end

        
        end
        
        function Obj = EnablePanel21 (Obj, Enable)
           
            for i=1:5
                set (Obj.CheckBox2(i),'Enable',Enable);
            end
        end
        
        function Obj = EnablePanel22 (Obj, Enable)
           
            set (Obj.Text2(1),'Enable',Enable);
            set (Obj.Text2(2),'Enable',Enable);
            set (Obj.EditText2(1),'Enable',Enable);
            
        end
        
        function Obj = EnablePanel23 (Obj, Enable)
           
            for i=3:7
                set (Obj.Text2(i),'Enable',Enable);
            end
            set (Obj.rbh2(1),'Enable',Enable);
            set (Obj.rbh2(2),'Enable',Enable);
            set (Obj.popup2(1),'Enable',Enable);
            set (Obj.EditText2(2),'Enable',Enable);
            set (Obj.EditText2(3),'Enable',Enable);
            
        end
        
        function Obj = EnablePanel24 (Obj, Enable)
           
            set (Obj.Button2(1),'Enable',Enable);
            set (Obj.Text2(8),'Enable',Enable);
            set (Obj.Text2(10),'Enable',Enable);
            
        end
        
        function Obj = EnablePanel25 (Obj, Enable)
           
            set (Obj.Button2(2),'Enable',Enable);
            set (Obj.Text2(9),'Enable',Enable);
            set (Obj.Text2(11),'Enable',Enable);
            
        end
        
        function Obj = RefreshStrainPopup (Obj)
            
            %Atualiza caso não exista profile
            if Obj.nprofile==0
                Obj.ProfileArray(Obj.Aprofile).CurvesNameList='Select Curve';
                set(Obj.popup2(1), 'String', Obj.ProfileArray(Obj.Aprofile).CurvesNameList,'Value',1,'Enable','off');
                return;
            end
            
            %Atualiza para quando a última curva é deletada
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                Obj.ProfileArray(Obj.Aprofile).CurvesNameList='Select Curve';
                set(Obj.popup2(1), 'String', Obj.ProfileArray(Obj.Aprofile).CurvesNameList,'Value',1,'Enable','off');
                return;
            end
            
            %Atualiza quando alguma operação é feita na interface
            if Obj.ProfileArray(Obj.Aprofile).Config.LoMethod==1
                %Atualiza a variável que contém o nome de todas as curvas do profile
                Obj.ProfileArray(Obj.Aprofile).CurvesNameList=cell(Obj.ProfileArray(Obj.Aprofile).nCurves,1);
                for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                    Obj.ProfileArray(Obj.Aprofile).CurvesNameList{i,1}=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Name;
                end
                set(Obj.popup2(1),'String', Obj.ProfileArray(Obj.Aprofile).CurvesNameList,'Value',Obj.ProfileArray(Obj.Aprofile).Config.ReferenceLo);
            else
                Obj.ProfileArray(Obj.Aprofile).CurvesNameList='Select Curve';
                set(Obj.popup2(1), 'String', Obj.ProfileArray(Obj.Aprofile).CurvesNameList,'Value',1,'Enable','off');
            end
        end
        
        function Obj = RefreshPanel21 (Obj)
            
            if Obj.nprofile > 0 
                if Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag==1 
                    Obj.EnablePanel21 ('on');
                    set (Obj.CheckBox2(1),'Value', Obj.ProfileArray(Obj.Aprofile).Config.ToOk);
                    set (Obj.CheckBox2(2),'Value', Obj.ProfileArray(Obj.Aprofile).Config.LoOk);
                    set (Obj.CheckBox2(3),'Value', Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk);
                    set (Obj.CheckBox2(4),'Value', Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk);
                    if Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk == 1
                        if Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk==1
                            set(Obj.CheckBox2(5),'Enable','on','Value',Obj.ProfileArray(Obj.Aprofile).Config.DlMethod);
                        else
                            set(Obj.CheckBox2(5),'Enable','off','Value',0);
                        end
                    else
                        set(Obj.CheckBox2(5),'Enable','off','Value',0);
                    end
                elseif  Obj.ProfileArray(Obj.Aprofile).nCurves>0
                    Obj.EnablePanel21 ('on');
                    set (Obj.CheckBox2(1),'Value', 0);
                    set (Obj.CheckBox2(2),'Value', 0);
                    set (Obj.CheckBox2(3),'Value', 0);
                    set (Obj.CheckBox2(4),'Value', 0);
                    Obj.ProfileArray(Obj.Aprofile).Config.ToOk=0;
                    Obj.ProfileArray(Obj.Aprofile).Config.LoOk=0;
                    Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk=0;
                    Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk=0;
                    if Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk == 1
                        if Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk==1
                            set(Obj.CheckBox2(5),'Enable','on','Value',Obj.ProfileArray(Obj.Aprofile).Config.DlMethod);
                        else
                            set(Obj.CheckBox2(5),'Enable','off','Value',0);
                        end
                    else
                        set(Obj.CheckBox2(5),'Enable','off','Value',0);
                    end
                else
                    
                    Obj.EnablePanel21 ('off');
                    set (Obj.CheckBox2(1),'Value', 0);
                    set (Obj.CheckBox2(2),'Value', 0);
                    set (Obj.CheckBox2(3),'Value', 0);
                    set (Obj.CheckBox2(4),'Value', 0);
                    set(Obj.CheckBox2(5),'Value',0);
                end
            else
                Obj.EnablePanel21 ('off');
                set (Obj.CheckBox2(1),'Value', 0);
                set (Obj.CheckBox2(2),'Value', 0);
                set (Obj.CheckBox2(3),'Value', 0);
                set (Obj.CheckBox2(4),'Value', 0);
                set(Obj.CheckBox2(5),'Value',0);
            end
        end
            
        function Obj = RefreshPanel22 (Obj)
        
            if Obj.nprofile==0
                set(Obj.EditText2(1),'String',[]);
                Obj.EnablePanel22('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0 || Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag==0
                set(Obj.EditText2(1),'String',[]);
                Obj.EnablePanel22('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.ToOk ==1 
                Obj.EnablePanel22 ('on');
                set(Obj.EditText2(1),'String',Obj.ProfileArray(Obj.Aprofile).Config.ToValue);
            else
                set(Obj.EditText2(1),'String',[]);
                Obj.EnablePanel22('off');
            end
        end
        
        function Obj = RefreshPanel23 (Obj)
        
            if Obj.nprofile==0
                set(Obj.rbh2(1),'Value',0);
                set(Obj.rbh2(2),'Value',0);
                set(Obj.EditText2(2),'String',[],'Enable', 'off');
                set(Obj.EditText2(3),'String',[],'Enable','off');
                Obj.RefreshStrainPopup;
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0 || Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag==0
                set(Obj.rbh2(1),'Value',0);
                set(Obj.rbh2(2),'Value',0);
                set(Obj.EditText2(2),'String',[],'Enable', 'off');
                set(Obj.EditText2(3),'String',[],'Enable','off');
                Obj.RefreshStrainPopup;
                return;
            end
            
            
            if Obj.ProfileArray(Obj.Aprofile).Config.LoOk ==1
                Obj.EnablePanel23 ('on');
                if Obj.ProfileArray(Obj.Aprofile).Config.LoMethod ==0
                    set(Obj.rbh2(1),'Value',1);
                    set(Obj.rbh2(2),'Value',0);
                    set(Obj.EditText2(2),'String',Obj.ProfileArray(Obj.Aprofile).Config.ToLoValue);
                    set(Obj.EditText2(3),'String',Obj.ProfileArray(Obj.Aprofile).Config.TfLoValue);
                elseif Obj.ProfileArray(Obj.Aprofile).Config.LoMethod ==1
                    set(Obj.rbh2(1),'Value',0);
                    set(Obj.rbh2(2),'Value',1);
                    set(Obj.EditText2(2),'String',Obj.ProfileArray(Obj.Aprofile).Config.ToLoValue);
                    set(Obj.EditText2(3),'String',Obj.ProfileArray(Obj.Aprofile).Config.TfLoValue);
                else
                    set(Obj.rbh2(1),'Value',0);
                    set(Obj.rbh2(2),'Value',0);
                    set(Obj.EditText2(2),'String',[],'Enable', 'off');
                    set(Obj.EditText2(3),'String',[],'Enable','off');
                end
            else
                Obj.EnablePanel23 ('off');
                set(Obj.rbh2(1),'Value',0);
                set(Obj.rbh2(2),'Value',0);
                set(Obj.EditText2(2),'String',[]);
                set(Obj.EditText2(3),'String',[]);
            end
            Obj.RefreshStrainPopup;
            
        
        end
        
        function Obj = RefreshPanel24 (Obj)
        
            if Obj.nprofile==0
                set(Obj.Text2(10),'String',[]);
                Obj.EnablePanel24('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0 || Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag==0
                set(Obj.Text2(10),'String',[]);
                Obj.EnablePanel24('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.PushRodOk ==1
                Obj.EnablePanel24 ('on');
                set(Obj.Text2(10),'String',Obj.ProfileArray(Obj.Aprofile).Config.PushRodFileName);
            else
                if isempty (Obj.ProfileArray(Obj.Aprofile).Config.PushRodFileName)~=1
                    set(Obj.Text2(10),'String',Obj.ProfileArray(Obj.Aprofile).Config.PushRodFileName);
                    Obj.EnablePanel24('off');
                else
                    set(Obj.Text2(10),'String',[]);
                    Obj.EnablePanel24('off');
                end
            end
        end
        
        function Obj = RefreshPanel25 (Obj)
        
            if Obj.nprofile==0
                set(Obj.Text2(11),'String',[]);
                Obj.EnablePanel25('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0 || Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag==0
                set(Obj.Text2(11),'String',[]);
                Obj.EnablePanel25('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.ExpThermOk ==1
                Obj.EnablePanel25 ('on');
                set(Obj.Text2(11),'String',Obj.ProfileArray(Obj.Aprofile).Config.ExpThermFileName);
            else
                if isempty (Obj.ProfileArray(Obj.Aprofile).Config.ExpThermFileName)~=1
                    set(Obj.Text2(11),'String',Obj.ProfileArray(Obj.Aprofile).Config.ExpThermFileName);
                    Obj.EnablePanel25('off');
                else
                set(Obj.Text2(11),'String',[]);
                Obj.EnablePanel25('off');
                end
            end
        end
        
        function Obj = RefreshApplyBStrain (Obj)
            
            if isempty(Obj.Aprofile)==1
                set(Obj.ApplyBStrain, 'Enable', 'off');
            else
                if Obj.ProfileArray(Obj.Aprofile).nCurves >0
                    set(Obj.ApplyBStrain, 'Enable', 'on');
                else
                    set(Obj.ApplyBStrain, 'Enable', 'off');
                end
            end
        end
        
        function Obj = RefreshStrainAba (Obj)
           
            Obj.RefreshPanel21;
            Obj.RefreshPanel22;
            Obj.RefreshPanel23;
            Obj.RefreshPanel24;
            Obj.RefreshPanel25;
            Obj.RefreshApplyBStrain;
                
                   
        end
        
        function Obj = ResetStrainAba (Obj)
           
            Obj.EnablePanel21 ('off');
            Obj.EnablePanel22 ('off');
            Obj.EnablePanel23 ('off');
            Obj.EnablePanel24 ('off');
            Obj.EnablePanel25 ('off');
            Obj.RefreshStrainAba;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%Funções que criam os componentes da aba Calculus%%%%%%%%%
        
        function Obj = AbaCalculusComp (Obj)
        
            %Fundos
            Obj.FundoEsqCalc = uiextras.VBox('Parent', Obj.AbaCalculus);
            Obj.FundoDirCalc = uiextras.VBox('Parent', Obj.AbaCalculus);
            
            %Panels Esquerdo
            Obj.Panel3(1) = ViewConstructor.Panel(Obj.FundoEsqCalc,'Execute');
            Obj.Panel3(2) = ViewConstructor.Panel(Obj.FundoEsqCalc,'Derivates');
            Obj.Panel3(3) = ViewConstructor.Fundo(Obj.FundoEsqCalc);
            
            %Panels Direito
            Obj.Panel3(4) = ViewConstructor.Panel(Obj.FundoDirCalc,'Densities Options');
            Obj.Panel3(5) = ViewConstructor.Panel(Obj.FundoDirCalc,'Smoothing');
            
            %Criação de Objetos do Panel1
            Obj.CheckBox3(1) = ViewConstructor.Checkbox (Obj.Panel3(1), 'Instantaneous Shrinkage', [0.09 0.70 0.80 0.15], 0, {@CalcSelectFunc,1});
            Obj.CheckBox3(2) = ViewConstructor.Checkbox (Obj.Panel3(1), 'Densities', [0.09 0.45 0.60 0.15], 0, {@CalcSelectFunc,2});
            Obj.CheckBox3(3) = ViewConstructor.Checkbox (Obj.Panel3(1), 'Densification', [0.09 0.2 0.850 0.15], 0, {@CalcSelectFunc,3});
            
            %Criação de Objetos do Panel2
            Obj.CheckBox3(4) = ViewConstructor.Checkbox (Obj.Panel3(2), 'Shrinkage', [0.09 0.75 0.850 0.15], 0, {@CalcSelectFunc,4});
            Obj.CheckBox3(5) = ViewConstructor.Checkbox (Obj.Panel3(2), 'Instantaneous Shrinkage', [0.09 0.55 0.80 0.15], 0, {@CalcSelectFunc,5});
            Obj.CheckBox3(6) = ViewConstructor.Checkbox (Obj.Panel3(2), 'Densities', [0.09 0.35 0.60 0.15], 0, {@CalcSelectFunc,6});
            Obj.CheckBox3(7) = ViewConstructor.Checkbox (Obj.Panel3(2), 'Densification', [0.09 0.15 0.850 0.15], 0, {@CalcSelectFunc,7});

            %Criação de Objetos do Panel3
            Obj.ApplyButton2 = ViewConstructor.Button(Obj.Panel3(3),'Apply',[0.35 0.4 0.3 0.30], {@CalcSelectFunc,17});

            %Criação de Objetos do Panel4
            Obj.CheckBox3(8) = ViewConstructor.Checkbox (Obj.Panel3(4), 'Mass lost correction', [0.09 0.46 0.850 0.15], 0, {@CalcSelectFunc,8});
            Obj.CheckBox3(9) = ViewConstructor.Checkbox (Obj.Panel3(4), 'Done!', [0.6 0.06 0.25 0.15], 0, {@CalcSelectFunc,18});
            Obj.CheckBox3(10) = ViewConstructor.Checkbox (Obj.Panel3(4), 'Density Data', [0.055 0.625 0.4 0.15], 0, {@CalcSelectFunc,20});
            Obj.Text3(1) = ViewConstructor.Text (Obj.Panel3(4), [0.02 0.82 0.4 0.15], 'Green Density');
            Obj.Text3(2) = ViewConstructor.Text (Obj.Panel3(4), [0.02 0.75 0.4 0.15], 'Uncertainty:');
            Obj.Text3(3) = ViewConstructor.Text (Obj.Panel3(4), [0.78 0.75 0.2 0.15], '[g/cm3]');
            Obj.EditText3(2) = ViewConstructor.EditText(Obj.Panel3(4), [0.45 0.84 0.3 0.10], {@CalcSelectFunc,10});
            Obj.rbh3(1) = ViewConstructor.RadioButton (Obj.Panel3(4), 'Single file', [0.35 0.34 0.4 0.15], {@CalcSelectFunc,11});
            Obj.rbh3(2) = ViewConstructor.RadioButton (Obj.Panel3(4), 'Multiple file', [0.35 0.23 0.4 0.15], {@CalcSelectFunc,12});
            Obj.Button3(1) = ViewConstructor.Button(Obj.Panel3(4),'Add',[0.25 0.06 0.25 0.15],{@CalcSelectFunc,13});
            Obj.Button3(2) = ViewConstructor.Button(Obj.Panel3(4),'Add',[0.79 0.64 0.18 0.11],{@CalcSelectFunc,19});
            Obj.Text3(4) = ViewConstructor.Text(Obj.Panel3(4), [0.45 0.65 0.3 0.1],'');
            set(Obj.Text3(4),'BackgroundColor',Obj.CorArray{16});
            
            %Criação de Objetos do Panel5
            Obj.EditText3(3) = ViewConstructor.EditText(Obj.Panel3(5), [0.65 0.2 0.3 0.20], {@CalcSelectFunc,14});
            Obj.Popup3(1) = ViewConstructor.Popupmenu (Obj.Panel3(5), [0.05 0.55 0.9 0.15], {'All curves'}, {@CalcSelectFunc,15});
            Obj.Slider3(1) = ViewConstructor.Slider (Obj.Panel3(5), 0,100, 0, [0.05 0.2 0.55 0.15],  {@CalcSelectFunc,16});
            
            %Configura a aba
            set( Obj.AbaCalculus, 'Sizes', [245 -1], 'Spacing', 5 ); 
            set( Obj.FundoEsqCalc, 'Sizes', [120 150 -1], 'Spacing', 5 ); 
            set( Obj.FundoDirCalc, 'Sizes', [250 -1], 'Spacing', 5 ); 
            set(Obj.CheckBox3(9), 'Enable', 'off');
            Obj.EnablePanel31 ('off');
            Obj.EnablePanel32 ('off');
            Obj.EnablePanel33 ('off');
            Obj.EnablePanel34 ('off');
            Obj.EnablePanel35 ('off');
            set( Obj.rbh3(1),'Enable', 'off');
            set( Obj.rbh3(2),'Enable', 'off');
            set( Obj.Button3(1),'Enable', 'off');
            
            function CalcSelectFunc(hObject,~, whichHandle)
                switch whichHandle
                    case 1 %CheckBox do Instant Shrinkage
                        Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk = get(hObject,'Value');
                        if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk == 1
                            set(Obj.CheckBox3(5),'Enable','on');
                            Obj.EnablePanel33 ('on');
                        else
                            set(Obj.CheckBox3(5),'Enable','off','Value',0);
                            Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageDerivateOk =0;
                            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 0 && Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 0 && Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk == 0
                                Obj.EnablePanel33 ('off');
                            end
                        end
                    case 2 %CheckBox do Densities
                        Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk = get(hObject,'Value');
                        if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1
                            set(Obj.CheckBox3(3),'Enable','on');
                            set(Obj.CheckBox3(6),'Enable','on');
                            Obj.EnablePanel33('on');
                            Obj.EnablePanel34('on');
                            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 1
                                set(Obj.CheckBox3(7),'Enable','on'); 
                            end
                        else
                            set(Obj.CheckBox3(3),'Enable','off','Value',0);
                            set(Obj.CheckBox3(6),'Enable','off','Value',0);
                            set(Obj.CheckBox3(7),'Enable','off','Value',0);
                            Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk = get(hObject,'Value');
                            Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk = 0;
                            Obj.ProfileArray(Obj.Aprofile).Config.DensitiesDerivateOk =0;
                            Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk =0;
                            Obj.EnablePanel34('off');
                            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 0 && Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 0 && Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk == 0
                                Obj.EnablePanel33 ('off');
                            end
                            
                        end
                    case 3 %CheckBox do Densification
                        Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk = get(hObject,'Value');
                        if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 1
                            set(Obj.CheckBox3(7),'Enable','on');
                        else
                            set(Obj.CheckBox3(7),'Enable','off','Value',0);
                            Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk =0;
                        end
                    case 4 %CheckBox da derivada do Shrinkage 
                        Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk = get(hObject,'Value');
                        if Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk == 1
                            Obj.EnablePanel33 ('on');
                        else
                            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 0 && Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 0 && Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk == 0
                                Obj.EnablePanel33 ('off');
                            end
                        end
                    case 5 %CheckBox da derivada do Instant Shrinkage
                        Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageDerivateOk = get(hObject,'Value');
                    case 6 %CheckBox da derivada do Densities
                        Obj.ProfileArray(Obj.Aprofile).Config.DensitiesDerivateOk = get(hObject,'Value');
                    case 7 %CheckBox da derivada do Densification
                        Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk = get(hObject,'Value');   
                    case 8 %CheckBox do Mass Correction
                        Obj.ProfileArray(Obj.Aprofile).Config.MassOk = get(hObject,'Value');
                            if Obj.ProfileArray(Obj.Aprofile).Config.MassOk == 1
                                set(Obj.rbh3(1),'Enable','on');
                                set(Obj.rbh3(2),'Enable','on');
                                aux1 = get(Obj.rbh3(1),'Value');
                                aux2 = get(Obj.rbh3(2),'Value');
                                if aux1 ==1 || aux2 ==1
                                    set (Obj.Button3(1),'Enable','on');
                                end
                                if isempty (Obj.ProfileArray(Obj.Aprofile).ArrayData(1).Densities.MassCorFile) ==1
                                    set (Obj.Button3(1),'String','Add');
                                    set(Obj.CheckBox3(9),'Enable','off', 'Value', 0);
                                else
                                    set (Obj.Button3(1),'String','Replace');
                                    set(Obj.CheckBox3(9),'Enable','on', 'Value', 1);
                                end
                            else
                                set(Obj.rbh3(1),'Enable','off');
                                set(Obj.rbh3(2),'Enable','off');
                                set (Obj.Button3(1),'Enable','off');
                                set(Obj.CheckBox3(9),'Enable','off');
                            end
                            
                    case 10 %Edit Text da incerteza do Green Density
                        str=get(hObject,'String');
                        if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                        end
                        Obj.ProfileArray(Obj.Aprofile).Config.DensoUncertainty = str2double(get(hObject,'String'));
                        
                    case 11 %Primeiro Radio Button
                        if get(hObject,'Value') == 1 
                            set(Obj.rbh3(2),'Value',0)
                            Obj.ProfileArray(Obj.Aprofile).Config.MassMethod = 0; % 0 = Single File
                            set (Obj.Button3(1),'Enable','on', 'String', 'Add');
                            set (Obj.CheckBox3(9), 'Value', 0, 'Enable', 'on');
                            Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone=0;
                        end  
                    case 12 %Segundo Radio Button
                        if get(hObject,'Value') == 1
                            set(Obj.rbh3(1),'Value',0)
                            Obj.ProfileArray(Obj.Aprofile).Config.MassMethod = 1; % 1 = Multiple File
                            set (Obj.Button3(1),'Enable','on','String', 'Add');
                            set (Obj.CheckBox3(9), 'Value', 0, 'Enable', 'on');
                            Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone=0;
                        end
                        
                    case 13
                        if Obj.ProfileArray(Obj.Aprofile).Config.MassMethod == 0
                           [name,path] = uigetfile('*.dat','Correction File');            %Nome do arquivo de dados
                    
                            %Método que valida o formato dos dados
                            [valida,file] = Obj.ValidaDados (name, path, hObject);
                            if valida==0
                                errordlg('File not uploaded','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.MassCorFile = file;
                            end
                        else
                            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                                string2=strcat('Correction File for _ ',' ',Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Name);
                                [name,path] = uigetfile('*.dat',string2);            %Nome do arquivo de dados
                    
                                %Método que valida o formato dos dados
                                [valida,file] = Obj.ValidaDados (name, path, hObject);
                                if valida==0
                                    errordlg('Files not uploaded','Warning','modal');
                                    uicontrol(hObject);    
                                    return;
                                end
                                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.MassCorFile = file;
                            end
                        end
                        set (Obj.Button3(1), 'String', 'Replace');
                        set (Obj.CheckBox3(9), 'Value', 1, 'Enable', 'on');
                        Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone=1;
                        
                    case 14
                        
                        aux = str2double (get (Obj.EditText3(3), 'String'));
                        aux2 = get (Obj.Slider3(1), 'Max');
                        aux3 = round(get (Obj.Slider3(1), 'Value'));
                        if aux > aux2
                            set (Obj.EditText3(3), 'String', num2str(aux3));
                            errordlg('Aperture exceeds data size','Warning','modal');
                            uicontrol(hObject);
                            return;
                        else
                            set (Obj.Slider3(1), 'Value', aux);
                            Obj.MakeSmoothing;
                            j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                        for i=1:18
                            aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                            if aux ==1
                                Option =i;
                                break;
                            end
                            if i==18
                                Option=[];
                            end
                        end
                            Obj.SmoothGraph (Option);
                        end
                            
                        
                    case 15
                        
                        j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                        for i=1:18
                            aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                            if aux ==1
                                Option =i;
                                break;
                            end
                            if i==18
                                Option=[];
                            end
                        end
                        Obj.ProfileArray(Obj.Aprofile).Popup3Choice=get(hObject, 'Value');
                        Obj.SmoothGraph (Option);
                        
                    case 16

                        aperture = round(get (Obj.Slider3(1), 'Value'));
                        set (Obj.EditText3(3), 'String', num2str(aperture));
                        Obj.MakeSmoothing;
                        j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                        for i=1:18
                            aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                            if aux ==1
                                Option =i;
                                break;
                            end
                            if i==18
                                Option=[];
                            end
                        end
                        Obj.SmoothGraph (Option);
                        
                    case 17
                        
                        if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1
                            Data= get (Obj.DataTable, 'Data');
                            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                                if isempty (Data{i,3}) ==1
                                    errordlg('Please enter with green densities values','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                            end
                            
                        end

                        if Obj.ProfileArray(Obj.Aprofile).Config.MassOk == 1
                            if isempty (Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone)==1
                                errordlg('Please add mass correction file(s)','Warning','modal');
                                uicontrol(hObject);    
                                return;
                            end
                            if Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone ~=1  
                               errordlg('Please add mass correction file(s)','Warning','modal');
                               uicontrol(hObject);    
                               return;
                            end 
                        end
                        Obj.ProfileArray(Obj.Aprofile).ApplyCalculations;
                        Obj.InitializeSmooth;
                        
                        %Atualiza o gráfico
                        Obj.CheckFlags;
                        Obj.RefreshListBox;
                        set (Obj.ListBox6, 'Value', 7);
                        aux1 = 7;
                        aux2 = get (Obj.ListBox6, 'String');
                        aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                        Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                        Obj.GraphData;
                        
                        %Atualiza aba Arrhenius
                        Obj.ResetAbaUncertainty;
                        Obj.EnablePanel41 ('on');
                        for i=1:2
                            set(Obj.rbh4(i), 'Enable', 'on');
                        end
                        set (Obj.rbh4(1), 'Value', 1);
                        Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod=0;
                        Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag=0;
                        Obj.RefreshAbaUncertainty;
                        Obj.ResetAbaArrhenius;
                        Obj.EnableAbaArr;
                        
                        
                        %Atualiza as demais abas
                        Obj.EnableAbaMSC;
                        Obj.RefreshValues ('off');
                        Obj.ProfileArray(Obj.Aprofile).MSCFlag=0;
                        Obj.ResetAbaAnalysis;
                            

                        
                    case 18
                        set (Obj.CheckBox3(9),'Value',1);
                        
                    case 19
                        [name,path] = uigetfile('*.dat','Import File');    %Nome do arquivo de dados
                            if name ~= 0
                                [~,~,ext]=fileparts(name);                  %Extensão do arquivo de dados
                                file=load([path name]);                     %Matriz do arquivo da matriz de dados            
                                sizeFile = size(file);                      %Tamanho da matriz de dados
                                if (strcmp (ext,'.dat')+ strcmp (ext,'.txt'))==0 %Verificar a extensão do arquivo
                                    errordlg('Bad input data format! Please import a .dat or . txt file.','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                elseif sizeFile(1,2) ~= 2 %Verificar se a matriz possui 2 colunas
                                    errordlg('File with invalid number of colums. Please import a file with 2 colums.      ( T Density)','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                                Obj.ProfileArray(Obj.Aprofile).Config.DensityDataFile = file;
                                Obj.ProfileArray(Obj.Aprofile).Config.DensityDataName = name;
                                set(Obj.Text3(4),'String', name,'HorizontalAlignment','left'); % Atualização dos valores apresentados na tela
                            end
                        
                    case 20
                        Obj.ProfileArray(Obj.Aprofile).Config.DensityDataOk = get(hObject,'Value');
                        if Obj.ProfileArray(Obj.Aprofile).Config.DensityDataOk == 1
                            set (Obj.Text3(4), 'Enable', 'on');
                            set (Obj.Button3(2), 'Enable', 'on');
                        else
                            set (Obj.Text3(4), 'Enable', 'off');
                            set (Obj.Button3(2), 'Enable', 'off');
                        end
                        aux2 = get (Obj.ListBox6, 'Value');
                        if aux2 ==7
                            Obj.GraphData;
                        end
                            

                end
            end
        end
        
        function Obj = MakeSmoothing (Obj)
            
            j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
            for i=1:18
                aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                if aux ==1
                    Option =i;
                    break;
                end
                if i==18
                    Option=[];
                end
            end
            Choice = get(Obj.Popup3(1), 'Value');
            Choice=Choice-1;
            aperture = get (Obj.Slider3(1), 'Value');
            aperture = round (aperture);
            
            
            switch Option
                case 11
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothWindowt = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.Smoothingt;
                case 12
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothWindowT = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothingT;
                case 13
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothWindowt = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.Smoothingt;
                case 14
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothWindowT = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothingT;
                case 15
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothWindowt = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.Smoothingt;
                case 16
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothWindowT = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothingT;
                case 17
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothWindowt = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.Smoothingt;
                case 18
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothWindowT = aperture;
                    Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothingT;
                    
            end
            
            
        end
        
        function Obj = CheckFlags (Obj)
           
            if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(5)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(6)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(5)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(6)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(7)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(8)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(7)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(8)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(9)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(10)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(9)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(10)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(11)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(12)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(11)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(12)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(13)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(14)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(13)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(14)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(15)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(16)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(15)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(16)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(17)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(18)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(17)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(18)=0;
            end
            for i=19:40
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(i,1)=0;
            end
        end
        
        function Obj = EnablePanel31 (Obj, Enable)
           
            for i=1:3
                set (Obj.CheckBox3(i),'Enable',Enable);
            end
            if Obj.nprofile > 0
                if Obj.ProfileArray(Obj.Aprofile).DensityFlag==0
                    set (Obj.CheckBox3(3),'Enable','off');
                end
            end
        end
        
        function Obj = EnablePanel32 (Obj, Enable)
           
            for i=4:7
                set (Obj.CheckBox3(i),'Enable',Enable);
            end
                        
        end
        
        function Obj = EnablePanel33 (Obj, Enable)
           
            set (Obj.ApplyButton2,'Enable',Enable);
            
        end
        
        function Obj = EnablePanel34 (Obj, Enable)
           
            for i=1:3
                set (Obj.Text3(i),'Enable',Enable);
            end
            set (Obj.CheckBox3(8),'Enable',Enable);
            set (Obj.CheckBox3(10),'Enable',Enable);
            set (Obj.EditText3(2),'Enable',Enable);
            
            aux=get(Obj.CheckBox3(8),'Value');
            aux2= get(Obj.CheckBox3(2), 'Value');
            if aux==1 &&  aux2==1
                if get(Obj.rbh3(1),'Value')==1 || get(Obj.rbh3(2),'Value')==1
                    set (Obj.Button3(1), 'Enable', 'on', 'String', 'Add');
                    set (Obj.CheckBox3(9), 'Enable', 'on');
                else
                    set (Obj.Button3(1), 'Enable', 'off', 'String', 'Add');
                    set (Obj.CheckBox3(9), 'Enable', 'off');
                end
                set (Obj.rbh3(1), 'Enable', 'on');
                set (Obj.rbh3(2), 'Enable', 'on');
                
            else
                set (Obj.Button3(1), 'Enable', 'off', 'String', 'Add');
                set (Obj.rbh3(1), 'Enable', 'off');
                set (Obj.rbh3(2), 'Enable', 'off');
                set (Obj.CheckBox3(9), 'Enable', 'off');
            end
            if Obj.nprofile >0 
                if Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone ==1
                    set (Obj.Button3(1), 'String', 'Replace');
                    set (Obj.CheckBox3(9), 'Value', 1);
                    
                else
                    set (Obj.CheckBox3(9), 'Value', 0);
                    set (Obj.Button3(1), 'String', 'Add');
                end
            end
            
            aux=get(Obj.CheckBox3(10),'Value');
            if aux==1 && strcmp(Enable,'on')==1
                set (Obj.Text3(4), 'Enable', 'on');
                set (Obj.Button3(2), 'Enable', 'on');
            else
                set (Obj.Text3(4), 'Enable', 'off');
                set (Obj.Button3(2), 'Enable', 'off');
            end
        end
        
        function Obj = EnablePanel35 (Obj, Enable)
           
            set (Obj.Popup3(1),'Enable',Enable);
            
            if strcmp (Enable, 'on') ==1
                Data=get(Obj.DataTable,'Data');
                aux = [ 'All curves'; Data(:,2)];
                set (Obj.Popup3(1), 'String',aux, 'Value', 1);
            end
            
        end
        
        function Obj = RefreshPanel31 (Obj)
        
            if Obj.nprofile==0
                Obj.EnablePanel31 ('off');
                set(Obj.CheckBox3(2),'Enable','off','Value',0);
                set(Obj.CheckBox3(3),'Enable','off','Value',0);
                set(Obj.CheckBox3(6),'Enable','off','Value',0);
                set(Obj.CheckBox3(7),'Enable','off','Value',0);
                Obj.EnablePanel34('off');
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                Obj.EnablePanel31 ('off');
                set(Obj.CheckBox3(2),'Enable','off','Value',0);
                set(Obj.CheckBox3(3),'Enable','off','Value',0);
                set(Obj.CheckBox3(6),'Enable','off','Value',0);
                set(Obj.CheckBox3(7),'Enable','off','Value',0);
                Obj.EnablePanel34('off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag ==0
                Obj.EnablePanel31 ('off');
            else
                Obj.EnablePanel31 ('on');
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1
                set(Obj.CheckBox3(2),'Value',1);
                set(Obj.CheckBox3(3),'Enable','on');
                set(Obj.CheckBox3(6),'Enable','on');
                Obj.EnablePanel33('on');
                Obj.EnablePanel34('on');
                set (Obj.rbh3(1), 'Enable', 'off');
                set (Obj.rbh3(2), 'Enable', 'off');
                set (Obj.Button3(1), 'Enable', 'off');
            else
                set(Obj.CheckBox3(2),'Value',0);
                set(Obj.CheckBox3(3),'Enable','off');
                set(Obj.CheckBox3(6),'Enable','off');
                set(Obj.CheckBox3(7),'Enable','off');
                Obj.EnablePanel34('off');
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk == 1
                set (Obj.CheckBox3(1), 'Value', 1);
                set(Obj.CheckBox3(5),'Enable','on');
            else
                set (Obj.CheckBox3(1), 'Value', 0);
                set(Obj.CheckBox3(5),'Enable','off');
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 1
                set (Obj.CheckBox3(3), 'Value', 1);
                set(Obj.CheckBox3(7),'Enable','on');
            else
                set (Obj.CheckBox3(3), 'Value', 0);
                set(Obj.CheckBox3(7),'Enable','off');
            end
            
        end
        
        function Obj = RefreshPanel32 (Obj)
        
            if Obj.nprofile==0
                for i=4:7
                    set(Obj.CheckBox3(i), 'Enable','off', 'Value', 0);
                end
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                for i=4:7
                    set(Obj.CheckBox3(i), 'Enable','off', 'Value', 0);
                end
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag ==0
                for i=4:7
                    set(Obj.CheckBox3(i), 'Enable','off', 'Value', 0);
                end
            else
                set(Obj.CheckBox3(4), 'Enable','on');
                if Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk ==1
                    set (Obj.CheckBox3(4), 'Value', 1);
                else
                    set (Obj.CheckBox3(4), 'Value', 0);
                end
                
                if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageDerivateOk ==1
                    set (Obj.CheckBox3(5), 'Value', 1);
                else
                    set (Obj.CheckBox3(5), 'Value', 0);
                end
            
                if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesDerivateOk ==1
                    set (Obj.CheckBox3(6), 'Value', 1);
                else
                    set (Obj.CheckBox3(6), 'Value', 0);
                end
            
                if Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk ==1
                    set (Obj.CheckBox3(7), 'Value', 1);
                else
                    set (Obj.CheckBox3(7), 'Value', 0);
                end
            end
            
        end
        
        function Obj = RefreshPanel33 (Obj)
            
            
            if Obj.nprofile==0
                Obj.EnablePanel33 ('off');
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                Obj.EnablePanel33 ('off');
                return;
            end
            Obj.EnablePanel33 ('off');
            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 1 || Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1 || Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk == 1
                Obj.EnablePanel33 ('on');
            end
                       
        
        end
        
        function Obj = RefreshPanel34 (Obj)
           
            if Obj.nprofile==0
                set (Obj.CheckBox3(8), 'Enable', 'off','Value', 0);
                set (Obj.CheckBox3(9), 'Enable', 'off','Value', 0);
                set (Obj.CheckBox3(10), 'Enable', 'off','Value', 0);
                set (Obj.Button3(1), 'String', 'Add','Enable', 'off');
                set(Obj.rbh3(1),'Enable','off','Value',0);
                set(Obj.rbh3(2),'Enable','off','Value',0);
                set (Obj.Button3(1), 'Enable', 'off', 'String', 'Add');
                set (Obj.EditText3(2), 'String', '','Enable','off');
                set (Obj.Text3(4), 'String', '');
                set (Obj.Button3(2), 'Enable', 'off');
                set (Obj.CheckBox3(10), 'Enable', 'off','Value',0);
                
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                set (Obj.CheckBox3(8), 'Enable', 'off','Value', 0);
                set (Obj.CheckBox3(9), 'Enable', 'off','Value', 0);
                set (Obj.CheckBox3(10), 'Enable', 'off','Value', 0);
                set (Obj.Button3(1), 'String', 'Add','Enable', 'off');
                set(Obj.rbh3(1),'Enable','off','Value',0);
                set(Obj.rbh3(2),'Enable','off','Value',0);
                set (Obj.Button3(1), 'Enable', 'off', 'String', 'Add');
                set (Obj.EditText3(2), 'String', '','Enable','off');
                set (Obj.Text3(4), 'String', '');
                set (Obj.CheckBox3(9), 'Enable', 'off','Value',0);
                set (Obj.Button3(2), 'Enable', 'off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.MassOk == 1
                set (Obj.CheckBox3(8), 'Value', 1);
                set(Obj.rbh3(1),'Enable','on');
                set(Obj.rbh3(2),'Enable','on');
                set (Obj.CheckBox3(9), 'Enable', 'off');
                if Obj.ProfileArray(Obj.Aprofile).Config.MassMethod == 0
                    set(Obj.rbh3(1),'Value',1);
                    set(Obj.rbh3(2),'Value',0);
                    set (Obj.Button3(1), 'Enable', 'on', 'String', 'Add');
                elseif Obj.ProfileArray(Obj.Aprofile).Config.MassMethod == 1
                    set(Obj.rbh3(1),'Value',0);
                    set(Obj.rbh3(2),'Value',1);
                    set (Obj.Button3(1), 'Enable', 'on', 'String', 'Add');
                else
                    set(Obj.rbh3(1),'Value',0);
                    set(Obj.rbh3(2),'Value',0);
                    set (Obj.Button3(1), 'Enable', 'off', 'String', 'Add');
                end
                
                if Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone ==1
                    set (Obj.Button3(1), 'String', 'Replace');
                    set (Obj.CheckBox3(9), 'Value', 1, 'Enable', 'on');
                else
                    set (Obj.CheckBox3(9), 'Value', 0, 'Enable', 'off');
                end
            else
                set (Obj.CheckBox3(8), 'Value', 0);
                set (Obj.CheckBox3(9), 'Enable', 'off');
                if Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone ==1
                    set (Obj.Button3(1), 'String', 'Replace','Enable', 'off');
                    set (Obj.CheckBox3(9), 'Value', 1);
                else
                    set (Obj.Button3(1), 'String', 'Add','Enable', 'off');
                    set (Obj.CheckBox3(9), 'Value', 0);
                end
                set(Obj.rbh3(1),'Enable','off');
                set(Obj.rbh3(2),'Enable','off');
                if Obj.ProfileArray(Obj.Aprofile).Config.MassMethod == 0
                    set(Obj.rbh3(1),'Value',1);
                    set(Obj.rbh3(2),'Value',0);
                elseif Obj.ProfileArray(Obj.Aprofile).Config.MassMethod == 1
                    set(Obj.rbh3(1),'Value',0);
                    set(Obj.rbh3(2),'Value',1);
                else
                    set(Obj.rbh3(1),'Value',0);
                    set(Obj.rbh3(2),'Value',0);
                end
                set (Obj.Button3(1), 'Enable', 'off', 'String', 'Add');
            end         

            if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1
                Obj.EnablePanel34('on');
                aux = num2str(Obj.ProfileArray(Obj.Aprofile).Config.DensoUncertainty);
                set (Obj.EditText3(2), 'String', aux);
            else
               Obj.EnablePanel34('off');
               set (Obj.EditText3(2), 'String', '');
            end
            
            if Obj.ProfileArray(Obj.Aprofile).Config.DensityDataOk==1
                aux=Obj.ProfileArray(Obj.Aprofile).Config.DensityDataName;
                set (Obj.Text3(4), 'Enable', 'on','String',aux);
                set (Obj.Button3(2), 'Enable', 'on');
                set (Obj.CheckBox3(10), 'Enable', 'on','Value',1);
            else
                aux=Obj.ProfileArray(Obj.Aprofile).Config.DensityDataName;
                set (Obj.Text3(4), 'Enable', 'off','String',aux);
                set (Obj.Button3(2), 'Enable', 'off');
                set (Obj.CheckBox3(10),'Value',0);
            end
            
        end
        
        function Obj = RefreshPanel35 (Obj)
            
            if Obj.nprofile==0
                set(Obj.Popup3, 'Enable', 'off');
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).nCurves==0
                set(Obj.Popup3, 'Enable', 'off');
                return;
            end
            j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
            for i=1:38
                aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                if aux ==1
                    Option =i;
                    break;
                end
                if i==38
                    Option=[];
                end
            end
            aux = isempty(Option);
            if aux==0
                if Option >10 && Option <19
                    set(Obj.Popup3, 'Enable', 'on');
                else
                    set(Obj.Popup3, 'Enable', 'off');
                end
            else
                set(Obj.Popup3, 'Enable', 'off');
            end 
            
        end
        
        function Obj = InitializeSmooth (Obj)
        
            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothWindowt=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothWindowT=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothWindowt=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothWindowT=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothWindowt=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothWindowT=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothWindowt=0;
                Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothWindowT=0;
            end

        end
        
        function Obj = RefreshCalculusAba (Obj)
           
            Obj.RefreshPanel31;
            Obj.RefreshPanel32;
            Obj.RefreshPanel33;
            Obj.RefreshPanel34;
            Obj.RefreshPanel35;
            
        end
        
        function Obj = ResetAbaDensities (Obj)
            
            %Reseta as variáveis associadas a interface
            Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.DensitiesDerivateOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageDerivateOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.Denso=[];
            Obj.ProfileArray(Obj.Aprofile).Config.DensoUncertainty=[];
            Obj.ProfileArray(Obj.Aprofile).Config.MassOk=[];
            Obj.ProfileArray(Obj.Aprofile).Config.MassMethod=[];
            Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionFile=[];
            Obj.ProfileArray(Obj.Aprofile).Config.MassCorrectionDone=[];
            Obj.ProfileArray(Obj.Aprofile).Config.DensityDataOk=0;
            Obj.ProfileArray(Obj.Aprofile).Config.DensityDataName=[];
            Obj.ProfileArray(Obj.Aprofile).Config.DensityDataFile=[];
            
            %Reseta a interface
            Obj.EnablePanel31('off');
            Obj.EnablePanel32('off');
            Obj.EnablePanel33('off');
            Obj.EnablePanel34('off');
            Obj.EnablePanel35('off');
            Obj.RefreshPanel31;
            Obj.RefreshPanel32;
            Obj.RefreshPanel33;
            Obj.RefreshPanel34;
            Obj.RefreshPanel35;
            Obj.ResetPanel35;
            
                        
        end
        
        function Obj = ResetPanel35 (Obj)
           
            set (Obj.EditText3(3), 'Enable', 'off', 'String', ' ');
            set (Obj.Slider3(1), 'Enable', 'off', 'Value', 0);
            set (Obj.Popup3(1), 'Value', 1, 'Enable', 'off');
        end
        
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Funções que criam os componentes da aba Uncertainty%%%%%%%
        
        function Obj = AbaUncertaintyComp (Obj)
            
            %Fundos
            Obj.FundoEsqUnc = uiextras.VBox('Parent', Obj.AbaUncertainty);
            Obj.FundoDirUnc= uiextras.VBox('Parent', Obj.AbaUncertainty);
            
            %Fundo do Box Esquerdo
            Obj.Panel4(1) = ViewConstructor.Panel(Obj.FundoEsqUnc,'Uncertainty');
            Obj.FundoApply = ViewConstructor.Fundo (Obj.FundoEsqUnc);              % Fundo para os botão Apply
            Obj.FundoMessage = ViewConstructor.Fundo (Obj.FundoDirUnc);            % Fundo para mensagem à direita


            %Criação dos Objetos do Panel1
            Obj.Text4(2) = ViewConstructor.Text (Obj.Panel4(1), [0.05 0.25 0.4 0.15], 'Resolution:');
            Obj.Text4(3) = ViewConstructor.Text (Obj.Panel4(1), [0.7 0.25 0.2 0.15], '[mm]');
            Obj.rbh4(1) = ViewConstructor.RadioButton (Obj.Panel4(1), 'None', [0.05 0.8 0.4 0.15],{@UncertConfigFunc,1});
            Obj.rbh4(2) = ViewConstructor.RadioButton (Obj.Panel4(1), 'Resolution', [0.05 0.65 0.4 0.15],{@UncertConfigFunc,2});
            Obj.EditText4(1) = ViewConstructor.EditText(Obj.Panel4(1), [0.4 0.32 0.3 0.10], {@UncertConfigFunc,4});
            
            
            %Criação do botão Apply
            Obj.ApplyButtonUnc = ViewConstructor.Button(Obj.FundoApply,'Apply',[0.35 0.4 0.3 0.25], {@UncertConfigFunc,7});
            
            %Criação da mensagem de espera
            Obj.Text4(1) = ViewConstructor.Text (Obj.FundoMessage, [0.1 0.05 0.8 0.75], 'Please wait! This process can take several minutes.');
            
            %Configuração da aba
            set( Obj.AbaUncertainty, 'Sizes', [240 -1], 'Spacing', 5 ); 
            set( Obj.FundoEsqUnc, 'Sizes', [250 -1], 'Spacing', 5 ); 
            Obj.EnablePanel41 ('off');
            set (Obj.Text4(1), 'Enable', 'off');
            
            function UncertConfigFunc(hObject,~, whichHandle)
                switch whichHandle
                    case 1 
                        set (Obj.rbh4(1), 'Value', 1);
                        set (Obj.rbh4(2), 'Value', 0);
                        Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod=0;
                        set (Obj.EditText4(1), 'Enable', 'off');
                        set (Obj.ApplyButtonUnc, 'Enable', 'off');
                        set (Obj.Text4(2), 'Enable', 'off');
                        set (Obj.Text4(3), 'Enable', 'off');
                    case 2
                        set (Obj.rbh4(1), 'Value', 0);
                        set (Obj.rbh4(2), 'Value', 1);
                        Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod=1;
                        set (Obj.EditText4(1), 'Enable', 'on');
                        aux = isempty (Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                        if aux==0
                            set (Obj.ApplyButtonUnc, 'Enable', 'on');
                        else
                            set (Obj.ApplyButtonUnc, 'Enable', 'off');
                        end
                        set (Obj.Text4(2), 'Enable', 'on');
                        set (Obj.Text4(3), 'Enable', 'on');
                    case 4
                        str=get(hObject,'String');
                        if isnan(str2double(str)); 
                            set(hObject,'string','');
                            errordlg('Please enter with a numeric value','Warning','modal');
                            uicontrol(hObject);
                            return;
                        end
                        Obj.ProfileArray(Obj.Aprofile).Config.Resolution = str2double(get(hObject,'String'));
                        if Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod==1
                            set (Obj.ApplyButtonUnc, 'Enable', 'on');
                        else
                            set (Obj.ApplyButtonUnc, 'Enable', 'off');
                        end
                    case 5
                        set (Obj.EditText4(2), 'String', Obj.ProfileArray(Obj.Aprofile).Config.Stringname);
                    case 6
                        [name,path] = uigetfile('*.dat','Import File');            %Nome do arquivo de dados
                        %Método que valida o formato dos dados
                        [valida,file] = Obj.ValidaDados (name, path, hObject);
                        if valida==0
                            errordlg('File not uploaded','Warning','modal');
                            uicontrol(hObject);
                            return;
                        end
                        Obj.ProfileArray(Obj.Aprofile).Config.Stringname=name;
                        Obj.ProfileArray(Obj.Aprofile).Config.CETFile = file;
                        aux = isempty (Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                        if aux==0
                            set (Obj.ApplyButtonUnc, 'Enable', 'on');
                        else
                            set (Obj.ApplyButtonUnc, 'Enable', 'off');
                        end
                        set (Obj.EditText4(2), 'Enable', 'on', 'String', Obj.ProfileArray(Obj.Aprofile).Config.Stringname);
                        
                    case 7
                        if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk==1
                            aux2=Obj.ProfileArray(Obj.Aprofile).Config.DensoUncertainty;
                            aux = isempty (aux2);
                            if aux==1
                                errordlg('Please enter with green density uncertainties','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                        end
                            
                        
                        set (Obj.Text4(1), 'Enable', 'on');
                        tic;
                        Obj.ProfileArray(Obj.Aprofile).ApplyUncertainty;
                        aux=toc;
                        
                        aux = num2str(aux);
                        Obj.ProfileArray(Obj.Aprofile).UncTime=aux;
                        aux = strcat ('Computed uncertainties in _', Obj.ProfileArray(Obj.Aprofile).UncTime, '_ seconds');
                        if Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag==1
                            set (Obj.Text4(1), 'String', aux);
                        else
                            set (Obj.Text4(1), 'String', 'Uncertainties not computed');
                        end
                        Obj.CheckUncFlags;
                        Obj.RefreshListBox;
                        Obj.EnableAbaMSC;
                end
            end
            
        end
        
        function Obj = EnablePanel41 (Obj, Enable)
        
            for i=1:2
                set (Obj.rbh4(i), 'Enable', Enable);
            end
            %set (Obj.Button4(1), 'Enable', Enable);
            set (Obj.EditText4(1), 'Enable', Enable);
            %set (Obj.EditText4(2), 'Enable', Enable);
            set (Obj.Text4(2), 'Enable', Enable);
            set (Obj.Text4(3), 'Enable', Enable);
            %set (Obj.Text4(4), 'Enable', Enable);
            set (Obj.ApplyButtonUnc, 'Enable', Enable);
        end
        
        function Obj = RefreshAbaUncertainty (Obj)
           if Obj.ProfileArray(Obj.Aprofile).ShrinkageFlag ==0
               Obj.EnablePanel41 ('off');
               set (Obj.rbh4(1), 'Value', 1);
               set (Obj.rbh4(2), 'Value', 0);
               set (Obj.EditText4(1), 'String', '');
               set (Obj.Text4(2), 'Enable', 'off');
               set (Obj.Text4(3), 'Enable', 'off');
               set (Obj.Text4(1), 'String', 'Uncertainties not computed');
           else
               for i=1:2
                   set (Obj.rbh4(i), 'Enable', 'on');
               end
               if Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod==0
                   set (Obj.rbh4(1), 'Value', 1);
                   set (Obj.rbh4(2), 'Value', 0);
                   set (Obj.EditText4(1), 'Enable', 'off', 'String', Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                   set (Obj.ApplyButtonUnc, 'Enable', 'off');
                   set (Obj.Text4(2), 'Enable', 'off');
                   set (Obj.Text4(3), 'Enable', 'off');
               elseif Obj.ProfileArray(Obj.Aprofile).Config.UncertaintyMethod==1
                   set (Obj.rbh4(1), 'Value', 0);
                   set (Obj.rbh4(2), 'Value', 1);
                   set (Obj.EditText4(1), 'Enable', 'on','String', Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                   aux = isempty (Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                   if aux ==0
                       set (Obj.ApplyButtonUnc, 'Enable', 'on');
                   else
                       set (Obj.ApplyButtonUnc, 'Enable', 'off');
                   end
                   set (Obj.Text4(2), 'Enable', 'on');
                   set (Obj.Text4(3), 'Enable', 'on');
               else
                   set (Obj.rbh4(1), 'Value', 0);
                   set (Obj.rbh4(2), 'Value', 0);
                   set (Obj.EditText4(1), 'Enable', 'on');
                    aux = isempty (Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                    aux2 = isempty (Obj.ProfileArray(Obj.Aprofile).Config.CETFile);
                   if aux ==0 && aux2==0
                       set (Obj.ApplyButtonUnc, 'Enable', 'on');
                   else
                       set (Obj.ApplyButtonUnc, 'Enable', 'off');
                   end
                   if aux==0
                       set (Obj.EditText4(1),'String',Obj.ProfileArray(Obj.Aprofile).Config.Resolution);
                   else
                       set (Obj.EditText4(1), 'String', '');
                   end
                   if aux2==0
                       set (Obj.EditText4(2),'String',Obj.ProfileArray(Obj.Aprofile).Config.Stringname);
                   else
                       set (Obj.EditText4(2), 'String', '');
                   end
                   set (Obj.Text4(2), 'Enable', 'on');
                   set (Obj.Text4(3), 'Enable', 'on');
               end
           
               if Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag==1
                   aux = strcat ('Computed uncertainties in _', Obj.ProfileArray(Obj.Aprofile).UncTime, '_ seconds');
                   set (Obj.Text4(1), 'String', aux, 'Enable', 'on');
               else
                   set (Obj.Text4(1), 'String', 'Uncertainties not computed','Enable', 'on');
               end
               
            
           end
        end
        
        function Obj = CheckUncFlags (Obj)
           
            Obj.ProfileArray(Obj.Aprofile).GraphFlag(19)=1;
            if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(20)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(20)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(21)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(21)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(22)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(22)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.ShrinkageDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(23)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(24)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(23)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(24)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.DensitiesDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(25)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(26)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(25)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(26)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.DensificationDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(27)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(28)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(27)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(28)=0;
            end
            if Obj.ProfileArray(Obj.Aprofile).Config.InstShrinkageDerivateOk == 1
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(29)=1;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(30)=1;
            else
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(29)=0;
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(30)=0;
            end
            
                  
        end
        
        function Obj = ResetAbaUncertainty (Obj)
           
            Obj.EnablePanel41 ('off');
            Obj.RefreshAbaUncertainty;
            Obj.ProfileArray(Obj.Aprofile).Config.Resolution=[];
            for i=19:30
                Obj.ProfileArray(Obj.Aprofile).GraphFlag(i)=0;
            end
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Funções que criam os componentes da aba Arrhenius%%%%%%%%%
        
        function Obj = AbaArrheniusComp (Obj)
            
            %Fundos
            Obj.FundoEsqArr = uiextras.VBox('Parent', Obj.AbaArrhenius);
            Obj.FundoDirArr = uiextras.VBox('Parent', Obj.AbaArrhenius);
            
            %Panels Esquerdo
            Obj.Panel7(1) = ViewConstructor.Panel(Obj.FundoEsqArr,'Data Option');
            Obj.Panel7(2) = ViewConstructor.Panel(Obj.FundoEsqArr,'Fitting Parameters');
            Obj.FundoArr1 = ViewConstructor.Fundo(Obj.FundoEsqArr);
            
            %Panels Direito
            Obj.Panel7(3) = ViewConstructor.Fundo(Obj.FundoDirArr);
            
            %Criação dos objetos do Panel1
            Obj.rbh7(1) = ViewConstructor.RadioButton (Obj.Panel7(1), 'Strain Data', [0.10 0.55 0.6 0.30], {@ArrSelectFunc,1});
            Obj.rbh7(2) = ViewConstructor.RadioButton (Obj.Panel7(1), 'Density Data', [0.10 0.20 0.6 0.30], {@ArrSelectFunc,2});
            
            %Criação dos objetos do Panel2
            Obj.Text7(1) = ViewConstructor.Text (Obj.Panel7(2), [0.02 0.60 0.5 0.30], 'Initial Density:');
            Obj.Text7(2) = ViewConstructor.Text (Obj.Panel7(2), [0.02 0.30 0.5 0.30], 'Final Density:');
            Obj.Text7(3) = ViewConstructor.Text (Obj.Panel7(2), [0.02 0.00 0.5 0.30], 'Density Step:');
            Obj.EditText7(1) = ViewConstructor.EditText(Obj.Panel7(2), [0.56 0.77 0.35 0.18], {@ArrSelectFunc,3});
            Obj.EditText7(2) = ViewConstructor.EditText(Obj.Panel7(2), [0.56 0.47 0.35 0.18], {@ArrSelectFunc,4});
            Obj.EditText7(3) = ViewConstructor.EditText(Obj.Panel7(2), [0.56 0.17 0.35 0.18], {@ArrSelectFunc,5});
            
            %Criação dos objetos do Fundo
            Obj.Button7(1) = ViewConstructor.Button(Obj.FundoArr1,'Apply',[0.14 0.2 0.35 0.25],{@ArrSelectFunc,6});
            
            %Configura a aba
            set( Obj.AbaArrhenius, 'Sizes', [200 -1], 'Spacing', 5 ); 
            set( Obj.FundoEsqArr, 'Sizes', [100 150 -1], 'Spacing', 5 ); 
            set( Obj.FundoDirArr, 'Sizes', 400, 'Spacing', 5 ); 
            Obj.EnableAbaArr;
            
                function ArrSelectFunc(hObject,~, whichHandle)
                    switch whichHandle
                        case 1 %Radio Button1
                            aux= get(hObject, 'Value');
                            if aux==1
                                set(Obj.rbh7(2),'Value', 0);
                                Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption=1;
                            else
                                set(Obj.rbh7(2),'Value', 1);
                                Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption=2;
                            end
                        case 2 %Radio Button2
                            aux= get(hObject, 'Value');
                            if aux==1
                                set(Obj.rbh7(1),'Value', 0);
                                Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption=2;
                            else
                                set(Obj.rbh7(1),'Value', 1);
                                Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption=1;
                            end
                        case 3
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).Arrhenius.InitDens=str2double(get(hObject,'String'));
                        case 4
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).Arrhenius.FinalDens=str2double(get(hObject,'String'));
                        case 5
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).Arrhenius.StepDens=str2double(get(hObject,'String'));
                        case 6
                            aux1= isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.InitDens);
                            aux2=isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.FinalDens);
                            aux3=isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.StepDens);
                            
                            aux4=aux1+aux2+aux3;
                            if aux4>0
                                errordlg('Please insert the input data','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            
                            if isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption)==1
                                errordlg('Please insert data option','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            
                            ini = Obj.ProfileArray(Obj.Aprofile).Arrhenius.InitDens;
                            final = Obj.ProfileArray(Obj.Aprofile).Arrhenius.FinalDens;
                            ncurves = Obj.ProfileArray(Obj.Aprofile).nCurves;
            
                            for i =1:ncurves
                                Data= Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve;
                                ndados=size(Data);
                                if ini < Data(1,3) || final > Data(ndados(1,1),3)
                                    errordlg('Invalid initial and final densities options','Warning','modal');
                                    uicontrol(hObject);
                                    Data(1,3)
                                    Data(ndados(1,1),3)
                                    return;
                                end
                    
                            end
                            
                            %Bloco que verifica se as curvas das derivadas foram calculadas
                            if Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption==1
                                if Obj.ProfileArray(Obj.Aprofile).ShrinkageDerFlag==0
                                    errordlg('Please calculate shrinkage derivates before apply','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                            else
                                if Obj.ProfileArray(Obj.Aprofile).DensityDerFlag==0;
                                    errordlg('Please calculate density derivates before apply','Warning','modal');
                                    uicontrol(hObject);
                                    return;
                                end
                            end
                            
                            Obj.MakeArrheniusData;
                            Obj.ProfileArray(Obj.Aprofile).Arrhenius.ApplyArrhenius;
                            Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusFlag=1;
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(31)=1;
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(32)=1;
                            Obj.RefreshListBox;
                            set (Obj.ListBox6, 'Value', Obj.Listsize);
                            aux1 = Obj.Listsize;
                            aux2 = get (Obj.ListBox6, 'String');
                            aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                            Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                            Obj.GraphData;
                            
                    end
                end
        end
        
        function Obj = MakeArrheniusData (Obj)
           
            ini=Obj.ProfileArray(Obj.Aprofile).Arrhenius.InitDens;
            final=Obj.ProfileArray(Obj.Aprofile).Arrhenius.FinalDens;
            step=Obj.ProfileArray(Obj.Aprofile).Arrhenius.StepDens;
            nlinhas = 1+floor((final-ini)/step);
            ncols = 2*Obj.ProfileArray(Obj.Aprofile).nCurves+1;
            Obj.ProfileArray(Obj.Aprofile).Arrhenius.Data=zeros(nlinhas,ncols);
            
            for i=1:nlinhas
               Obj.ProfileArray(Obj.Aprofile).Arrhenius.Data(i,1)=ini+(i-1)*step;
            end
            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                [xdata,ydata,~,xdata2] = interpdens (Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve, Obj.ProfileArray(Obj.Aprofile).Arrhenius.Data(:,1));
                if Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption==1
                   ydata2= interpstrain (Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve, xdata);
                   ydata3=interpderivate(Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivatet, xdata2);
                else
                   ydata3=interpderivate(Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivatet, xdata2);
                end
                Obj.ProfileArray(Obj.Aprofile).Arrhenius.Data(:,2*i)=1000./(xdata+273.15*ones(nlinhas,1));
                if Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption==1
                    Obj.ProfileArray(Obj.Aprofile).Arrhenius.Data(:,2*i+1)=log((1./ydata2).*ydata3.*(xdata+273.15*ones(nlinhas,1)));
                else
                    Obj.ProfileArray(Obj.Aprofile).Arrhenius.Data(:,2*i+1)=log((1./ydata).*ydata3.*(xdata+273.15*ones(nlinhas,1)));
                end
                
            end
            
            
        end
        
        function Obj = EnableAbaArr (Obj)
           
            set(Obj.rbh7(1), 'Enable', 'off', 'Value',0);
            set(Obj.rbh7(2), 'Enable', 'off', 'Value',0);
            for i=1:3
                set(Obj.EditText7(i), 'Enable', 'off', 'String', '');
                set(Obj.Text7(i), 'Enable', 'off');
            end
            set(Obj.Button7(1), 'Enable', 'off');
            if Obj.nprofile==0
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).DensityFlag==1
                set(Obj.rbh7(1), 'Enable', 'on');
                set(Obj.rbh7(2), 'Enable', 'on');
                 set(Obj.Button7(1), 'Enable', 'on');
                for i=1:3
                    set(Obj.EditText7(i), 'Enable', 'on');
                    set(Obj.Text7(i), 'Enable', 'on');
                end
            Obj.RefreshAbaArr;
            end
            
            
        end
        
        function Obj = RefreshAbaArr (Obj)
        
            if Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption==1
                set (Obj.rbh7(1), 'Value', 1);
                set (Obj.rbh7(2), 'Value', 0);
            elseif Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption==2
                set (Obj.rbh7(1), 'Value', 0);
                set (Obj.rbh7(2), 'Value', 1);
            else
                set (Obj.rbh7(1), 'Value', 0);
                set (Obj.rbh7(2), 'Value', 0);
            end

            if isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.InitDens)==1
                set (Obj.EditText7(1), 'String',' ');
            else
                set (Obj.EditText7(1), 'String', num2str(Obj.ProfileArray(Obj.Aprofile).Arrhenius.InitDens));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.FinalDens)==1
                set (Obj.EditText7(2), 'String',' ');
            else
                set (Obj.EditText7(2), 'String', num2str(Obj.ProfileArray(Obj.Aprofile).Arrhenius.FinalDens));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).Arrhenius.StepDens)==1
                set (Obj.EditText7(3), 'String',' ');
            else
                set (Obj.EditText7(3), 'String', num2str(Obj.ProfileArray(Obj.Aprofile).Arrhenius.StepDens));
            end
        
        end
        
        function Obj = ResetAbaArrhenius (Obj)
           set(Obj.rbh7(1), 'Enable', 'off', 'Value',0);
            set(Obj.rbh7(2), 'Enable', 'off', 'Value',0);
            for i=1:3
                set(Obj.EditText7(i), 'Enable', 'off', 'String', '');
                set(Obj.Text7(i), 'Enable', 'off');
            end
            set(Obj.Button7(1), 'Enable', 'off');
            Obj.ProfileArray(Obj.Aprofile).Arrhenius.Reset;
            Obj.ProfileArray(Obj.Aprofile).GraphFlag(31)=0;
            Obj.ProfileArray(Obj.Aprofile).GraphFlag(32)=0;
                            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Funções que criam os componentes da aba Arrhenius%%%%%%%%%
        
        function Obj = AbaMSCComp (Obj)
            
            %Fundos
            Obj.FundoEsqMSC = uiextras.VBox('Parent', Obj.AbaMSC);
            Obj.FundoDirMSC = uiextras.VBox('Parent', Obj.AbaMSC);
            
            %Panels Esquerdo
            Obj.Panel8(1) = ViewConstructor.Panel(Obj.FundoEsqMSC,'Fitting Options');
            Obj.FundoMSC1= ViewConstructor.Fundo(Obj.FundoEsqMSC);
            
            %Panels Direito
            Obj.Panel8(2) = ViewConstructor.Panel(Obj.FundoDirMSC,'Stage Parameters');
            Obj.Panel8(3) = ViewConstructor.Panel(Obj.FundoDirMSC,'Fitting Results');
            Obj.Panel8(4) = ViewConstructor.Panel(Obj.FundoDirMSC,'Residual Graphs');
            
            %Criação dos objetos do Panel1
            Obj.Text8(1) = ViewConstructor.Text (Obj.Panel8(1), [0.02 0.88 0.2 0.10], 'Function');
            Obj.Text8(2) = ViewConstructor.Text (Obj.Panel8(1), [0.01 0.67 0.2 0.1], 'Stages');
            Obj.Text8(3) = ViewConstructor.Text (Obj.Panel8(1), [0.02 0.46 0.2 0.1], 'Fitting');
            Obj.Text8(4) = ViewConstructor.Text (Obj.Panel8(1), [0.2 0.32 0.4 0.1], 'Activation Energy');
            Obj.Text8(5) = ViewConstructor.Text (Obj.Panel8(1), [0.02 0.10 0.2 0.1], 'Method');
            Obj.rbh8(1) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Sigmoidal', [0.12 0.85 0.5 0.08], {@MSCSelectFunc,1});
            Obj.rbh8(2) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Polynomial', [0.12 0.78 0.6 0.08], {@MSCSelectFunc,2});
            Obj.rbh8(3) = ViewConstructor.RadioButton (Obj.Panel8(1), 'NLLS Fit', [0.12 0.21 0.6 0.08], {@MSCSelectFunc,3});
            Obj.rbh8(4) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Single Stage', [0.12 0.64 0.6 0.08], {@MSCSelectFunc,4});
            Obj.rbh8(5) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Double Stage', [0.12 0.57 0.6 0.08], {@MSCSelectFunc,5});
            Obj.rbh8(6) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Selected Activation Energy', [0.12 0.43 0.8 0.08], {@MSCSelectFunc,6});
            Obj.rbh8(7) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Scanning Activation Energies', [0.12 0.28 0.8 0.08], {@MSCSelectFunc,7});
            Obj.rbh8(8) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Non Weighted Least Squares', [0.12 0.07 0.8 0.08], {@MSCSelectFunc,8});
            Obj.rbh8(9) = ViewConstructor.RadioButton (Obj.Panel8(1), 'Weighted Least Squares', [0.12 0.00 0.8 0.08], {@MSCSelectFunc,9});
            Obj.rbh8(10) = ViewConstructor.RadioButton (Obj.Panel8(1), 'TLS Fit', [0.52 0.21 0.3 0.08], {@MSCSelectFunc,9});
            Obj.EditText8(1) = ViewConstructor.EditText(Obj.Panel8(1), [0.7 0.37 0.25 0.06], {@MSCSelectFunc,10});
            Obj.EditText8(6) = ViewConstructor.EditText(Obj.Panel8(1), [0.7 0.8 0.27 0.06], {@MSCSelectFunc,15});
            
            
            %Criação dos objetos do Panel2
            Obj.Text8(6) = ViewConstructor.Text (Obj.Panel8(2), [0.02 0.82 0.2 0.14], 'Stage 1');
            Obj.Text8(7) = ViewConstructor.Text (Obj.Panel8(2), [0.02 0.66 0.4 0.14], 'Initial Density:');
            Obj.Text8(8) = ViewConstructor.Text (Obj.Panel8(2), [0.02 0.5 0.4 0.14], 'Final Density:');
            Obj.Text8(9) = ViewConstructor.Text (Obj.Panel8(2), [0.02 0.34 0.2 0.14], 'Stage 2');
            Obj.Text8(10) = ViewConstructor.Text (Obj.Panel8(2), [0.02 0.18 0.4 0.14], 'Final Density:');
            Obj.EditText8(2) = ViewConstructor.EditText(Obj.Panel8(2), [0.56 0.67 0.35 0.15], {@MSCSelectFunc,11}); 
            Obj.EditText8(3) = ViewConstructor.EditText(Obj.Panel8(2), [0.56 0.51 0.35 0.15], {@MSCSelectFunc,12});
            Obj.EditText8(4) = ViewConstructor.EditText(Obj.Panel8(2), [0.56 0.19 0.35 0.15], {@MSCSelectFunc,13});
             
            %Criação dos objetos do Panel4
            Obj.Text8(12) = ViewConstructor.Text (Obj.Panel8(3), [0.02 0.7 0.4 0.2], 'Activation Energy:');
            Obj.Text8(13) = ViewConstructor.Text (Obj.Panel8(3), [0.02 0.5 0.4 0.2], 'Uncertainty:');
            Obj.Text8(14) = ViewConstructor.Text (Obj.Panel8(3), [0.42 0.65 0.2 0.2], '-');
            Obj.Text8(15) = ViewConstructor.Text (Obj.Panel8(3), [0.42 0.5 0.2 0.2], '-');
            Obj.Text8(16) = ViewConstructor.Text (Obj.Panel8(3), [0.02 0.25 0.4 0.2], 'MSE');
            Obj.Text8(17) = ViewConstructor.Text (Obj.Panel8(3), [0.02 0.05 0.4 0.2], 'Final Degree');
            Obj.Text8(18) = ViewConstructor.Text (Obj.Panel8(3), [0.42 0.25 0.2 0.2], '-');
            Obj.Text8(19) = ViewConstructor.Text (Obj.Panel8(3), [0.42 0.05 0.2 0.2], '-');
            Obj.Text8(20) = ViewConstructor.Text (Obj.Panel8(3), [0.37 0.85 0.3 0.15], 'Stage 1');
            Obj.Text8(21) = ViewConstructor.Text (Obj.Panel8(3), [0.66 0.85 0.3 0.15], 'Stage 2');
            Obj.Text8(22) = ViewConstructor.Text (Obj.Panel8(3), [0.7 0.65 0.2 0.2], '-');
            Obj.Text8(23) = ViewConstructor.Text (Obj.Panel8(3), [0.7 0.5 0.2 0.2], '-');
            Obj.Text8(24) = ViewConstructor.Text (Obj.Panel8(3), [0.7 0.25 0.2 0.2], '-');
            Obj.Text8(25) = ViewConstructor.Text (Obj.Panel8(3), [0.7 0.05 0.2 0.2], '-');
            
            
            %Criação dos objetos do FundoMSC
            Obj.Button8(1) = ViewConstructor.Button(Obj.FundoMSC1,'Apply',[0.14 0.2 0.35 0.65],{@MSCSelectFunc,16});
            
            %Criação de objetos do Panel3
            Obj.Popup8(1) = ViewConstructor.Popupmenu (Obj.Panel8(4), [0.05 0.55 0.9 0.15], {'Select Data'}, {@MSCSelectFunc,17});
            
            
            %Configura a aba
            set( Obj.AbaMSC, 'Sizes', [225 -1], 'Spacing', 5 ); 
            set(Obj.FundoEsqMSC, 'Sizes', [-15 -2], 'Spacing', 5);
            set( Obj.FundoDirMSC, 'Sizes', [-6 -4 -2], 'Spacing', 5 );
            Obj.EnableAbaMSC;
            
            set (Obj.rbh8(10),'Enable','off');
            function MSCSelectFunc(hObject,~, whichHandle)
                    switch whichHandle
                        case 1 
                            set (Obj.rbh8(1), 'Value', 1);
                            set (Obj.rbh8(2), 'Value', 0);
                            set (Obj.rbh8(3), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(8), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(9), 'Enable','off', 'Value', 0);
                            set (Obj.EditText8(6), 'Enable', 'off');
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3
                               Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=[];
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction=1;
                            Obj.VerifyButton;
                        case 2
                            set (Obj.rbh8(1), 'Value', 0);
                            set (Obj.rbh8(2), 'Value', 1);
                            set (Obj.rbh8(3), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(8), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(9), 'Enable','off', 'Value', 0);
                            set (Obj.EditText8(6), 'Enable', 'on');
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3
                               Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=[];
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction=2;
                            Obj.VerifyButton;
                        case 3
                            set (Obj.rbh8(6), 'Value', 0);
                            set (Obj.rbh8(7), 'Value', 0);
                            set (Obj.rbh8(3), 'Value', 1);
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=3;
                            set (Obj.Text8(4), 'Enable', 'off');
                            set (Obj.EditText8(1), 'Enable', 'off');
                            set (Obj.rbh8(8), 'Enable', 'on');
                            if Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag==1
                                set (Obj.rbh8(9), 'Enable', 'on');
                            else
                                set (Obj.rbh8(9), 'Enable', 'off','Value',0);
                            end
                            Obj.VerifyButton;
                        
                        case 4
                            set (Obj.rbh8(4), 'Value', 1);
                            set (Obj.rbh8(5), 'Value', 0);
                            set (Obj.rbh8(3), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(8), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(9), 'Enable','off', 'Value', 0);
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3
                               Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=[];
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages=1;
                            Obj.EnablePanel82 ('on');
                            Obj.VerifyButton;
                        case 5
                            set (Obj.rbh8(4), 'Value', 0);
                            set (Obj.rbh8(5), 'Value', 1);
                            set (Obj.rbh8(3), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(8), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(9), 'Enable','off', 'Value', 0);
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3
                               Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=[];
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages=2;
                            Obj.EnablePanel82 ('on');
                            Obj.VerifyButton;
                        case 6
                            set (Obj.rbh8(6), 'Value', 1);
                            set (Obj.rbh8(7), 'Value', 0);
                            set (Obj.rbh8(3), 'Value', 0,'Enable','off');
                            set (Obj.rbh8(8), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(9), 'Enable','off', 'Value', 0);
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=1;
                            set (Obj.Text8(4), 'Enable', 'on');
                            set (Obj.EditText8(1), 'Enable', 'on');
                            Obj.VerifyButton;
                        case 7
                            set (Obj.rbh8(6), 'Value', 0);
                            set (Obj.rbh8(7), 'Value', 1);
                            set (Obj.rbh8(3), 'Value', 0);
                            set (Obj.rbh8(8), 'Enable','off', 'Value', 0);
                            set (Obj.rbh8(9), 'Enable','off', 'Value', 0);
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=2;
                            set (Obj.Text8(4), 'Enable', 'off');
                            set (Obj.EditText8(1), 'Enable', 'off');
                            Obj.VerifyButton;
                        case 8
                            set (Obj.rbh8(8), 'Value', 1);
                            set (Obj.rbh8(9), 'Value', 0);
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod=1;
                            Obj.VerifyButton;
                        case 9
                            set (Obj.rbh8(8), 'Value', 0);
                            set (Obj.rbh8(9), 'Value', 1);
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod=2;
                            Obj.VerifyButton;
                        case 10
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                Obj.ProfileArray(Obj.Aprofile).MSC.SelectionQ=[];
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                             Obj.ProfileArray(Obj.Aprofile).MSC.SelectionQ= str2double(get(hObject, 'String'));
                             Obj.VerifyButton;
                        case 11
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens= str2double(get(hObject, 'String'));
                            Obj.CheckDensities (hObject);
                            Obj.VerifyButton;
                        case 12
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens= str2double(get(hObject, 'String'));
                            Obj.CheckDensities (hObject);
                            Obj.VerifyButton;
                        case 13
                            str=get(hObject,'String');
                            if isempty (Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens)==1
                                errordlg('Please enter with the final density for stage 1 first','Warning','modal');
                                uicontrol(hObject);
                                set(hObject,'string','');
                                return;
                            end
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2= str2double(get(hObject, 'String'));
                            Obj.CheckDensities (hObject);
                            Obj.VerifyButton;
                        case 15
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Polynomial degree must be between 1 and 7','Warning','modal');
                                uicontrol(hObject);
                                Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau=[];
                                set(Obj.Button8(1), 'Enable', 'off');
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau= str2double(get(hObject, 'String'));
                            if Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau >7 || Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau <1
                                Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau=[];
                                set(hObject,'String','');
                                errordlg('Polynomial degree must be between 1 and 7','Warning','modal');
                                uicontrol(hObject); 
                                set(Obj.Button8(1), 'Enable', 'off');
                                return;
                            end
                            Obj.VerifyButton;
                        case 16
                            
                            %Verificação dos editBox das densidades iniciais e finais
                            a1= isempty (Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens);
                            a2= isempty (Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens);
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                                a3= isempty (Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2);
                            else
                                a3=0;
                            end
                            aux=a1+a2+a3;
                            if aux > 0
                                errordlg('Please complete densities information','Warning','modal');
                                uicontrol(hObject);    
                                return;
                            end
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2 && Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens >= Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2
                                errordlg('Final density of second stage must be greater than of final density of the first','Warning','modal');
                                uicontrol(hObject);    
                                return;
                            end
                            
                            
                            %Atribui os números de curvas para os objetos
                            Obj.ProfileArray(Obj.Aprofile).MSC.nCurves=Obj.ProfileArray(Obj.Aprofile).nCurves;
                            
                            %Atribuição dos dados para os objetos
                            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                                Obj.ProfileArray(Obj.Aprofile).MSC.OriginalData{i}=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve;
                                Obj.ProfileArray(Obj.Aprofile).MSC.OriginalVcov{i}=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.CurveUnc;
                            end
                            
                            %Chamada do método de construção da MSC
                            Obj.ProfileArray(Obj.Aprofile).MSC.ApplyMSC;
                                                        
                            %Atribuição das flags associadas
                            Obj.ProfileArray(Obj.Aprofile).MSCFlag=1;
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==1
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(33)=0;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(34)=0;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(35)=0;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(36)=0;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(37)=0;
                            else
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(33)=1;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(34)=1;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(37)=1;
                            end
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3 || Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==1
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(38)=1;
                            else
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(38)=0;
                            end
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(35)=1;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(36)=1;
                            else
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(35)=0;
                                Obj.ProfileArray(Obj.Aprofile).GraphFlag(36)=0;
                            end
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCIniFlag==1 && Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                                set(Obj.rbh8(3), 'Enable', 'on');
                            else
                                set(Obj.rbh8(3), 'Enable', 'off');
                            end
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(39)=0;
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(40)=0;
                            
                            %Atualização do list box de controle dos gráficos
                            Obj.RefreshListBox;
                            set (Obj.ListBox6, 'Value', Obj.Listsize);
                            aux1 = Obj.Listsize;
                            aux2 = get (Obj.ListBox6, 'String');
                            aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                            Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                            Obj.GraphData;
                            
                            %Atualização do panel de resíduos e de estatística do ajuste
                            Obj.ActualizePanel4;
                            Obj.RefreshValues ('on');
                            Obj.EnablePanel84 ('on');
                            
                            %Aciona a aba de Analysis
                            Obj.ResetAbaAnalysis;
                            
                        case 17
                            
                            Obj.ProfileArray(Obj.Aprofile).Popup8Choice=get(Obj.Popup8,'Value');
                            Obj.GraphData;
                    end        
            end
        end
        
        function Obj = CheckDensities (Obj, hObject)
           
            for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens < 0
                    Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens=[];
                    set(hObject,'String','');
                    errordlg('Density invalid','Warning','modal');
                    uicontrol(hObject);    
                    return;
                end
            end
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens > 150 
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens=[];
                set(hObject,'String','');
                errordlg('Density too high','Warning','modal');
                uicontrol(hObject);    
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
               if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2 > 150 
                    Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2=[];
                    set(hObject,'String','');
                    errordlg('Density too high','Warning','modal');
                    uicontrol(hObject);    
                    return;
                end
                
            end
            
        end
        
        function Obj = ActualizePanel4 (Obj)
            if Obj.nprofile ==0
                set (Obj.Text8(14), 'String', '-','Enable','off');
                set (Obj.Text8(15), 'String', '-','Enable','off');
                set (Obj.Text8(18), 'String', '-','Enable','off');
                set (Obj.Text8(19), 'String', '-','Enable','off');
                set (Obj.Text8(22), 'String', '-','Enable','off');
                set (Obj.Text8(23), 'String', '-','Enable','off');
                set (Obj.Text8(24), 'String', '-','Enable','off');
                set (Obj.Text8(25), 'String', '-','Enable','off');
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).MSCFlag==0
                set (Obj.Text8(14), 'String', '-','Enable','off');
                set (Obj.Text8(15), 'String', '-','Enable','off');
                set (Obj.Text8(18), 'String', '-','Enable','off');
                set (Obj.Text8(19), 'String', '-','Enable','off');
                set (Obj.Text8(22), 'String', '-','Enable','off');
                set (Obj.Text8(23), 'String', '-','Enable','off');
                set (Obj.Text8(24), 'String', '-','Enable','off');
                set (Obj.Text8(25), 'String', '-','Enable','off');
                return;
            end
            
            j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
            for i=1:38
                aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                if aux ==1
                    Option =i;
                    break;
                end
                if i==38
                    Option=[];
                end
            end
            
            if Option==38
                set (Obj.Text8(14), 'String', num2str(round(Obj.ProfileArray(Obj.Aprofile).MSC.ParametersFinal(1,1))),'Enable','on');
                set (Obj.Text8(15), 'String', num2str(round(Obj.ProfileArray(Obj.Aprofile).MSC.UncFinal(1,1))),'Enable','on');
                set (Obj.Text8(18), 'String', num2str(Obj.ProfileArray(Obj.Aprofile).MSC.GodnessFit),'Enable','on');
                %Atualização do valor do grau do polinômio
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction==2
                    set (Obj.Text8(19), 'String', num2str(Obj.ProfileArray(Obj.Aprofile).MSC.FinalDegree),'Enable','on');
                else
                    set (Obj.Text8(19), 'String', '-','Enable','off');
                end
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                    set (Obj.Text8(22), 'String', num2str(round(Obj.ProfileArray(Obj.Aprofile).MSC.ParametersFinal2(1,1))),'Enable','on');
                    set (Obj.Text8(23), 'String', '-','Enable','on');
                    set (Obj.Text8(24), 'String', '-','Enable','on');
                    set (Obj.Text8(25), 'String', '-','Enable','off');
                end
            elseif Option==37
                set (Obj.Text8(14), 'String', num2str(round(Obj.ProfileArray(Obj.Aprofile).MSC.ParametersFinal1(1,1))),'Enable','on');
                set (Obj.Text8(15), 'String', '-','Enable','on');
                set (Obj.Text8(18), 'String', '-','Enable','on');
                set (Obj.Text8(19), 'String', '-','Enable','off');
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                    set (Obj.Text8(22), 'String', num2str(round(Obj.ProfileArray(Obj.Aprofile).MSC.ParametersFinal2(1,1))),'Enable','on');
                    set (Obj.Text8(23), 'String', '-','Enable','on');
                    set (Obj.Text8(24), 'String', '-','Enable','on');
                    set (Obj.Text8(25), 'String', '-','Enable','off');
                end
                
            else
                set (Obj.Text8(14), 'String', '-','Enable','off');
                set (Obj.Text8(15), 'String', '-','Enable','off');
                set (Obj.Text8(18), 'String', '-','Enable','off');
                set (Obj.Text8(19), 'String', '-','Enable','off');
                set (Obj.Text8(22), 'String', '-','Enable','off');
                set (Obj.Text8(23), 'String', '-','Enable','off');
                set (Obj.Text8(24), 'String', '-','Enable','off');
                set (Obj.Text8(25), 'String', '-','Enable','off');
                return;
            end
                    
            %Atualizaçao de valores do segundo ajuste
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2

            else
                set (Obj.Text8(22), 'String', '-','Enable','off');
                set (Obj.Text8(23), 'String', '-','Enable','off');
                set (Obj.Text8(24), 'String', '-','Enable','off');
                set (Obj.Text8(25), 'String', '-','Enable','off');
            end

            
        end
        
        function Obj = EnableAbaMSC (Obj)
            
            if Obj.nprofile==0
                Obj.EnablePanel81 ('off');
                Obj.EnablePanel82 ('off');
                Obj.EnablePanel83 ('off');
                Obj.EnablePanel84 ('off');
                Obj.RefreshValues ('off');
                return;
            end
                  
            if Obj.ProfileArray(Obj.Aprofile).DensityFlag==1
                Obj.EnablePanel81 ('on');
                Obj.EnablePanel82 ('on');
                Obj.EnablePanel83 ('on');
                Obj.EnablePanel84 ('on');
                Obj.RefreshValues ('on');
            else
                Obj.EnablePanel81 ('off');
                Obj.EnablePanel82 ('off');
                Obj.EnablePanel83 ('off');
                Obj.EnablePanel84 ('off');
                Obj.RefreshValues ('off');
            end
            
        end
        
        function Obj = EnablePanel81 (Obj, Enable)
            
            if strcmp(Enable, 'off') ==1
                for i=1:9
                    set(Obj.rbh8(i), 'Enable', Enable);
                end
                for i=1:5
                    set(Obj.Text8(i), 'Enable', Enable);
                end
                set(Obj.EditText8(1), 'Enable', Enable);
                set(Obj.EditText8(6), 'Enable','off');
            else
                for i=1:7
                    set(Obj.rbh8(i), 'Enable', 'on');
                end
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3
                    set(Obj.rbh8(3), 'Enable', 'on');
                    if Obj.ProfileArray(Obj.Aprofile).UncertaintyFlag==1
                        set(Obj.rbh8(9), 'Enable', 'on');
                        set(Obj.rbh8(8), 'Enable', 'on');
                    else
                        set(Obj.rbh8(9), 'Enable', 'off');
                        set(Obj.rbh8(8), 'Enable', 'on');
                    end
                else
                    set(Obj.rbh8(3), 'Enable', 'off');
                    set(Obj.rbh8(8), 'Enable', 'off');
                    set(Obj.rbh8(9), 'Enable', 'off');
                end
                for i=1:3
                    set(Obj.Text8(i), 'Enable', 'on');
                end
                set(Obj.Text8(5), 'Enable', 'on');
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==1
                    set(Obj.EditText8(1), 'Enable', 'on');
                    set (Obj.Text8(4), 'Enable', 'on');
                else
                    set(Obj.EditText8(1), 'Enable', 'off');
                    set (Obj.Text8(4), 'Enable', 'off');
                end
                if isempty (Obj.ProfileArray(Obj.Aprofile).MSC.MSCIniFlag)==1
                    set(Obj.rbh8(3), 'Enable', 'off');
                end
                
            end
        end
        
        function Obj = EnablePanel82 (Obj, Enable)
            
            if Obj.nprofile==0
                for i=2:4
                    set(Obj.EditText8(i), 'Enable', 'off', 'String','');
                end
                for i=6:10
                    set(Obj.Text8(i), 'Enable', 'off');
                end 
                return;
            end
            
            if strcmp(Enable, 'off')
                for i=2:4
                    set(Obj.EditText8(i), 'Enable', Enable);
                end
                for i=6:10
                    set(Obj.Text8(i), 'Enable', Enable);
                end
            else
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                    set(Obj.Text8(6), 'Enable', 'on');
                    set(Obj.Text8(7), 'Enable', 'on');
                    set(Obj.Text8(8), 'Enable', 'on');
                    set(Obj.Text8(9), 'Enable', 'off');
                    set(Obj.Text8(10), 'Enable', 'off');
                    set(Obj.EditText8(2), 'Enable', 'on');
                    set(Obj.EditText8(3), 'Enable', 'on');
                    set(Obj.EditText8(4), 'Enable', 'off');
                elseif Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                    for i=2:4
                        set(Obj.EditText8(i), 'Enable', Enable);
                    end
                    for i=6:10
                        set(Obj.Text8(i), 'Enable', Enable);
                    end    
                else
                    Obj.EnablePanel82('off');
                end
            end
            
        end
        
        function Obj = EnablePanel83 (Obj, Enable)
            
            if strcmp(Enable, 'off')
                set(Obj.Popup8(1), 'Enable', Enable);
            else
                if Obj.ProfileArray(Obj.Aprofile).MSCFlag==1
                    Obj.RefreshPopup8 (1);
                else
                    set(Obj.Popup8(1), 'Enable', 'off');
                end
            end
        end
                
        function Obj = EnablePanel84 (Obj, Enable)
            
            if strcmp(Enable, 'off') ==1
                for i=12:25
                    set(Obj.Text8(i), 'Enable', Enable);
                end
            else
                if Obj.ProfileArray(Obj.Aprofile).MSCFlag==1
                    for i=12:20
                        set(Obj.Text8(i), 'Enable', Enable);
                    end
                    if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                        for i=21:25
                            set(Obj.Text8(i), 'Enable', Enable);
                        end
                    end
                else
                    Obj.EnablePanel84 ('off');
                end
            end
        end
        
        function Obj = RefreshValues (Obj, Enable)
            
            %Atualiza valores se nao existir profile
            if Obj.nprofile==0
                for i=1:9
                    set(Obj.rbh8(i), 'Value', 0);
                end
                set(Obj.EditText8(1), 'Enable', 'off','String','');
                set(Obj.EditText8(6), 'Enable', 'off','String','');
                Obj.RefreshPopup8(1);
                Obj.ActualizePanel4;
                set(Obj.Button8(1), 'Enable', 'off');
                return;
            end
                       
            %Atualiza o botao apply
            if strcmp(Enable, 'off')==1
                for i=1:9
                    set(Obj.rbh8(i), 'Value', 0);
                end
                set(Obj.EditText8(1), 'String','');
                set(Obj.EditText8(6), 'String','');
                set(Obj.EditText8(2), 'String','');
                set(Obj.EditText8(3), 'String','');
                set(Obj.EditText8(4), 'String','');
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens=[];
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens=[];
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2=[];
                Obj.RefreshPopup8(1);
                Obj.ActualizePanel4;
                set(Obj.Button8(1), 'Enable', 'off');
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=[];
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod=[];
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages=[];
                Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction=[];
            else
                Obj.VerifyButton;
            end
            
            %Atualiza os valores do panel4
            Obj.ActualizePanel4;
                
            %Atualiza o Popup
            Obj.RefreshPopup8(1);
            
            %Atualiza os valores dos EditText e dos radio buttons do grau do polinômio
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction == 1
                set(Obj.rbh8(1), 'Value', 1);
                set(Obj.rbh8(2), 'Value', 0);
                set(Obj.EditText8(6), 'Enable', 'off','String','');
            elseif Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction == 2
                set(Obj.rbh8(1), 'Value', 0);
                set(Obj.rbh8(2), 'Value', 1);
                set(Obj.EditText8(6), 'Enable', 'on','String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau));
            else
                set(Obj.rbh8(1), 'Value', 0);
                set(Obj.rbh8(2), 'Value', 0);
                set(Obj.EditText8(6), 'Enable', 'off','String','');
            end
            
            %Atualiza os valores dos radios buttons da opçao de estágios
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                set(Obj.rbh8(4), 'Value', 1);
                set(Obj.rbh8(5), 'Value', 0);
                set(Obj.EditText8(4),'String','','Enable','off');
                set(Obj.EditText8(2),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens),'Enable','on');
                set(Obj.EditText8(3),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens),'Enable','on');
            elseif Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                set(Obj.rbh8(4), 'Value', 0);
                set(Obj.rbh8(5), 'Value', 1);
                set(Obj.EditText8(2),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.MSCInitDens),'Enable','on');
                set(Obj.EditText8(3),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens),'Enable','on');
                set(Obj.EditText8(4),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.MSCFinalDens2),'Enable','on');
            else
                set(Obj.rbh8(4), 'Value', 0);
                set(Obj.rbh8(5), 'Value', 0);
                set(Obj.EditText8(4),'String','','Enable','off');
                set(Obj.EditText8(3),'String','','Enable','off');
                set(Obj.EditText8(2),'String','','Enable','off');
             end
            
            %Atualiza os valores dos radios buttons da opçao de metodo de ajuste
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting)==1
                set(Obj.rbh8(6), 'Value', 0);
                set(Obj.rbh8(7), 'Value', 0);
                set(Obj.rbh8(3), 'Value', 0);
                set(Obj.EditText8(1), 'Enable', 'off','String','');
            else
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==1
                    set(Obj.rbh8(6), 'Value', 1);
                    set(Obj.rbh8(7), 'Value', 0);
                    set(Obj.rbh8(3), 'Value', 0);
                    set(Obj.EditText8(1), 'Enable', 'on','String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.SelectionQ));
                elseif Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==2
                    set(Obj.rbh8(6), 'Value', 0);
                    set(Obj.rbh8(7), 'Value', 1);
                    set(Obj.rbh8(3), 'Value', 0);
                    set(Obj.EditText8(1), 'Enable', 'off','String','');
                else
                    set(Obj.rbh8(6), 'Value', 0);
                    set(Obj.rbh8(7), 'Value', 0);
                    set(Obj.rbh8(3), 'Value', 1);
                    set(Obj.EditText8(1), 'Enable', 'off','String','');
                end
            end
            
            %Atualiza os valores dos radios buttons associados ao tipo de ajuste
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod)==1
                set(Obj.rbh8(8), 'Value', 0);
                set(Obj.rbh8(9), 'Value', 0);
            else
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod==1
                    set(Obj.rbh8(8), 'Value', 1);
                    set(Obj.rbh8(9), 'Value', 0);
                else
                    set(Obj.rbh8(8), 'Value', 0);
                    set(Obj.rbh8(9), 'Value', 1);
                end
            end
            
        end  
        
        function Obj = RefreshPopup8 (Obj, Option)
            if Obj.nprofile==0
                return;
            else
                if Obj.ProfileArray(Obj.Aprofile).MSCFlag~=1
                    Data = 'Select Data';
                    set(Obj.Popup8(1), 'Value',1,'String', Data);
                    return;
                end
                
                if Option==33
                    Data= 'Select Data';
                    aux = num2str(Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning(:,1));
                    Data={Data;aux};
                elseif Option==35
                    Data= 'Select Data';
                    aux = num2str(Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning2(:,1));
                    Data={Data;aux};
                else
                    Data = 'Select Data';
                    set(Obj.Popup8(1), 'Value',1,'String', Data,'Enable','off');
                    return;
                end
                set(Obj.Popup8(1),'String', Data);
                set (Obj.Popup8(1),'Value', Obj.ProfileArray(Obj.Aprofile).Popup8Choice);
        
                
            end
        end
        
        function Obj = VerifyButton (Obj)
            
            aux = isempty(Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting);
            aux = aux+ isempty(Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction);
            aux = aux + isempty(Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages);
            
            if aux==0
                set(Obj.Button8(1), 'Enable', 'on');
            else
                set(Obj.Button8(1), 'Enable', 'off');
                return;
            end
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==3
                aux = aux + isempty(Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod);
                if aux>0
                    set(Obj.Button8(1), 'Enable', 'off');
                    return;
                end
            end
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting==1
                if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.SelectionQ)==1
                    set(Obj.Button8(1), 'Enable', 'off');
                    return;
                end
            end
            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction==2
                if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.PolyGrau)==1
                   set(Obj.Button8(1), 'Enable', 'off');
                return;
                end
            end

        end
        
        function Obj = ResetAbaMSC (Obj)
            Obj.ProfileArray(Obj.Aprofile).MSC.MSCIniFlag=[];
            Obj.ProfileArray(Obj.Aprofile).MSCFlag=0;
            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFitting=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.MSCMethod=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction=[];
            Obj.EnablePanel81 ('off');
            Obj.EnablePanel82 ('off');
            Obj.EnablePanel83 ('off');
            Obj.EnablePanel84 ('off');
            Obj.RefreshValues ('off');
            
        end
                            
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%Funções que criam os componentes da aba Export%%%%%%%%%
        
        function Obj = AbaAnalysisComp (Obj)
            
            %Fundos
            Obj.FundoAnl1 = uiextras.VBox('Parent', Obj.AbaAnalysis);
            
            %Panels Esquerdo
            Obj.FundoAnl2 = ViewConstructor.Fundo(Obj.FundoAnl1);
            Obj.Panel9(2) = ViewConstructor.Panel(Obj.FundoAnl1,'Density Prevision');
            Obj.FundoAnl3 = ViewConstructor.Fundo(Obj.FundoAnl1);
            
            
            %Criação dos objetos do FundoAnl2
            Obj.rbh9(1) = ViewConstructor.RadioButton (Obj.FundoAnl2, 'One Step', [0.12 0.4 0.5 0.2], {@AnalysisSelectFunc,8});
            Obj.rbh9(2) = ViewConstructor.RadioButton (Obj.FundoAnl2, 'Two Step', [0.12 0.2 0.6 0.2], {@AnalysisSelectFunc,9});
            Obj.Text9(9) = ViewConstructor.Text (Obj.FundoAnl2, [0.05 0.7 0.22 0.14], 'Sintering Method');
            Obj.rbh9(3) = ViewConstructor.RadioButton (Obj.FundoAnl2, 'Single', [0.42 0.4 0.5 0.2], {@AnalysisSelectFunc,10});
            Obj.rbh9(4) = ViewConstructor.RadioButton (Obj.FundoAnl2, 'Double', [0.42 0.2 0.6 0.2], {@AnalysisSelectFunc,11});
            Obj.Text9(10) = ViewConstructor.Text (Obj.FundoAnl2, [0.35 0.7 0.22 0.14], 'Activation Energy'); 
            Obj.Text9(11) = ViewConstructor.Text (Obj.FundoAnl2, [0.71 0.7 0.22 0.14], 'Sintering Map'); 
            Obj.Button9(2) = ViewConstructor.Button(Obj.FundoAnl2,'First Stage',[0.72 0.37 0.2 0.25],{@AnalysisSelectFunc, 12});
            Obj.Button9(3) = ViewConstructor.Button(Obj.FundoAnl2,'Second Stage',[0.72 0.05 0.2 0.25],{@AnalysisSelectFunc, 13});
            
            %Criação dos objetos do Panel1
            Obj.Text9(7) = ViewConstructor.Text (Obj.Panel9(2), [0.25 0.82 0.22 0.12], 'Final Density:');
            Obj.Text9(1) = ViewConstructor.Text (Obj.Panel9(2), [0.02 0.5 0.22 0.14], 'Heating Rate 1:');
            Obj.Text9(4) = ViewConstructor.Text (Obj.Panel9(2), [0.52 0.5 0.22 0.14], 'Heating Rate 2:');
            Obj.Text9(2) = ViewConstructor.Text (Obj.Panel9(2), [0.02 0.3 0.22 0.14], 'Dwell Temperature 1:');
            Obj.Text9(5) = ViewConstructor.Text (Obj.Panel9(2), [0.52 0.3 0.22 0.14], 'Dwell Temperature 2:');
            Obj.Text9(3) = ViewConstructor.Text (Obj.Panel9(2), [0.02 0.1 0.22 0.14], 'Dwell Time 1:');
            Obj.Text9(6) = ViewConstructor.Text (Obj.Panel9(2), [0.52 0.1 0.22 0.14], 'Dwell Time 2:');
            Obj.Text9(8) = ViewConstructor.Text (Obj.Panel9(2), [0.48 0.82 0.22 0.14], ' - ');
            Obj.Text9(16) = ViewConstructor.Text (Obj.Panel9(2), [0.25 0.70 0.22 0.12], 'log10 Teta');
            Obj.Text9(17) = ViewConstructor.Text (Obj.Panel9(2), [0.48 0.70 0.22 0.14], ' - ');
            Obj.EditText9(1) = ViewConstructor.EditText(Obj.Panel9(2), [0.28 0.51 0.2 0.15], {@AnalysisSelectFunc,1}); 
            Obj.EditText9(4) = ViewConstructor.EditText(Obj.Panel9(2), [0.78 0.51 0.2 0.15], {@AnalysisSelectFunc,4}); 
            Obj.EditText9(2) = ViewConstructor.EditText(Obj.Panel9(2), [0.28 0.31 0.2 0.15], {@AnalysisSelectFunc,2}); 
            Obj.EditText9(5) = ViewConstructor.EditText(Obj.Panel9(2), [0.78 0.31 0.2 0.15], {@AnalysisSelectFunc,5}); 
            Obj.EditText9(3) = ViewConstructor.EditText(Obj.Panel9(2), [0.28 0.11 0.2 0.15], {@AnalysisSelectFunc,3}); 
            Obj.EditText9(6) = ViewConstructor.EditText(Obj.Panel9(2), [0.78 0.11 0.2 0.15], {@AnalysisSelectFunc,6});
            Obj.Button9(1) = ViewConstructor.Button(Obj.Panel9(2),'Calculate',[0.78 0.82 0.2 0.18],{@AnalysisSelectFunc, 7});

            %Criação dos objetos do FundoAnl3
            Obj.Text9(12) = ViewConstructor.Text (Obj.FundoAnl3, [0.001 0.9 0.4 0.18], 'Units');
            Obj.Text9(13) = ViewConstructor.Text (Obj.FundoAnl3, [0.001 0.65 0.4 0.18], '* Heating rate - oC/min');
            Obj.Text9(14) = ViewConstructor.Text (Obj.FundoAnl3, [0.001 0.4 0.4 0.18], '* Dwell Temperature - oC');
            Obj.Text9(15) = ViewConstructor.Text (Obj.FundoAnl3, [0.001 0.15 0.4 0.18], '* Dwell Time - hour');
            
            %Configura a aba
            set( Obj.FundoAnl1, 'Sizes', [-1 200 70 ], 'Spacing', 5 ); 
            Obj.EnableAbaAnalysis;
            
            function AnalysisSelectFunc(hObject,~, whichHandle)
                    switch whichHandle
                            
                        case 1
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            aux=str2double(get(hObject, 'String'));
                            if aux <0.1 || aux>400
                                set(hObject,'string','');
                                errordlg('Please enter with a value between 0.1 and 200','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.HR12= str2double(get(hObject, 'String'));
                            
                        case 2
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            aux=str2double(get(hObject, 'String'));
                            if aux <100 || aux>2000
                                set(hObject,'string','');
                                errordlg('Please enter with a value between 100 and 2000','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.DTemp12= str2double(get(hObject, 'String'));
                            
                        case 3
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.DTime12= str2double(get(hObject, 'String'));
                        
                        case 4
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            aux=str2double(get(hObject, 'String'));
                            if aux <0.1 || aux>400
                                set(hObject,'string','');
                                errordlg('Please enter with a value between 0.1 and 200','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.HR22= str2double(get(hObject, 'String'));
                            
                        case 5
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            aux=str2double(get(hObject, 'String'));
                            if aux <100 || aux>2000
                                set(hObject,'string','');
                                errordlg('Please enter with a value between 100 and 2000','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.DTemp22= str2double(get(hObject, 'String'));
                            
                        case 6
                            str=get(hObject,'String');
                            if isnan(str2double(str)); 
                                set(hObject,'string','');
                                errordlg('Please enter with a numeric value','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.DTime22= str2double(get(hObject, 'String'));
                            
                            
                        case 7
                            aux1=isempty(Obj.ProfileArray(Obj.Aprofile).MSC.HR12);
                            aux2=isempty(Obj.ProfileArray(Obj.Aprofile).MSC.HR22);
                            aux3=isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTemp12);
                            aux4=isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTemp22);
                            aux5=isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTime12);
                            aux6=isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTime22);
                            if Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod==1
                                total=aux1+aux3+aux5;
                            else
                                total=aux1+aux2+aux3+aux4+aux5+aux6;
                            end
                            if total >1
                                errordlg('Please enter with the input data','Warning','modal');
                                uicontrol(hObject);
                                return;
                            else
                                Obj.ProfileArray(Obj.Aprofile).MSC.ApplyAnalysis2;
                                set (Obj.Text9(8), 'String', num2str(Obj.ProfileArray(Obj.Aprofile).MSC.Dens2),'Enable','on','ForegroundColor','r');
                                set(Obj.Text9(17),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.Tetaol),'Enable','on','ForegroundColor','r');
                                Obj.ProfileArray(Obj.Aprofile).AnalysisFlag=1;
                            end
                            
                        case 8
                            Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod=1;
                            Obj.RefreshPanels;
                            set(Obj.rbh9(2),'Value',0);
                            set(Obj.rbh9(1),'Value',1);
                            set(Obj.rbh9(4),'Value',0,'Enable','off');
                            set(Obj.rbh9(3),'Value',1);
                            Obj.ProfileArray(Obj.Aprofile).MSC.Qanalysis=1;
                            set(Obj.Button9(3),'Enable','off');
                            
                        case 9
                            Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod=2;
                            Obj.RefreshPanels;
                            set(Obj.rbh9(2),'Value',1);
                            set(Obj.rbh9(1),'Value',0);
                            set(Obj.rbh9(4),'Enable','on');
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction==1
                                set(Obj.Button9(3),'Enable','on');
                            end
                            
                        case 10
                            Obj.ProfileArray(Obj.Aprofile).MSC.Qanalysis=1;
                            set(Obj.rbh9(4),'Value',0);
                            set(Obj.rbh9(3),'Value',1);
                            
                        case 11
                            Obj.ProfileArray(Obj.Aprofile).MSC.Qanalysis=2;
                            set(Obj.rbh9(4),'Value',1);
                            set(Obj.rbh9(3),'Value',0);
                            
                        case 12
                            Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMap1;
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(39)=1;
                            %Atualização do list box de controle dos gráficos
                            Obj.RefreshListBox;
                            set (Obj.ListBox6, 'Value', Obj.Listsize);
                            aux1 = Obj.Listsize;
                            aux2 = get (Obj.ListBox6, 'String');
                            aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                            Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                            Obj.GraphData;
                            
                        case 13
                            if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages~=2 
                                errordlg('Function acessible just for two stages MSC','Warning','modal');
                                uicontrol(hObject);
                                return;
                            end
                            Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMap2;
                            Obj.ProfileArray(Obj.Aprofile).GraphFlag(40)=1;
                            %Atualização do list box de controle dos gráficos
                            Obj.RefreshListBox;
                            set (Obj.ListBox6, 'Value', Obj.Listsize);
                            aux1 = Obj.Listsize;
                            aux2 = get (Obj.ListBox6, 'String');
                            aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                            Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                            Obj.GraphData;
                                                        
                    end
            end
            
            
        end
        
        function Obj = EnableAbaAnalysis (Obj)
           
            if Obj.nprofile==0 || Obj.ProfileArray(Obj.Aprofile).MSCFlag==0
                for i=1:6
                    set(Obj.EditText9(i),'Enable','off','String','');
                end
                for i=1:17
                    set(Obj.Text9(i),'Enable','off');
                end
                for i=1:3
                    set(Obj.Button9(i),'Enable','off');
                end
                for i=1:4
                    set(Obj.rbh9(i),'Enable','off','Value',0);
                end
                return;
            end
            
            if Obj.ProfileArray(Obj.Aprofile).MSCFlag==1 && Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1 
                set(Obj.rbh9(1),'Enable','on','Value',0);
                set(Obj.rbh9(2),'Enable','on','Value',0);
                set(Obj.Text9(9),'Enable','on');
                set(Obj.rbh9(3),'Enable','on','Value',0);
                set(Obj.Text9(10),'Enable','on');
                set(Obj.Text9(11),'Enable','on');
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction==1
                    set(Obj.Button9(2),'Enable','on');
                else
                    set(Obj.Button9(2),'Enable','off');
                end
                set(Obj.Text9(12),'Enable','on');
                set(Obj.Text9(13),'Enable','on');
                set(Obj.Text9(14),'Enable','on');
                set(Obj.Text9(15),'Enable','on');
            elseif Obj.ProfileArray(Obj.Aprofile).MSCFlag==1 && Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==2
                set(Obj.rbh9(1),'Enable','on','Value',0);
                set(Obj.rbh9(2),'Enable','on','Value',0);
                set(Obj.Text9(9),'Enable','on');
                set(Obj.rbh9(3),'Enable','on','Value',0);
                set(Obj.Text9(10),'Enable','on');
                set(Obj.Text9(11),'Enable','on');
                if Obj.ProfileArray(Obj.Aprofile).MSC.MSCFunction==1
                    set(Obj.Button9(2),'Enable','on');
                else
                    set(Obj.Button9(2),'Enable','off');
                end
                set(Obj.Text9(12),'Enable','on');
                set(Obj.Text9(13),'Enable','on');
                set(Obj.Text9(14),'Enable','on');
                set(Obj.Text9(15),'Enable','on');
            else
                for i=1:6
                    set(Obj.EditText9(i),'Enable','off','String','');
                end
                for i=1:15
                    set(Obj.Text9(i),'Enable','off');
                end
                for i=1:3
                    set(Obj.Button9(i),'Enable','off');
                end
                for i=1:4
                    set(Obj.rbh9(4),'Enable','off','Value',0);
                end
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod)==1
                set(Obj.rbh9(4),'Enable','off','Value',0);
                set(Obj.Button9(3),'Enable','off');
                return;
            elseif Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod==1
                set(Obj.rbh9(4),'Enable','off','Value',0);
                set(Obj.Button9(3),'Enable','off');
            else
                set(Obj.rbh9(4),'Enable','on','Value',0);
                set(Obj.Button9(3),'Enable','on');
            end

               
        end
        
        function Obj = RefreshPanels (Obj)
           
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod)==1
                for i=1:6
                    set(Obj.EditText9(i),'Enable','off','String','');
                    set(Obj.Text9(i),'Enable','off');
                end
                set(Obj.Text9(7),'Enable','off');
                set(Obj.Text9(8),'Enable','off','String','');
                set(Obj.Text9(16),'Enable','off');
                set(Obj.Text9(17),'Enable','off','String','');
                set (Obj.Button9(3),'Enable','off');
                set(Obj.rbh9(1),'Value',0);
                set(Obj.rbh9(2),'Value',0);
                set(Obj.rbh9(3),'Value',0);
                set(Obj.rbh9(4),'Enable','off','Value',0);
            else
                Obj.RefreshValues9;
                for i=1:3
                    set(Obj.EditText9(i),'Enable','on');
                    set(Obj.Text9(i),'Enable','on');
                end
                set (Obj.Button9(1),'Enable','on');
                for i=4:6
                    set(Obj.EditText9(i),'Enable','off');
                    set(Obj.Text9(i),'Enable','off');
                end
                set(Obj.Text9(7),'Enable','on');
                set(Obj.Text9(16),'Enable','on');

                    
                if Obj.ProfileArray(Obj.Aprofile).AnalysisFlag==1
                    set(Obj.Text9(8),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.Dens2),'Enable','on','ForegroundColor','r');
                    set(Obj.Text9(17),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.Tetaol),'Enable','on','ForegroundColor','r');
                else
                    set(Obj.Text9(8),'Enable','off', 'String',' ');
                    set(Obj.Text9(17),'Enable','off', 'String',' ');
                end
                if Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod==2
                    for i=4:6
                        set(Obj.EditText9(i),'Enable','on');
                        set(Obj.Text9(i),'Enable','on');
                    end
                end
            end
        end
        
        function Obj = RefreshAbaAnalysis (Obj)
           
            Obj.EnableAbaAnalysis;
            Obj.RefreshPanels;
            
        end
        
        function Obj = RefreshValues9 (Obj)
            
            if Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod==1
                set(Obj.rbh9(1),'Enable','on','Value',1);
                set(Obj.rbh9(2),'Enable','on','Value',0);
            elseif Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod==2
                set(Obj.rbh9(1),'Enable','on','Value',0);
                set(Obj.rbh9(2),'Enable','on','Value',1);
            else
                set(Obj.rbh9(1),'Enable','on','Value',0);
                set(Obj.rbh9(2),'Enable','on','Value',0);
            end
            
            if Obj.ProfileArray(Obj.Aprofile).MSC.Qanalysis==1
                set(Obj.rbh9(3),'Value',1);
                set(Obj.rbh9(4),'Value',0);
            elseif Obj.ProfileArray(Obj.Aprofile).MSC.Qanalysis==2
                set(Obj.rbh9(3),'Value',0);
                set(Obj.rbh9(4),'Value',1);
            else
                set(Obj.rbh9(3),'Value',0);
                set(Obj.rbh9(4),'Value',0);
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.HR12)==1
                set(Obj.EditText9(1),'String','');
            else
                set(Obj.EditText9(1),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.HR12));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTemp12)==1
                set(Obj.EditText9(2),'String','');
            else
                set(Obj.EditText9(2),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.DTemp12));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTime12)==1
                set(Obj.EditText9(3),'String','');
            else
                set(Obj.EditText9(3),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.DTime12));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.HR22)==1
                set(Obj.EditText9(4),'String','');
            else
                set(Obj.EditText9(4),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.HR22));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTemp22)==1
                set(Obj.EditText9(5),'String','');
            else
                set(Obj.EditText9(5),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.DTemp22));
            end
            
            if isempty(Obj.ProfileArray(Obj.Aprofile).MSC.DTime22)==1
                set(Obj.EditText9(6),'String','');
            else
                set(Obj.EditText9(6),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.DTime22));
            end
            
            if Obj.ProfileArray(Obj.Aprofile).AnalysisFlag==1
                set(Obj.Text9(8),'String',num2str(Obj.ProfileArray(Obj.Aprofile).MSC.Dens2),'Enable','on','ForegroundColor','r');
            else
                set(Obj.Text9(8),'Enable','off','String', '');
            end
                    
        end
        
        function Obj = ResetAbaAnalysis (Obj)
           
            Obj.ProfileArray(Obj.Aprofile).MSC.SinteringMethod=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.Qanalysis=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.HR12=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.HR22=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.DTemp12=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.DTemp22=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.DTime12=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.DTime22=[];
            Obj.ProfileArray(Obj.Aprofile).MSC.Dens2=[];
            Obj.EnableAbaAnalysis;
            Obj.RefreshPanels;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%Funções que criam os controles dos axes%%%%%%%%%%%%%%%
        
        function Obj = GraphControl (Obj)
           
            %Divisão vertical em três partes
            Obj.Cabecalho = ViewConstructor.Fundo (Obj.DireitoInf);
            Obj.Espaco = uiextras.HBox ('Parent',Obj.DireitoInf);
            Obj.Cabecalho2 = ViewConstructor.Fundo (Obj.DireitoInf);
            set( Obj.DireitoInf, 'Sizes', [15 -5 -1], 'Spacing', 1 );
            
            %Divisão horizontal da parte contendo as opções
            Obj.Margem1 = uiextras.VBox('Parent', Obj.Espaco);
            Obj.FundoEsqGraph = uiextras.VBox('Parent', Obj.Espaco);
            Obj.Margem2 = uiextras.VBox('Parent', Obj.Espaco);
            Obj.FundoDirGraph= uiextras.VBox('Parent', Obj.Espaco);
            Obj.Margem3 = uiextras.VBox('Parent', Obj.Espaco);
            set (Obj.Espaco, 'Sizes', [ -1 -5 -1 -10 -1]);
            
            %Criação dos panel
            Obj.Panel6(1)=ViewConstructor.Panel(Obj.FundoEsqGraph,'Options');
            Obj.Panel6(2)=ViewConstructor.Panel(Obj.FundoDirGraph,'Select Data');
            
            %Componentes do panel1
            Obj.Text6(1) = ViewConstructor.Text (Obj.Panel6(1), [0.05 0.6 0.45 0.25], 'Number of graphs:');
            Obj.Text6(2) = ViewConstructor.Text (Obj.Panel6(1), [0.1 0.25 0.45 0.25], 'Actual graph:');
            Obj.Popup6(1) = ViewConstructor.Popupmenu (Obj.Panel6(1), [0.55 0.75 0.25 0.13] ,{'1' '2' '4'},{@GraphPanelCall,1});
            Obj.Popup6(2) = ViewConstructor.Popupmenu (Obj.Panel6(1), [0.55 0.4 0.25 0.13] ,'1',{@GraphPanelCall,2});
            
            %Componentes do panel2
            Obj.ListBox6 = ViewConstructor.Listbox (Obj.Panel6(2), [0.01 0.02 0.8 0.95], 'Select Data',{@GraphPanelCall,3});
            Obj.Text6(3) = ViewConstructor.Text (Obj.Panel6(2), [0.82 0.7 0.15 0.25], 'Export Data');
            Obj.Button6 = ViewConstructor.Button(Obj.Panel6(2),'Export',[0.82 0.3 0.15 0.30], {@GraphPanelCall,4});
            Obj.CreateOptions;
            set (Obj.Popup6(1), 'Enable', 'off');
            set (Obj.Popup6(2), 'Enable', 'off');
            
            
                %%%%%%%%%%%%% Fazer os callbacks dos panels %%%%%%%%%%%%%%%%%%%%
                function GraphPanelCall(~,~, whichHandle)
                switch whichHandle
                    case 1 % Determina quantidade de subplots
                        Obj.ProfileArray(Obj.Aprofile).NGraph = get(Obj.Popup6(1),'Value');
                        if Obj.ProfileArray(Obj.Aprofile).NGraph ==1
                            set (Obj.Popup6(2), 'String', '1');
                            aux = get(Obj.Popup6(2),'Value');
                            if aux >1
                                set (Obj.Popup6(2),'Value',1);
                                Obj.ProfileArray(Obj.Aprofile).SelectedGraph = get(Obj.Popup6(2),'Value');
                            end
                        elseif Obj.ProfileArray(Obj.Aprofile).NGraph ==2
                            set (Obj.Popup6(2), 'String', {'1' '2'});
                            aux = get(Obj.Popup6(2),'Value');
                            if aux >2
                                set (Obj.Popup6(2),'Value',2);
                                Obj.ProfileArray(Obj.Aprofile).SelectedGraph = get(Obj.Popup6(2),'Value');
                            end
                        else 
                            set (Obj.Popup6(2), 'String', {'1' '2' '3' '4'});
                        end
                        
                        Obj.MakeSubplot;
                        
                        
                    case 2 % Seleciona o gráfico que será modificado
                        Obj.ProfileArray(Obj.Aprofile).SelectedGraph = get(Obj.Popup6(2),'Value');
                        Obj.MakeSubplot;
                        
                    case 3 %Verifica a opção selecionada pelo usuário
                        aux1 = get (Obj.ListBox6, 'Value');
                        aux2 = get (Obj.ListBox6, 'String');
                        aux3= Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                        Obj.ProfileArray(Obj.Aprofile).GraphChoose{aux3} = aux2(aux1);
                        Obj.ProfileArray(Obj.Aprofile).ListBox6Choice=get(Obj.ListBox6,'Value');
                        Obj.GraphData;
                        
                    case 4
                        j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
                        for i=1:40
                            aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                            if aux ==1
                                Option =i;
                                break;
                            end
                            if i==40
                                Option=[];
                            end
                        end
                        aux = isempty(Option);
                        
                        if aux==1
                            errordlg('No data Selected','Warning','modal');
                            uicontrol(hObject);    
                            return;
                        else
                            if Option >10 && Option <19
                                Obj.ExportSmoothGraph (Option);
                            elseif Option ==33 || Option==35
                                Obj.ExportResidualGraphs (Option);
                            else
                                Obj.ExportData (Option);
                            end
                        end

                end
            end
                        
        end
        
        function Obj = CreateOptions (Obj)
        
            Obj.GraphText{1}= 'DL vs time';
            Obj.GraphText{2}= 'DL vs Temperature';
            Obj.GraphText{3}= 'DL/L0 vs time';
            Obj.GraphText{4}= 'DL/L0 vs Temperature';
            Obj.GraphText{5}= 'Density vs time';
            Obj.GraphText{6}= 'Density vs Temperature';
            Obj.GraphText{7}= 'Densification vs time';
            Obj.GraphText{8}= 'Densification vs Temperature';
            Obj.GraphText{9}= 'DL/L vs time';
            Obj.GraphText{10}= 'DL/L vs Temperature';
            Obj.GraphText{11}= 'Strain Time Derivate';
            Obj.GraphText{12}= 'Strain Temperature Derivate';
            Obj.GraphText{13}= 'Density Time Derivate';
            Obj.GraphText{14}= 'Density Temperature Derivate';
            Obj.GraphText{15}= 'Densification Time Derivate';
            Obj.GraphText{16}= 'Densification Temperature Derivate';
            Obj.GraphText{17}= 'DL/L Time Derivate';
            Obj.GraphText{18}= 'DL/L Temperature Derivate';
            Obj.GraphText{19}= 'Absolute Unc: Strain';
            Obj.GraphText{20}= 'Absolute Unc: Densities';
            Obj.GraphText{21}= 'Absolute Unc: Densification';
            Obj.GraphText{22}= 'Absolute Unc:  DL/L';
            Obj.GraphText{23}= 'Absolute Unc: Strain Time Derivate';
            Obj.GraphText{24}= 'Absolute Unc: Strain Temperature Derivate';
            Obj.GraphText{25}= 'Absolute Unc: Density Time Derivate';
            Obj.GraphText{26}= 'Absolute Unc: Density Temperature Derivate';
            Obj.GraphText{27}= 'Absolute Unc: Densification Time Derivate';
            Obj.GraphText{28}= 'Absolute Unc: Densification Temperature Derivate';
            Obj.GraphText{29}= 'Absolute Unc: DL/L Time Derivate';
            Obj.GraphText{30}= 'Absolute Unc: DL/L Temperature Derivate';
            Obj.GraphText{31}= 'Arhenius Fitting Graph';
            Obj.GraphText{32}= 'Arrhenius Results';
            Obj.GraphText{33}= 'MSC: Residual Graphs';
            Obj.GraphText{34}= 'MSC: Residual quadratic total vs Q';
            Obj.GraphText{35}= 'MSC: Residual Graphs (Second stage)';
            Obj.GraphText{36}= 'MSC: Residual quadratic total vs Q (Second Stage))';
            Obj.GraphText{37}= 'MSC: Master Sintering Curve (Scanning)';
            Obj.GraphText{38}= 'MSC: Master Sintering Curve (Selected/NLLS)';
            Obj.GraphText{39}= 'Sintering Map';
            Obj.GraphText{40}= 'Sintering Map (Second Stage)';
            
            
        end
        
        function Obj = RefreshListBox (Obj)
        
            Obj.ListGraphBox=[];
            Obj.ListGraphBox{1}='Select Data';
            Obj.Listsize=1;
            for i=1:40
                if Obj.ProfileArray(Obj.Aprofile).GraphFlag(i)==1
                    Obj.Listsize=Obj.Listsize+1;
                    Obj.ListGraphBox{Obj.Listsize} = Obj.GraphText{i};
                end
            end
            set (Obj.ListBox6, 'Value', 1, 'String', Obj.ListGraphBox);
        end
        
        function Obj = GraphData (Obj)
        
            j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
            for i=1:40
                aux = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, Obj.GraphText{i});
                if aux ==1
                    Option =i;
                    break;
                end
                if i==40
                    Option=[];
                end
            end
            aux = isempty(Option);
            if aux==0
                if Option >10 && Option <19
                    Obj.EnablePanel35('on');
                    Obj.SmoothGraph (Option);
                    Obj.RefreshPopup8 (Option);
                    Obj.RefreshListBoxChoice (Option);
                    Obj.ActualizePanel4;
                elseif Option ==33 || Option==35
                    Obj.RefreshPopup8 (Option);
                    Obj.ResidualGraphs (Option);
                    Obj.EnablePanel35('off');
                    Obj.RefreshListBoxChoice (Option);
                    Obj.ActualizePanel4;
                elseif Option ==37 || Option ==38
                    Obj.ActualizePanel4;
                    Obj.EnablePanel35('off');
                    Obj.PlotData (Option);
                    Obj.RefreshPopup8 (Option);
                else
                    Obj.EnablePanel35('off');
                    Obj.PlotData (Option);
                    Obj.RefreshPopup8 (Option);
                    Obj.ActualizePanel4;
                end
            else
                cla('reset');
            end
        
        end
        
        function Obj = RefreshListBox2 (Obj)
        
            j=Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
            aux = get (Obj.ListBox6, 'String');
            aux2=size(aux);
            for i=1:aux2
                aux3 = strcmp (Obj.ProfileArray(Obj.Aprofile).GraphChoose{j}, aux{i});
                if aux3 ==1
                    Option =i;
                    break;
                end
                if i==38
                    Option=[];
                end
            end
            Obj.RefreshListBox;
            if isempty(Option) ==0
                set(Obj.ListBox6, 'Value', Option);
            else
                set(Obj.ListBox6, 'Value', 1);
            end
            
        end
        
        function Obj = RefreshListBoxChoice (Obj, Option)
           
            set(Obj.ListBox6, 'Value', Obj.ProfileArray(Obj.Aprofile).ListBox6Choice);
            if Option ==33 || Option==35
                set (Obj.Popup8(1),'Value', Obj.ProfileArray(Obj.Aprofile).Popup8Choice, 'Enable', 'on');
            elseif Option >10 && Option <19
                set (Obj.Popup3(1),'Value', 1);    
            end
                
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%Criação dos gráficos%%%%%%%%%%%%%%%%%%%%%
        
        function Obj = CreateGraph (Obj)
            
            Obj.GraphAxes = axes ('Parent',Obj.DireitoSup,'ActivePositionProperty', 'OuterPosition',...
                'NextPlot','replacechildren'); 
        end
        
        function Obj = MakeSubplot (Obj)
        
            if Obj.ProfileArray(Obj.Aprofile).NGraph ==1
                subplot(1,1,1);
            elseif Obj.ProfileArray(Obj.Aprofile).NGraph ==2
                subplot(1,2,1);
                subplot(1,2,2);
                subplot(1,2,Obj.ProfileArray(Obj.Aprofile).SelectedGraph);
            else
                subplot(2,2,1);
                subplot(2,2,2);
                subplot(2,2,3);
                subplot(2,2,4);
                subplot(2,2,Obj.ProfileArray(Obj.Aprofile).SelectedGraph);
            end
        
        end
        
        function Obj = PlotData (Obj, option)
            
            switch option
                case 1
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\Delta$L', 'FontSize', 15,'Interpreter','latex');
                    
                case 2
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\Delta$L', 'FontSize', 15,'Interpreter','latex');
                    
                case 3
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{\Delta L}{L_0}$$','Interpreter','latex', 'FontSize', 15)
                    
                case 4
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{\Delta L}{L_0}$$','Interpreter','latex', 'FontSize', 15)
                    
                case 5
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\rho$ [\%]', 'FontSize', 15,'Interpreter','latex');
                    
                case 6
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    
                    if Obj.ProfileArray(Obj.Aprofile).Config.DensityDataOk==1
                        if isempty(Obj.ProfileArray(Obj.Aprofile).Config.DensityDataFile)==1
                            return;
                        end
                        xdata=Obj.ProfileArray(Obj.Aprofile).Config.DensityDataFile(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).Config.DensityDataFile(:,2);
                        Obj.Curva(i)=scatter(xdata,ydata,'*','LineWidth',0.2);
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\rho$ [\%]  ', 'FontSize', 15,'Interpreter','latex');
                        
                case 7
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\Psi$ [\%]', 'FontSize', 15,'Interpreter','latex');
                    
                case 8
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\Psi$ [\%]', 'FontSize', 15,'Interpreter','latex');
                    
                case 9
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{\Delta L}{L}$$','Interpreter','latex', 'FontSize', 15)
                    
                case 10
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{\Delta L}{L}$$','Interpreter','latex', 'FontSize', 15)
                    
                case 11
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivatet(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L_0} \frac{dL}{dt}  [s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                case 12
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivateT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L_0} \frac{dL}{dT}  [K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                case 13
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivatet(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\rho}{dt}  [10^2.s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                case 14
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivateT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\rho}{dT}  [10^2.K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
                    
                case 15
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivatet(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\Psi}{dt}  [10^2.s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                case 16
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivateT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\Psi}{dT}  [10^2.K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
                case 17
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivatet(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L} \frac{dL}{dt}  [s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                case 18
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivateT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L} \frac{dL}{dT}  [K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                case 19
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeUnc(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{\Delta L}{L_0}$','Interpreter','latex', 'FontSize', 15);
                    
                case 20
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeUnc(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \rho [\%]$','Interpreter','latex', 'FontSize', 15);
                    
                case 21
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeUnc(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \Psi [\%]$','Interpreter','latex', 'FontSize', 15);
                
                case 22
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeUnc(:,3);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{\Delta L}{L}$','Interpreter','latex', 'FontSize', 15);
                    
                    
                case 23
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUnct(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{1}{L_0} \frac{dL}{dt} [s^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                case 24
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUncT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{1}{L_0} \frac{dL}{dT} [K^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                    
                case 25
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUnct(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{d \rho}{dt} [10^2.s^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                case 26
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUncT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{d \rho}{dT} [10^2.K^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                    
                case 27
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUnct(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{d \Psi}{dt} [10^2.s^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                case 28
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUncT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{d \Psi}{dT} [10^2.K^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                    
                case 29
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUnct(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{1}{L} \frac{dL}{dt} [s^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                case 30
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUncT(:,2);
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=plot(xdata,ydata,'Color',ColorA);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                        
                    end
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$\sigma - \frac{1}{L} \frac{dL}{dT} [K^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    
                    
                case 31
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).Arrhenius.nDataAdjust
                        xdata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.DataAdjust{i}(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.DataAdjust{i}(:,2);
                        xdata2=Obj.ProfileArray(Obj.Aprofile).Arrhenius.LineAdjust{i}(:,1);
                        ydata2=Obj.ProfileArray(Obj.Aprofile).Arrhenius.LineAdjust{i}(:,2);
                        
                        Obj.Curva(2*i-1)=plot(xdata,ydata,'b+');
                        hold on;
                        Obj.Curva(2*i)=plot(xdata2,ydata2,'Color','r');
                    end
                    
                    if Obj.ProfileArray(Obj.Aprofile).Arrhenius.ArrheniusDataOption==1
                        ylabel('$ln (\frac{1}{L} \frac{dL}{dt} T)[\frac{1}{L} \frac{dL}{dt} T: K.s^{-1}]$', 'FontSize', 15,'Interpreter','latex');
                        xlabel('$1000/T [K^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    else
                        ylabel('$ln (\frac{1}{\rho} \frac{d \rho}{dt} T) [\frac{1}{\rho} \frac{d \rho}{dt} T: K.s^{-1}]$', 'FontSize', 15,'Interpreter','latex');
                        xlabel('1000/T $[K^{-1}]$','Interpreter','latex', 'FontSize', 15);
                    end
                    
                case 32
                    hold off
                    xdata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.ActivationEnergies(:,1);
                    ydata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.ActivationEnergies(:,2);
                    error=Obj.ProfileArray(Obj.Aprofile).Arrhenius.ActivationEnergies(:,3);
                    Obj.Curva(1)=errorbar(xdata,ydata,error,'--k');
                    hold on;
                    Obj.Curva(2)=plot(xdata,ydata,'or');
                    
                    ylabel('Activation Energy [kJ/mol]', 'FontSize', 15,'Interpreter','latex');
                    xlabel('Density [\%]','Interpreter','latex', 'FontSize', 15);
              
                case 34
                    hold off
                    xdata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning(:,1);
                    ydata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning(:,2);
                    Obj.Curva(1)=plot(xdata,ydata,'+k');
                    hold on;
                    
                    ylabel('Mean Square Error', 'FontSize', 15,'Interpreter','latex');
                    xlabel('Activation Energy [kJ/mol]','Interpreter','latex', 'FontSize', 15);
                
                case 36
                    hold off
                    xdata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning2(:,1);
                    ydata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning2(:,2);
                    Obj.Curva(1)=plot(xdata,ydata,'+k');
                    hold on;
                    
                    ylabel('Mean Square Error', 'FontSize', 15,'Interpreter','latex');
                    xlabel('Activation Energy [kJ/mol]','Interpreter','latex', 'FontSize', 15);
                    
                case 37
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData2{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData2{i}(:,2);
                            ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        else
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,2);
                            ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        end
                        
                        Obj.Curva(i)=scatter(xdata,ydata,'+','MarkerEdgeColor',ColorA,'LineWidth',0.05);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                    end
                    
                    if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve(:,2);
                        Obj.Curva(Obj.ProfileArray(Obj.Aprofile).nCurves+1)= plot(xdata,ydata,'-r','LineWidth', 1.5);
                        hold on;
                    else
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,2);
                        Obj.Curva(Obj.ProfileArray(Obj.Aprofile).nCurves+1)= plot(xdata,ydata,'-r','LineWidth', 1.5);
                        hold on;
                    end
                        
                    ylabel('$\rho  [\%]$', 'FontSize', 15,'Interpreter','latex');
                    xlabel('$log_{10} \Theta [\Theta : s.K^{-1}]$','Interpreter','latex', 'FontSize', 15);  
                    
                    
                case 38
                    hold off
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData{i}(:,2);
                        else
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,2);
                        end
                        ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;
                        
                        Obj.Curva(i)=scatter(xdata,ydata,'+','MarkerEdgeColor',ColorA,'LineWidth',0.05);
                        if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                            set(Obj.Curva(i),'Visible','off');
                        end
                        hold on;
                    end
                    
                    if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve2(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve2(:,2);
                        Obj.Curva(Obj.ProfileArray(Obj.Aprofile).nCurves+1)= plot(xdata,ydata,'-r','LineWidth', 1.5);
                        hold on;
                    else
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,2);
                        Obj.Curva(Obj.ProfileArray(Obj.Aprofile).nCurves+1)= plot(xdata,ydata,'-r','LineWidth', 1.5);
                        hold on;
                    end
                
                    ylabel('$\rho  [\%]$', 'FontSize', 15,'Interpreter','latex');
                    xlabel('$log_{10} \Theta [\Theta : s.K^{-1}]$','Interpreter','latex', 'FontSize', 15); 
                    
                case 39
                    hold off
                    for i=1:7
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.Densidadest1{i,1}(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.Densidadest1{i,1}(:,1);
                        Obj.Curva(i)= plot(xdata,ydata,'-r','LineWidth', 1.5, 'Color', Obj.CorArray{i});
                        hold on;
                    end
                    xlabel('$\rho  [\%]$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('Temperature $[^oC]$','Interpreter','latex', 'FontSize', 15);
                    legend( '10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}','10^{3}','Location','northwest');
                
                case 40
                    hold off
                    for i=1:7
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.Densidadest2{i,1}(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.Densidadest2{i,1}(:,1);
                        Obj.Curva(i)= plot(xdata,ydata,'-r','LineWidth', 1.5,'Color', Obj.CorArray{i});
                        hold on;
                    end
                    
                    xlabel('$\rho  [\%]$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('Temperature $[^oC]$','Interpreter','latex', 'FontSize', 15);
                    legend( '10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}','10^{3}','Location','southeast');
                    
            end
            
        end
        
        function Obj = SmoothGraph (Obj, Option)
           
            aux = get (Obj.Popup3(1),'Value');
            if aux==1
                Obj.PlotData (Option);
                set (Obj.EditText3(3), 'Enable', 'off', 'String', num2str(0));
                set (Obj.Slider3(1), 'Enable', 'off', 'Value', 0);
            else
                set (Obj.EditText3(3), 'Enable', 'on');
                set (Obj.Slider3(1), 'Enable', 'on');
                Obj.PlotSmoothData (Option, aux-1);
            end
            
        end
        
        function Obj = PlotSmoothData (Obj, Option, Choice)
            
            switch Option
                case 11
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.Derivatet(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivatet(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.Derivatet);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothWindowt;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L_0} \frac{dL}{dt}  [s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                
                
                case 12
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.DerivateT(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivateT(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.DerivateT);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothWindowT;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Temperature $[^oC]$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L_0} \frac{dL}{dT}  [K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                    
                
                
                case 13
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.Derivatet(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivatet(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.Derivatet);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothWindowt;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\rho}{dt}  [10^2.s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
                
                case 14
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.DerivateT(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivateT(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.DerivateT);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothWindowT;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\rho}{dT}  [10^2.K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
                
               case 15
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.Derivatet(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivatet(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.Derivatet);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothWindowt;
                    set (Obj.EditText3(3), 'String', num2str(aperture));
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\Psi}{dt}  [10^2.s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
                case 16
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.DerivateT(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivateT(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.DerivateT);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothWindowT;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{d\Psi}{dT}  [10^2.K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
               case 17
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.Derivatet(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivatet(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.Derivatet);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothWindowt;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Time [s]', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L} \frac{dL}{dt}  [s^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
                case 18
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.DerivateT(:,2);
                    Color1=Obj.CorArray{1};
                    Obj.Curva(1)=plot(xdata1, ydata1,'Color', Color1);
                    hold on;

                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivateT(:,2);
                    Color2=Obj.CorArray{2};
                    Obj.Curva(2)=plot(xdata2, ydata2, 'Color', Color2);
                    hold on;

                    ndados= size(Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.DerivateT);
                    aperture = Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothWindowT;
                    set (Obj.EditText3(3), 'String', num2str(aperture) );
                    set (Obj.Slider3(1), 'Min', 0, 'Max', ceil(ndados(1,1)/2),'Value', aperture);
                    
                    xlabel('Temperature $$[^oC]$$', 'FontSize', 15,'Interpreter','latex');
                    ylabel('$$\frac{1}{\L} \frac{dL}{dT}  [K^{-1}] $$','Interpreter','latex', 'FontSize', 15)
                
            end
    

           
            
            
        end
        
        function Obj = RefreshGraph (Obj)
            
            set(Obj.Popup6(1),'Value',Obj.ProfileArray(Obj.Aprofile).NGraph);
            set(Obj.Popup6(2),'Value',Obj.ProfileArray(Obj.Aprofile).SelectedGraph);
            Obj.RefreshListBox;
            Obj.MakeSubplot;
            aux = Obj.ProfileArray(Obj.Aprofile).SelectedGraph;
            for i=1:Obj.ProfileArray(Obj.Aprofile).NGraph
                Obj.ProfileArray(Obj.Aprofile).SelectedGraph=i;
                Obj.MakeSubplot;
                Obj.GraphData;
            end
            Obj.ProfileArray(Obj.Aprofile).SelectedGraph=aux;
            Obj.MakeSubplot;
            
            
        end
        
        function Obj = ResidualGraphs (Obj, Option)
           
            if Option ==33 
                hold off
                aux=Obj.ProfileArray(Obj.Aprofile).Popup8Choice;
                if aux==1
                    Obj.RefreshPopup8 (Option);
                    set(Obj.Popup8(1),'Enable','on');
                    cla('reset');
                else
                    aux2=aux-1;
                        for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                            ndados=size(Obj.ProfileArray(Obj.Aprofile).MSC.MSCData{i}(:,1));
                            xdata=(1:ndados(1,1));
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.Residual{aux2}{i};
                            ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;

                            Obj.Curva(i)=scatter(xdata,ydata,'+','MarkerEdgeColor',ColorA,'LineWidth',0.05);
                            if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                                set(Obj.Curva(i),'Visible','off');
                            end
                        hold on;
                        end
                        
                        ylabel('Residual','Interpreter','latex', 'FontSize', 15);
                        xlabel('$log_{10} \Theta [\Theta : s.K^{-1}]$','Interpreter','latex', 'FontSize', 15); 
                 end
            end
            
            if Option ==35 
                hold off
                aux=Obj.ProfileArray(Obj.Aprofile).Popup8Choice;
                if aux==1
                    Obj.RefreshPopup8 (Option);
                    set(Obj.Popup8(1),'Enable','on');
                    cla('reset');
                else
                    aux2=aux-1;
                        for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                            ndados=size(Obj.ProfileArray(Obj.Aprofile).MSC.MSCDataA{i}(:,1));
                            xdata=(1:ndados(1,1));
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.Residual2{aux2}{i};
                            ColorA=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).IdColor;

                            Obj.Curva(i)=scatter(xdata,ydata,'+','MarkerEdgeColor',ColorA,'LineWidth',0.05);
                            if Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Show==0
                                set(Obj.Curva(i),'Visible','off');
                            end
                        hold on;
                        end
                end
                
                ylabel('Residual','Interpreter','latex', 'FontSize', 15);
                xlabel('$log_{10} \Theta [\Theta : s.K^{-1}]$','Interpreter','latex', 'FontSize', 15);
            end
            
        end
        
        function Obj = ExportData (Obj, Option)
           
            switch Option
                case 1
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados); 
                    end
                    
                    case 2
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).File(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    case 3
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    case 4
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 5
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 6
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    
                case 7
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 8
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 9
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 10
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.Curve(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 11
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivatet(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 12
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.SmoothDerivateT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 13
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivatet(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 14
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.SmoothDerivateT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                
                    
                case 15
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivatet(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 16
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.SmoothDerivateT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                
                case 17
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivatet(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivatet(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 18
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivateT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.SmoothDerivateT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 19
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeUnc(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 20
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeUnc(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 21
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeUnc(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                
                case 22
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeUnc(:,2);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeUnc(:,3);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    
                case 23
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUnct(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 24
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Shrinkage.RelativeDerivateUncT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    
                case 25
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUnct(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 26
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densities.RelativeDerivateUncT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    
                case 27
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUnct(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 28
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).Densification.RelativeDerivateUncT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                    
                    case 29
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUnct(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUnct(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 30
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUncT(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).ArrayData(i).InstShrinkage.RelativeDerivateUncT(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);    
                    end
                    
                case 31
                    for i=1:Obj.ProfileArray(Obj.Aprofile).Arrhenius.nDataAdjust
                        xdata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.DataAdjust{i}(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.DataAdjust{i}(:,2);
                        xdata2=Obj.ProfileArray(Obj.Aprofile).Arrhenius.LineAdjust{i}(:,1);
                        ydata2=Obj.ProfileArray(Obj.Aprofile).Arrhenius.LineAdjust{i}(:,2);
                        
                        dados = [xdata ydata];
                        string = ['Curva' num2str(2*i-1) '.dat'];
                        dlmwrite(string, dados);
                        dados = [xdata2 ydata2];
                        string = ['Curva' num2str(2*i) '.dat'];
                        dlmwrite(string, dados);
                    end
                    
                case 32
                    xdata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.ActivationEnergies(:,1);
                    ydata=Obj.ProfileArray(Obj.Aprofile).Arrhenius.ActivationEnergies(:,2);
                    error=Obj.ProfileArray(Obj.Aprofile).Arrhenius.ActivationEnergies(:,3);
                    dados = [xdata ydata error];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados);
                        
                case 34
                    xdata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning(:,1);
                    ydata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning(:,2);
                    dados = [xdata ydata];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados);
                
                case 36
                    xdata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning2(:,1);
                    ydata=Obj.ProfileArray(Obj.Aprofile).MSC.ResultsScanning2(:,2);
                    dados = [xdata ydata];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados);
                    
                case 37
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData2{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData2{i}(:,2);
                        else
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,2);
                        end
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);
                    end
                    
                    if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve(:,2);
                    else
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,2);
                    end
                    ncurvas=Obj.ProfileArray(Obj.Aprofile).nCurves+1;
                    dados = [xdata ydata];
                    string = ['Curva' num2str(ncurvas) '.dat'];
                    dlmwrite(string, dados);
                        
                case 38
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData{i}(:,2);
                        else
                            xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,1);
                            ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSC2Final{i}(:,2);
                        end
                        dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados);
                    end
                    
                    if Obj.ProfileArray(Obj.Aprofile).MSC.MSCStages==1
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve2(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurve2(:,2);
                    else
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCCurveFinal(:,2);
                    end
                    ncurvas=Obj.ProfileArray(Obj.Aprofile).nCurves+1;
                    dados = [xdata ydata];
                    string = ['Curva' num2str(ncurvas) '.dat'];
                    dlmwrite(string, dados);
                        
            end
            
            
        end
        
        function Obj = ExportSmoothGraph (Obj, Option)
           
            Choice = get (Obj.Popup3(1),'Value');
            if Choice==1
                Obj.ExportData (Option);
            else
                switch Option
                case 11
                    hold off
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.Derivatet(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivatet(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados); 
                
                case 12
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.DerivateT(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Shrinkage.SmoothDerivateT(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                
                case 13
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.Derivatet(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivatet(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                    
                case 14
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.DerivateT(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densities.SmoothDerivateT(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                    
               case 15
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.Derivatet(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivatet(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                    
                case 16
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.DerivateT(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).Densification.SmoothDerivateT(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                    
               case 17
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.Derivatet(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.Derivatet(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivatet(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivatet(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                    
                case 18
                    xdata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.DerivateT(:,1);
                    ydata1=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.DerivateT(:,2);
                    xdata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivateT(:,1);
                    ydata2=Obj.ProfileArray(Obj.Aprofile).ArrayData(Choice).InstShrinkage.SmoothDerivateT(:,2);
                    dados = [xdata1 ydata1];
                    string = ['Curva' num2str(1) '.dat'];
                    dlmwrite(string, dados); 
                    dados = [xdata2 ydata2];
                    string = ['Curva' num2str(2) '.dat'];
                    dlmwrite(string, dados);
                    
                end
            
            end    
            
        
        end
        
        function Obj = ExportResidualGraphs (Obj, Option)
           
            if Option ==33 
                aux=Obj.ProfileArray(Obj.Aprofile).Popup8Choice;
                if aux==1
                    errordlg('No data Selected','Warning','modal');
                    uicontrol(hObject);    
                    return;
                else
                    aux2=aux-1;
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCData{i}(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.Residual{aux2}{i};

                         dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados); 
                     end
                end
            end
            if Option ==35 
                aux=Obj.ProfileArray(Obj.Aprofile).Popup8Choice;
                if aux==1
                    errordlg('No data Selected','Warning','modal');
                    uicontrol(hObject);    
                    return;
                else
                    aux2=aux-1;
                    for i=1:Obj.ProfileArray(Obj.Aprofile).nCurves
                        xdata=Obj.ProfileArray(Obj.Aprofile).MSC.MSCDataA{i}(:,1);
                        ydata=Obj.ProfileArray(Obj.Aprofile).MSC.Residual2{aux2}{i};

                         dados = [xdata ydata];
                        string = ['Curva' num2str(i) '.dat'];
                        dlmwrite(string, dados); 
                     end
                end
            end
            
        end
        
        function Obj = ResetGraph (Obj)
            
            %Reseta o axes
            Obj.ProfileArray(Obj.Aprofile).GraphFlag=zeros(40,1);
            Obj.RefreshListBox;
            cla('reset');
            
        end
        
        
        
    end
        
        
        
    
end

