function handles = redraw_blueobjects(handles,ID,varargin)

if nargin == 1; ID = 'both'; end

if strcmp(ID,'mobile') || strcmp(ID,'both')
    oldpoints = handles.mobilepoints{1};
    newpoints = handles.mobilepoints{2};
    
    for i = 1:length(handles.bluecircles)
        try delete(handles.bluecircles(i)); end %#ok<TRYNC>
        
        handles.bluecircles(i) = rectangle('Position',...
            [oldpoints(i,1)-10,oldpoints(i,2)-10,20,20],...
            'Curvature',1,'EdgeColor','b','LineWidth',3);
    end
    for i = 1:length(handles.bluelines)
        try delete(handles.bluelines(i)); end %#ok<TRYNC>
        
        handles.bluelines(i) = line([oldpoints(i,1) newpoints(i,1)],...
            [oldpoints(i,2) newpoints(i,2)],'color','b','linewidth',3);
    end
    
end

if strcmp(ID,'fixed') || strcmp(ID,'both')
    fixpoints = handles.fixedpoints{1};
    
    for i = 1:length(handles.blackcircles)
        try delete(handles.blackcircles(i)); end %#ok<TRYNC>
        
        handles.blackcircles(i) = rectangle('Position',...
            [fixpoints(i,1)-10,fixpoints(i,2)-10,20,20],...
            'Curvature',1,'EdgeColor','k','LineWidth',3);
    end
    
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;