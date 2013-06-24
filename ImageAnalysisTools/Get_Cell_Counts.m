function [] = Get_Cell_Counts(fileName,pathName)
%Get_Cell_Counts Summary of this function goes here
%   Detailed explanation goes here

cd(pathName)

load(fileName)

sections = fieldnames(CellCountData);
segments = fieldnames(CellCountData.(sections{1}));



segment1 = zeros(length(sections),1);
segment2 = zeros(length(sections),1);
segment3 = zeros(length(sections),1);
segment4 = zeros(length(sections),1);
segment5 = zeros(length(sections),1);
segment6 = zeros(length(sections),1);
whole = zeros(length(sections),1);
for ci = 1:length(sections)

        segment1(ci,1) = CellCountData.(sections{ci}).(segments{1});
        segment2(ci,1) = CellCountData.(sections{ci}).(segments{2});
        segment3(ci,1) = CellCountData.(sections{ci}).(segments{3});
        segment4(ci,1) = CellCountData.(sections{ci}).(segments{4});
        segment5(ci,1) = CellCountData.(sections{ci}).(segments{5});
        segment6(ci,1) = CellCountData.(sections{ci}).(segments{6});
        whole(ci,1) = CellCountData.(sections{ci}).(segments{7});
end

CellCountDS = dataset(sections,segment1,segment2,segment3,segment4,segment5,...
    segment6,whole);

findCell = strfind(fileName,'Cell');

caseName = fileName(1:findCell - 1);

saveName = strcat(caseName,'.xlsx');

export(CellCountDS,'XLSfile',saveName)


end

