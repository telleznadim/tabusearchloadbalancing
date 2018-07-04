function [x, A, f, Z1, Z2,CostF, CostZ1, CostZ2] = CloudFogOptimization(CloudCost,CapCloud,FogCost,CapFog,Task, NTask, NC, NF, alfa,alfa2)
    %% ------- Create the Cost Function function -------
    f = [reshape(shiftdim(CloudCost*Task([1:4],:),1),[],1);reshape(shiftdim(FogCost*Task([1:4],:),1),[],1)]; % length NC*NF*NTask
    
    f(1:NC*NTask) = f(1:NC*NTask)*(alfa2);
    f(NC*NTask+1:NF*NTask+(NC*NTask)) = f(NC*NTask+1:NF*NTask+(NC*NTask))*(alfa);
    
    lengthf = length(f);
    Z2 = f(1:NC*NTask);
    Z1 = f(NC*NTask+1:NF*NTask+(NC*NTask));
    
    tasks = [Task([1:4],:) zeros(4,lengthf-NTask)]; %
    A = tasks;
    for i=1:NC+NF-1
        tasks = circshift(tasks, [0 NTask]);
        A = [A;tasks];
    end

    b = [reshape(shiftdim(CapCloud,1),1,[]) reshape(shiftdim(CapFog,1),1,[])];


    Aeq = zeros(NTask,lengthf);
    position = 1;
    for i=1:NF+NC-1
        position = [position (i*(NTask))+1];
    end
    for i=0:NTask-1
        Aeq(i+1,position+i)=1;
    end

    beq = ones(NTask,1);
    intcon = [1:lengthf];
    lb = zeros(lengthf,1);
    ub = ones(lengthf,1);
    
    %% Run the Optimization
    options = optimoptions('intlinprog','Display','off');
    x =  intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,options);
    
    CostF = f'*x;
    CostZ2 = Z2'*x(1:NC*NTask);
    CostZ1 = Z1'*x(NC*NTask+1:NF*NTask+(NC*NTask));
    
end
