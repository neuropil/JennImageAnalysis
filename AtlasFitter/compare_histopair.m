function output = compare_histopair(data1,data2)

%regions = 'all';
include_regions;

temp_mcell      = zeros(length(data1),length(regions)); temp_mcell(:) = nan;
temp_normsignal = temp_mcell;
temp_normcount  = temp_mcell;
temp_sig        = temp_mcell;
temp_data1{length(regions)} = [];
temp_data2 = temp_data1;

names = '';
for PR = 1:length(data1)
    names1 = fieldnames(data1{PR});
    names2 = fieldnames(data2{PR});
    
    names = unique([names1;names2;names]);
end
if strcmp(regions,'all'); regions = names; end

cortex_cont = zeros(length(data1),2);
cortex_sgnl = zeros(length(data1),2);
cortex_area = zeros(length(data1),2);
for PR = 1:length(data1)
    for n = 1:length(regions)
        if isfield(data1{PR},regions{n}) && isfield(data2{PR},regions{n}) && ~strcmp(regions{n}(1),'L') && ~strcmp(regions{n}(1),'R')
            eval(['temp1 = data1{PR}.',regions{n},';']);
            eval(['temp2 = data2{PR}.',regions{n},';']);
            if findstrfrag(regions{n},'Cx') == 1
                cortex_cont(PR,1) = cortex_cont(PR,1) + temp1.count;
                cortex_cont(PR,2) = cortex_cont(PR,2) + temp2.count;
                
                cortex_sgnl(PR,1) = cortex_sgnl(PR,1) + temp1.signal;
                cortex_sgnl(PR,2) = cortex_sgnl(PR,2) + temp2.signal;
                
                cortex_area(PR,1) = cortex_area(PR,1) + temp1.area;
                cortex_area(PR,2) = cortex_area(PR,2) + temp2.area;
            end
        end
    end
end

temp_area{length(regions),2,length(data1)} = [];
temp_sgnl{length(regions),2,length(data1)} = [];
temp_cont{length(regions),2,length(data1)} = [];

for PR = 1:length(data1)
    for n = 1:length(regions)
        if ~isfield(data1{PR},regions{n}) || ~isfield(data2{PR},regions{n}) ||...
                (length(regions{n})>2 && strcmp(regions{n}(1:2),'L_')) ||...
                (length(regions{n})>2 && strcmp(regions{n}(1:2),'R_'))
            temp_mcell(PR,n)      = nan; 
            temp_normsignal(PR,n) = nan;
            temp_normcount(PR,n)  = nan;
            temp_sig(PR,n)        = nan;
            temp_data1{PR,n}      = [];
            temp_data2{PR,n}      = [];
            temp_enrich_cont(PR,n)= nan; %#ok<AGROW>
            temp_enrich_sgnl(PR,n)= nan; %#ok<AGROW>
        else
            eval(['temp1 = data1{PR}.',regions{n},';']);
            eval(['temp2 = data2{PR}.',regions{n},';']);

            [h p k] = kstest2(temp1.cells',temp2.cells'); %#ok<NASGU>

            temp_mcell(PR,n)      = log2(temp1.mcell       / temp2.mcell); 
            temp_normsignal(PR,n) = log2(temp1.norm_signal / temp2.norm_signal);
            temp_normcount(PR,n)  = log2(temp1.norm_count  / temp2.norm_count);
            temp_sig(PR,n)        = p;
            temp_data1{PR,n}      = temp1;
            temp_data2{PR,n}      = temp2;
            temp_area(n,1:2,PR)   = {round(temp1.area * 10)/10   round(temp2.area * 10)/10};
            temp_sgnl(n,1:2,PR)   = {round(temp1.signal) round(temp2.signal)};
            temp_cont(n,1:2,PR)   = {temp1.count  temp2.count};
            
            if findstrfrag(regions{n},'Cx') == 1
                EC(1) = (temp1.count  / cortex_cont(PR,1)) / (temp1.area / cortex_area(PR,1));
                EC(2) = (temp2.count  / cortex_cont(PR,2)) / (temp2.area / cortex_area(PR,2));

                ES(1) = (temp1.signal / cortex_sgnl(PR,1)) / (temp1.area / cortex_area(PR,1));
                ES(2) = (temp2.signal / cortex_sgnl(PR,2)) / (temp2.area / cortex_area(PR,2));

                temp_enrich_cont(PR,n) = EC(1) / EC(2); %#ok<AGROW>
                temp_enrich_sgnl(PR,n) = ES(1) / ES(2); %#ok<AGROW>
            else
                temp_enrich_cont(PR,n)= nan; %#ok<AGROW>
                temp_enrich_sgnl(PR,n)= nan; %#ok<AGROW>
            end
        end
    end
end
   
cortex_good = ~isnan(temp_enrich_cont(1,:)) & ~isnan(temp_enrich_cont(2,:));
cortex_names = regions(cortex_good);
figure('Color','w'); hold on; 
line([0 length(cortex_names)],[0 0],'color',[0.5 0.5 0.5],'linewidth',3);
plot([1:length(cortex_names)]-0.1,log2(temp_enrich_cont(1,cortex_good)),' ob','markerfacecolor','b','markersize',8);
plot([1:length(cortex_names)]-0.1,log2(temp_enrich_cont(2,cortex_good)),' ob','markerfacecolor','b','markersize',8);
plot([1:length(cortex_names)]+0.1,log2(temp_enrich_sgnl(1,cortex_good)),' or','markerfacecolor','r','markersize',8);
plot([1:length(cortex_names)]+0.1,log2(temp_enrich_sgnl(2,cortex_good)),' or','markerfacecolor','r','markersize',8);
set(gca,'fontsize',16,'XTick',1:length(cortex_names),'XTickLabel',cortex_names);
ylim([-0.6 0.6]);
ylabel('Log2 Enrichment Ratio (Duration / Frequency)')
title('Blue: Cell Count     Red: Cell Signal');

output{length(cortex_names)+2,16} = [];
output(1,:) = {'','PP_1','','','','PPC_1','','','','PP_2','','','','PPC_2','',''};
output(2,:) = {'Region','Area','Count','Signal','','Area','Count','Signal','','Area','Count','Signal','','Area','Count','Signal'};
output(3:end,1) = cortex_names;

output(3:end,2) = temp_area(cortex_good,1,1);
output(3:end,3) = temp_cont(cortex_good,1,1);
output(3:end,4) = temp_sgnl(cortex_good,1,1);

output(3:end,6) = temp_area(cortex_good,2,1);
output(3:end,7) = temp_cont(cortex_good,2,1);
output(3:end,8) = temp_sgnl(cortex_good,2,1);

output(3:end,10) = temp_area(cortex_good,1,2);
output(3:end,11) = temp_cont(cortex_good,1,2);
output(3:end,12) = temp_sgnl(cortex_good,1,2);

output(3:end,14) = temp_area(cortex_good,2,2);
output(3:end,15) = temp_cont(cortex_good,2,2);
output(3:end,16) = temp_sgnl(cortex_good,2,2);

%return
normsignal(1,:) = mean(temp_normsignal,1); normsignal(2,:) = std(temp_normsignal,0,1)/ sqrt(size(temp_normsignal,1)- 1); 
     mcell(1,:) = mean(temp_mcell,1);           mcell(2,:) = std(temp_mcell,0,1)     / sqrt(size(temp_mcell,1)     - 1);    
 normcount(1,:) = mean(temp_normcount,1);   normcount(2,:) = std(temp_normcount,0,1) / sqrt(size(temp_normcount,1) - 1); 
       sig(1,:) = mean(temp_sig,1);               sig(2,:) = std(temp_sig,0,1)       / sqrt(size(temp_sig,1)       - 1); 
       
mcell_comp = temp_mcell(1,:) > temp_mcell(2,:);
normsig_comp = temp_normsignal(1,:) > temp_normsignal(2,:);
normcnt_comp = temp_normcount(1,:) > temp_normcount(2,:);
nanregions = isnan(normsignal(1,:));
sig_comp = (temp_sig(1,:) < 0.05) & (temp_sig(2,:) < 0.05);

test = normsig_comp;
D1R = regions(test == 1 & nanregions == 0);
D2R = regions(test == 0 & nanregions == 0);

D1C = regions(temp_enrich_cont(1,:) > 1 & temp_enrich_cont(2,:) > 1);
D2C = regions(temp_enrich_cont(1,:) < 1 & temp_enrich_cont(2,:) < 1);

D1S = regions(temp_enrich_sgnl(1,:) > 1 & temp_enrich_sgnl(2,:) > 1);
D2S = regions(temp_enrich_sgnl(1,:) < 1 & temp_enrich_sgnl(2,:) < 1);


%[temp,I] = sort(normsignal(1,:),2,'descend');
[temp,I] = sort(regions);
normsignal = normsignal(:,I);
mcell      = mcell(:,I);
normcount  = normcount(:,I);
sig        = sig(:,I);
regions    = regions(I);

temp_data1 = temp_data1(:,I);
temp_data2 = temp_data2(:,I);

output.names      = regions;
output.mcell      = mcell;
output.normsignal = normsignal;
output.normcount  = normcount;
output.sig        = sig;
output.data1      = temp_data1;
output.data2      = temp_data2;

figure('Color','w'); hold on; set(gca,'fontsize',16);
line([0 n],[0 0],'color',[0.5 0.5 0.5],'linewidth',2);
plot(output.mcell(1,:),'-r','linewidth',3);
plot(output.normsignal(1,:),'-g','linewidth',3);
plot(output.normcount(1,:),'-b','linewidth',3);
set(gca,'XTick',1:n,'XTickLabel',regions);
xlabel('Brain Region','fontsize',20); ylabel('Log2( Data1 / Data2 )','fontsize',20);
title('R: Mean Cell Intensity   G: Norm Signal   B: Norm Count','fontsize',20);


function output = findstrfrag(string1,string2)

ls1 = length(string1);
ls2 = length(string2);

for i = 1:ls1 - ls2 + 1
    if strcmp(string1(i:i + ls2 - 1),string2) == 1
        output = 1;
        return;
    end
end
output = 0;

