function output = parse_atlasdata(input)

temp = [];
output = [];
for i = 1:length(input.count)
    
    if isstruct(input.area{i}); names = fieldnames(input.area{i}); else names = []; end
    for n = 1:length(names)
        if ~isfield(temp,names{n}); 
            eval(['temp.',names{n},'.count  = [];']);
            eval(['temp.',names{n},'.area   = [];']);
            eval(['temp.',names{n},'.mcell  = [];']);
            eval(['temp.',names{n},'.signal = [];']);
        end
        
        eval(['temp.',names{n},'.count  = [temp.',names{n},'.count  input.count{i}.',names{n},       '];']);
        eval(['temp.',names{n},'.area   = [temp.',names{n},'.area   input.area{i}.',names{n},        '];']);
        eval(['temp.',names{n},'.mcell  = [temp.',names{n},'.mcell  input.meancell{i}.',names{n},    '];']);
        eval(['temp.',names{n},'.signal = [temp.',names{n},'.signal full(input.signal{i}.',names{n},')];']);
        
        if strcmp(names{n}(1),'L') == 1 || strcmp(names{n}(1),'R') == 1
            cropname = names{n}(3:end);
            if ~isfield(temp,cropname); 
                eval(['temp.',cropname,'.count  = [];']);
                eval(['temp.',cropname,'.area   = [];']);
                eval(['temp.',cropname,'.mcell  = [];']);
                eval(['temp.',cropname,'.signal = [];']);
            end
            
            eval(['temp.',cropname,'.count  = [temp.',cropname,'.count  input.count{i}.',names{n},       '];']);
            eval(['temp.',cropname,'.area   = [temp.',cropname,'.area   input.area{i}.',names{n},        '];']);
            eval(['temp.',cropname,'.mcell  = [temp.',cropname,'.mcell  input.meancell{i}.',names{n},    '];']);
            eval(['temp.',cropname,'.signal = [temp.',cropname,'.signal full(input.signal{i}.',names{n},')];']);
        end
        
    end
end

names = fieldnames(temp);
for n = 1:length(names)
    eval(['output.',names{n},'.area = sum(temp.',names{n},'.area);']);
    eval(['output.',names{n},'.mcell = mean(temp.',names{n},'.mcell);']);
    eval(['output.',names{n},'.signal = sum(temp.',names{n},'.signal);']);
    eval(['output.',names{n},'.count = sum(temp.',names{n},'.count);']);
    eval(['output.',names{n},'.norm_count = output.',names{n},'.count / output.',names{n},'.area;']);
    eval(['output.',names{n},'.norm_signal = output.',names{n},'.signal / output.',names{n},'.area;']);
    eval(['output.',names{n},'.cells = temp.',names{n},'.mcell;']);
end



