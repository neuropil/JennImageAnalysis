function showerror(err)

disp(['ERROR: ',err.message]);
for s = 1:length(err.stack)
    disp(['Error in: ',err.stack(s).name,' at ',num2str(err.stack(s).line)]);
end
    