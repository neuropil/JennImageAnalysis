function swapatlas_userdatafile

disp('Load User Data File');
[f p] = uigetfile; load([p f]);

disp('Load NEW Atlas');
[f p] = uigetfile; load([p f]);

atlas.region     = regions;
atlas.numregions = length(regions);
atlas.leftright  = findleftright(regions);
atlas.pointpairs = findpointpairs(regions);
atlas.atlaspath  = [p f];

disp('Save NEW User Data File');
[f p] = uiputfile; save([p f],'atlas');