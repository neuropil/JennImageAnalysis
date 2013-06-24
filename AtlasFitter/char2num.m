function output = char2num(input)

output = zeros(1,numel(input));

for c = 1:numel(input)
    x = input(c);
    
    if     strcmp(x,' ') == 1;  output(c) = 0;
    elseif strcmp(x,'0') == 1;  output(c) = 1;
    elseif strcmp(x,'1') == 1;  output(c) = 2;
    elseif strcmp(x,'2') == 1;  output(c) = 3;
    elseif strcmp(x,'3') == 1;  output(c) = 4;
    elseif strcmp(x,'4') == 1;  output(c) = 5;
    elseif strcmp(x,'5') == 1;  output(c) = 6;
    elseif strcmp(x,'6') == 1;  output(c) = 7;
    elseif strcmp(x,'7') == 1;  output(c) = 8;
    elseif strcmp(x,'8') == 1;  output(c) = 9;
    elseif strcmp(x,'9') == 1;  output(c) = 10;
    elseif strcmp(x,'a') == 1 || strcmp(x,'A') == 1;  output(c) = 11;
    elseif strcmp(x,'b') == 1 || strcmp(x,'B') == 1;  output(c) = 12;
    elseif strcmp(x,'c') == 1 || strcmp(x,'C') == 1;  output(c) = 13;
    elseif strcmp(x,'d') == 1 || strcmp(x,'D') == 1;  output(c) = 14;
    elseif strcmp(x,'e') == 1 || strcmp(x,'E') == 1;  output(c) = 15;
    elseif strcmp(x,'f') == 1 || strcmp(x,'F') == 1;  output(c) = 16;
    elseif strcmp(x,'g') == 1 || strcmp(x,'G') == 1;  output(c) = 17;
    elseif strcmp(x,'h') == 1 || strcmp(x,'H') == 1;  output(c) = 18;
    elseif strcmp(x,'i') == 1 || strcmp(x,'I') == 1;  output(c) = 19;
    elseif strcmp(x,'j') == 1 || strcmp(x,'J') == 1;  output(c) = 20;
    elseif strcmp(x,'k') == 1 || strcmp(x,'K') == 1;  output(c) = 21;
    elseif strcmp(x,'l') == 1 || strcmp(x,'L') == 1;  output(c) = 22;
    elseif strcmp(x,'m') == 1 || strcmp(x,'M') == 1;  output(c) = 23;
    elseif strcmp(x,'n') == 1 || strcmp(x,'N') == 1;  output(c) = 24;
    elseif strcmp(x,'o') == 1 || strcmp(x,'O') == 1;  output(c) = 25;
    elseif strcmp(x,'p') == 1 || strcmp(x,'P') == 1;  output(c) = 26;
    elseif strcmp(x,'q') == 1 || strcmp(x,'Q') == 1;  output(c) = 27;
    elseif strcmp(x,'r') == 1 || strcmp(x,'R') == 1;  output(c) = 28;
    elseif strcmp(x,'s') == 1 || strcmp(x,'S') == 1;  output(c) = 29;
    elseif strcmp(x,'t') == 1 || strcmp(x,'T') == 1;  output(c) = 30;
    elseif strcmp(x,'u') == 1 || strcmp(x,'U') == 1;  output(c) = 31;
    elseif strcmp(x,'v') == 1 || strcmp(x,'V') == 1;  output(c) = 32;
    elseif strcmp(x,'w') == 1 || strcmp(x,'W') == 1;  output(c) = 33;
    elseif strcmp(x,'x') == 1 || strcmp(x,'X') == 1;  output(c) = 34;
    elseif strcmp(x,'y') == 1 || strcmp(x,'Y') == 1;  output(c) = 35;
    elseif strcmp(x,'z') == 1 || strcmp(x,'Z') == 1;  output(c) = 36;
    end   
end

varnames = whos;
for vari = 1:length(varnames);
    if strcmp(varnames(vari).name,'output') == 0; clear(varnames(vari).name); end
end
clear vari varnames;