
%% ------ Cloud Information ------
%       M       P    D          B               Per Hour
% CloudCost = [3.846  6.4  0.0044     1.7774
%              2      5    0.01       3       ];

CloudCost = [   1 1 1 1
                1 1 1 1
             ];

%            M       P      D       B           Per Hour
CapCloud = [32      20      5000     23
            16      30      20000    50];
        
NC = size(CloudCost,1);                         % Number of Cloud Nodes

%% ------- Fog Information ------
% FogCost = [ 0.05	0.06	0.0006	0.2
%             0.04	0.04	0.0008	0.25
%             0.05	0.06	0.0008	0.3
%             0.04	0.07	0.0006	0.25
%             0.05	0.05	0.0004	0.2
%             0.04	0.05	0.00035	0.1
%             0.05	0.06	0.0005	0.3
%             0.04	0.07	0.001	0.25
%             ];
% 
% FogCost = [ 1 1 1 1
%             1 1 1 1
%             1 1 1 1
%             1 1 1 1
%             1 1 1 1
%             1 1 1 1
%             1 1 1 1
%             1 1 1 1
%             ];
%         
 
FogCost = [ 0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            0.1 0.1 0.1 0.1
            ];
        
FogCost = FogCost * 2;
        
CapFog = [4     2   128     3
          4     2   256     4
          4     2   256     4
          4     2   128     3
          3     2   64      2
          2     2   64      2
          2     2   128     2
          4     2   512     6
          ];
      
NF = size(FogCost,1);                           % Number of Fog Nodes

%% ------ Task Information ------
% Random Big Tasks
NBTask = 4;
Task = [randi([2,4],1,NBTask);randi([2,6],1,NBTask);randi([200,2000],1,NBTask);randi([3,8],1,NBTask);randi(3,1,NBTask)];

% Random Small Tasks
NSTask = 15;
Task = [Task [randi([1,2],1,NSTask);randi(2,1,NSTask);randi([1,200],1,NSTask);randi(3,1,NSTask);round(1*rand(1,NSTask),1)]];

load('Task');

% Calculate the number of tasks
NTask = size(Task,2);

    for i=1:NTask
        Task([1:4],i) = Task([1:4],i)*Task(5,i);
    end