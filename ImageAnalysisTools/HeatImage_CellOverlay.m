clear all
close all

%% Extract Heat Map Pixel Data
% This program assumes that you have already run Extract_PixelDensity_ROI.m
% and that you have already run CellCounterFINAL_SinglePoly.m


% Select file that used used for CellCount analysis (i.e. Resized_25%....)
[Gtest,bluepixels,maskIndices,fileName,pathname] = HeatMapPixelDensity;

Cell_image_data = char(strcat(pathname, 'HeatMapData\'));

cd(Cell_image_data);

fnextract = strtok(fileName,'.');

fLNAME = char(strcat('Image_Data_',fnextract,'.mat'));

load(fLNAME);

%%

[B,L] = bwboundaries(Cells);

%%

figure;
h1 = image(Gtest,'CDataMapping','scaled'); 
colormap(jet(256));
% alpha_data3 = (Rintensity_mask_matrix);
set(h1, 'AlphaData', bluepixels);
colorbar

for i = 1:length(B)
    hold on
    plot(B{i}(:,2), B{i}(:,1),'LineWidth',2,'Color','m')
end

plot(polyborders{1,1}(:,2),polyborders{1,1}(:,1),'LineWidth',1, 'Color','k');


