clear all;
close all;
clc;

%% Load Data from Data.m
Data;

%% Inicializar proceso y variables
alfa = 0.5;
alfa2 = 1-alfa;
menores = zeros(20,2)+inf;
ivector = zeros(20,1)+inf;

%% Inicialización del Loop
for i=1:1000
    i
    alfavector(i) = alfa;
    alfavector2(i) = alfa2;
    %% Optimización
    [x, A, f, Z1, Z2, CostF, CostZ1, CostZ2] = CloudFogOptimization(
    CloudCost,CapCloud,FogCost,CapFog,Task, NTask, NC, NF, alfa,alfa2);
    Cost(i, 1)=CostZ1;
    Cost(i,2)=CostZ2;
    xvector(:,i) = x;
    Avector(:,:,i) = A;
    fvector(:,i) = f;
    
    %% Cálculo del Pareto óptimo
    [menores,ivector] = dominantes(Cost(i,:),menores,i, ivector);

    %% Actualización del alpha
    alfaupdate = alfa + (rand*2-1);
    while (alfaupdate<0 | alfaupdate>1)
            alfaupdate = alfa + (rand*2-1);
    end
    alfa = alfaupdate;
    alfa2 = 1-alfa;
    
end

%% Seleccionar los primeros 30 mayores de Z1
minindices = [menores ivector];
[ordenados,indices] = sort(minindices);
minindices = minindices(indices(:,2),:);
ivectorsorted = minindices([1:30],3);

% X = [1:-0.05:0]*CostZ2;
% Y = [0:0.05:1]*CostZ1;
% plot(X,Y,'+:');
% xlabel('Z2 Cost');
% ylabel('Z1 Cost');
% text(X(1),Y(1),' \leftarrow  \alpha = 0', 'FontSize',12);
% text(X(length(X)),Y(length(Y)),' \leftarrow  \alpha = 1', 'FontSize',12);
% title('\alpha Z1 + (1-\alpha) Z2');


% figure;
% stem(Cost(:,1),Cost(:,2))
% xlabel('Z1 Cost');
% ylabel('Z2 Cost');
% title('\alpha Z1 + (1-\alpha) Z2');
 
%  figure;
%  subplot(2,1,1);
%  stem(alfavector,Cost(:,2));
%  title('Z1 Cost');
%  xlabel('\alpha');
%  ylabel('Cost');
%  
%  subplot(2,1,2);
%  stem(alfavector,Cost(:,1));
%  title('Z2 Cost');
%  xlabel('\alpha');
%  ylabel('Cost');
%  
%  figure
%  stem(alfavector,(Cost(:,1)+Cost(:,2)));
%  title('Total Cost');
%  xlabel('\alpha');
%  ylabel('Cost');
%  
%  figure
%  stem(1:length(alfavector),alfavector);
%  title('\alpha variation');
%  xlabel('number');
%  ylabel('\alpha');

figure;
stem(menores(:,1),menores(:,2));
xlabel('Z1 Cost');
ylabel('Z2 Cost');
title('\alpha Z1 + (1-\alpha) Z2');


figure;
stem(alfavector(ivector),menores(:,1));
xlabel('\alpha');
ylabel('Z1 Cost');
title('\alpha vs Z1 Cost');

figure;
stem(alfavector(ivector),menores(:,2));
xlabel('\alpha');
ylabel('Z2 Cost');
title('\alpha vs Z2 Cost');


figure;
stem(minindices([1:30],1),minindices([1:30],2))
xlabel('Z1 Cost');
ylabel('Z2 Cost');
title('\alpha Z1 + (1-\alpha) Z2 Dominants (30)');

figure;
stem(alfavector(ivectorsorted),minindices([1:30],1));
xlabel('\alpha');
ylabel('Z1 Cost');
title('\alpha vs Z1 Cost (30)');

figure;
stem(alfavector(ivectorsorted),minindices([1:30],2));
xlabel('\alpha');
ylabel('Z2 Cost');
title('\alpha vs Z2 Cost (30)');

figure;
stem([1:length(alfavector)],alfavector);
xlabel('Iteration');
ylabel('\alpha');
title('\alpha variation');
 


for j=1:length(ivectorsorted)
    j
    ivectorsorted(j)
    PrintOptimization(CapCloud, CapFog, xvector(:,ivectorsorted(j)), Avector(:,:,ivectorsorted(j)), Task, fvector(:,ivectorsorted(j)), NTask, NC, NF);
 
end

 