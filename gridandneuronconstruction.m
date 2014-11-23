%also not a folder
%% visual representation of neurons
close all
clear
clc
%easy
easyNeuron=ones(5,7);
easyNeuron([7,9,13,18,23,28])=.5; easyNeuron(8)=0;
imagesc(easyNeuron); colormap gray; pbaspect([7 5 1]);
set(gca,'xtick',linspace(0.5,7.5,8),'ytick',linspace(0.5,5.5,6));
set(gca,'xgrid','on','ygrid','on','gridlinestyle','-');

%medium
medNeuron=ones(5,7);
medNeuron([8,12,18,23,24,28])=.5; medNeuron(13)=0;
figure; imagesc(medNeuron); colormap gray; pbaspect([7 5 1]);
set(gca,'xtick',linspace(0.5,7.5,8),'ytick',linspace(0.5,5.5,6));
set(gca,'xgrid','on','ygrid','on','gridlinestyle','-');

%hard
hardNeuron=ones(5,7);
hardNeuron([7,8,14,18,22,23,27])=.5; hardNeuron(13)=0;
figure; imagesc(hardNeuron); colormap gray; pbaspect([7 5 1]);
set(gca,'xtick',linspace(0.5,7.5,8),'ytick',linspace(0.5,5.5,6));
set(gca,'xgrid','on','ygrid','on','gridlinestyle','-');

%% Grid/neuron overlay construction

%easy 7x7 grid
nx=7; ny=7;
easyGrid=ones(nx,ny);
eShapeN = easyNeuron(2:4,2:6);
sizeN=size(eShapeN);
sizeG=size(easyGrid);
posVert=sizeG(1)-sizeN(1);
posHorz=sizeG(2)-sizeN(2);

vertShift=randi([0,posVert],1);
horzShift=randi([0,posHorz],1);

easyGrid((vertShift+[1:sizeN(1)]),(horzShift+[1:sizeN(2)]))=eShapeN;

nonAH=find(easyGrid == 1);
ehints=nonAH(randi([1,length(nonAH)],1,4));

easyGridDisp=zeros(nx,ny);
easyGridDisp(ehints)=easyGrid(ehints);

eXLabel=cell(1,(nx+1));
for i=1:(nx+1)
    eXLabel{i}=num2str(i-1);
end

eYLabel=cell(1,(ny+1));
for i=1:(ny+1)
    eYLabel{i}=num2str(i-1);
end

figure; imagesc(easyGridDisp)
pbaspect([nx ny 1]);
set(gca,'xtick',linspace(0.5,nx+0.5,nx+1),'ytick',linspace(0.5,ny+0.5,ny+1));
set(gca,'XTickLabel',eXLabel,'YTickLabel',eYLabel);
set(gca,'xgrid','on','ygrid','on','gridlinestyle','-');

%med 13x13 grid
nx=13; ny=13;
medGrid=ones(nx,ny);
mShapeN = medNeuron(2:4,2:6);
sizeN=size(mShapeN);
sizeG=size(medGrid);
posVert=sizeG(1)-sizeN(1);
posHorz=sizeG(2)-sizeN(2);

vertShift=randi([0,posVert],1);
horzShift=randi([0,posHorz],1);

medGrid((vertShift+[1:sizeN(1)]),(horzShift+[1:sizeN(2)]))=mShapeN;

nonNeuron=find(medGrid == 1);
mhints=nonNeuron(randi([1,length(nonAH)],1,4));

medGridDisp=zeros(nx,ny);
medGridDisp(mhints)=medGrid(mhints);

mXLabel=cell(1,(nx+1));
for i=1:(nx+1)
    mXLabel{i}=num2str(i-1);
end

mYLabel=cell(1,(ny+1));
for i=1:(ny+1)
    mYLabel{i}=num2str(i-1);
end

figure; imagesc(medGridDisp)
pbaspect([nx ny 1]);
set(gca,'xtick',linspace(0.5,nx+0.5,nx+1),'ytick',linspace(0.5,ny+0.5,ny+1));
set(gca,'XTickLabel',mXLabel,'YTickLabel',mYLabel);
set(gca,'xgrid','on','ygrid','on','gridlinestyle','-');

%hard 17x17 grid
nx=17; ny=17;
hardGrid=ones(nx,ny);
hShapeN = hardNeuron(2:4,2:6);
sizeN=size(hShapeN);
sizeG=size(hardGrid);
hposVert=sizeG(1)-sizeN(1);
hposHorz=sizeG(2)-sizeN(2);

hvertShift=randi([0,hposVert],1);
hhorzShift=randi([0,hposHorz],1);

hardGrid((hvertShift+[1:sizeN(1)]),(hhorzShift+[1:sizeN(2)]))=hShapeN;

nonNeuron=find(hardGrid == 1);
hhints=nonNeuron(randi([1,length(nonNeuron)],1,2));

hardGridDisp=zeros(nx,ny);
hardGridDisp(hhints)=hardGrid(hhints);

hXLabel=cell(1,(nx+1));
for i=1:(nx+1)
    hXLabel{i}=num2str(i-1);
end

hYLabel=cell(1,(ny+1));
for i=1:(ny+1)
    hYLabel{i}=num2str(i-1);
end

figure; imagesc(hardGridDisp)
pbaspect([nx ny 1]);
set(gca,'xtick',linspace(0.5,nx+0.5,nx+1),'ytick',linspace(0.5,ny+0.5,ny+1));
set(gca,'XTickLabel',hXLabel,'YTickLabel',hYLabel);
set(gca,'xgrid','on','ygrid','on','gridlinestyle','-');
