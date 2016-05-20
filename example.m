%% guiohneguide.m

function guiohneguide

% Auslesen der Bildschirmaufl�sung
scrsz = get(0,'ScreenSize');

% Erstellen eines Fensters ohne Menu- und Toolbar; die Gr��e des Fensters
% ist abh�ngig von der Bildschirmaufl�sung und sollte �berall genau mittig
% im gleichen Verh�ltnis wie der Monitor (Bsp: 4:3) erscheinen
MainWindow = figure('MenuBar','none',...
                    'Name','GUI - erstellt ohne GUIDE',...
                    'ToolBar','none',...
                    'Position',[.4*scrsz(3),.4*scrsz(4),...
                                .2*scrsz(3),.2*scrsz(4)]);
               
% Erstellen eines Pushbuttons (Position relativ zu den Ma�en des
% Hauptfensters)
handles.pushbutton1 = uicontrol(MainWindow,'Style','pushbutton',...
                                'String','OK',...
                                'FontWeight','bold',...
                                'FontSize',10,...
                                'Units','normalized',...
                                'Position',[.4,.375,.2,.1],...
                                'Callback',@pushbutton1_callback);

% Erstellen eines edit-Textfeldes (Position relativ zu den Ma�en des
% Hauptfensters)
% Auf dieses Element kann nur �ber den Tag zugegriffen werden
uicontrol(MainWindow,'Style','edit',...
          'Tag','edit1',...
          'Units','normalized',...
          'FontSize',10,...
          'Background','white',...
          'Position',[.3,.525,.4,.1],...
          'Callback',@edit1_callback);
                           
% Erstellen einer Variable, auf welche sp�ter zugegriffen werden soll...
handles.wert1 = 'Juhu, es klappt!';

% Abspeichern der Struktur
guidata(MainWindow,handles);

    function pushbutton1_callback(hObject,eventdata)
        % laden der Stuktur
        handles = guidata(hObject);
       
        % extrahieren des eingegebenen Strings aus den edit-Feld
        editstring = get(findobj('Tag','edit1'),'String');
   
        % Wenn kein Wert eingegeben wurde, dann zeig den gespeicherten Wert an,
        % in Verbindung mit der Beschrifung des Pushbuttons
        if isempty(editstring)
            h = msgbox([handles.wert1,' - ',get(handles.pushbutton1,'String')]);
        % ansonsten zeige den eingegebenen String an
        else
            h = msgbox(editstring);
        end
        % warte bis die Messagebox geschlossen wurde
        uiwait(h);
        % schlie�e dann das Hauptfenster
        close(MainWindow);
        % warte eine Sekunde und �ffne das Fenster erneut
        pause(1);
        guiohneguide;
    end

    function edit1_callback(hObject,eventdata)
        % laden der Stuktur
        handles = guidata(hObject);
       
        % extrahieren des eingegebenen Strings aus den edit-Feld
        editstring = get(findobj('Tag','edit1'),'String');
       
        % �bergeben des Stings als Beschriftung des Pushbuttons
        set(handles.pushbutton1,'String',editstring);
       
        % Updaten der Struktur
        guidata(hObject,handles);
    end

end