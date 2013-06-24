function histo_plot(input,n)

data1 = sort(input.data1{n}.cells);
data2 = sort(input.data2{n}.cells);

y1 = (1:length(data1)) / length(data1);
y2 = (1:length(data2)) / length(data2);

bins = -0.4:0.02:0;
h1 = hist(data1,bins); h1 = h1 / sum(h1);
h2 = hist(data2,bins); h2 = h2 / sum(h2);

figure('Color','w');
subplot(1,2,1); hold on; set(gca,'fontsize',20);
plot(data1,y1,'-b','linewidth',3);
plot(data2,y2,'-r','linewidth',3);
xlabel('Cell Intensity'); ylabel('Cumulative Fraction');
title(['B: Data1   R: Data2   Region: ',num2str(n)]);


subplot(1,2,2); hold on; set(gca,'fontsize',20);
plot(bins,h1,'-b','linewidth',3);
plot(bins,h2,'-r','linewidth',3);
xlabel('Cell Intensity');
ylabel('Fraction Population');
