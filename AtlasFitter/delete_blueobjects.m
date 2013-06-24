function handles = delete_blueobjects(handles,ID,varargin)

if nargin == 1; ID = 'both'; end

if strcmp(ID,'mobile') || strcmp(ID,'both')
    for i = 1:length(handles.bluecircles)
        try delete(handles.bluecircles(i)); end %#ok<TRYNC>
    end
    for i = 1:length(handles.bluelines)
        try delete(handles.bluelines(i)); end %#ok<TRYNC>
    end
    handles.bluecircles     = [];
    handles.bluelines       = [];
    handles.mobilepoints{1} = [];
    handles.mobilepoints{2} = [];
    
end

if strcmp(ID,'fixed') || strcmp(ID,'both')
    for i = 1:length(handles.blackcircles)
        try delete(handles.blackcircles(i)); end %#ok<TRYNC>
    end
    handles.blackcircles   = [];
    handles.fixedpoints{1} = [];
    handles.fixedpoints{2} = [];
end


varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'handles') == 0; clear(varnames(vari).name); end
end
clear vari varnames;