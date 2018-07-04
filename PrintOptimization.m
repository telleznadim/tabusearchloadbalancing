function p = PrintOptimization(CapCloud,CapFog,x ,A, Task, f, NTask, NC, NF)
lengthf = length(f);
    
CloudPFog = [reshape(shiftdim(CapCloud(:,[1:4]),1),[],1);reshape(shiftdim(CapFog(:,[1:4]),1),[],1)];
CloudPFog = [CloudPFog floor(CloudPFog - (A*x))];
CloudPFog = [CloudPFog CloudPFog(:,2)./CloudPFog(:,1)*100 (CloudPFog(:,1)-CloudPFog(:,2))./CloudPFog(:,1)*100];
CloudPFogTable = array2table(CloudPFog,'VariableNames',{'Capacity', 'Available','Avail_Perc','Used_Perc'});

onlyones = true;
countf = 1;
countdevices = 1;
while countf <= lengthf
    countCloud = 1;
    while countCloud <= NC
        countTask = 1;
        disp(sprintf('C%d',countCloud));
        while countTask <= NTask
                if onlyones
                    if round(x(countf)) == 1
                        disp(sprintf('T%d=>C%d = %d',countTask,countCloud,round(x(countf))));
                        
                    end
                else
                    disp(sprintf('T%d=>C%d = %d',countTask,countCloud,round(x(countf))));
                end
                countTask = countTask + 1;
                countf = countf + 1;
                
        end
        disp(CloudPFogTable([countdevices:countdevices + 3],:))
        countdevices = countdevices + 4;
        countCloud = countCloud + 1;
        countTask = 1;
    end
    
    countFog = 1;
    while countFog <= NF
        disp(sprintf('F%d',countFog));
        while countTask <= NTask
            if onlyones
                if round(x(countf)) == 1
                    disp(sprintf('T%d=>F%d = %d',countTask,countFog,round(x(countf))));
                end
            else
                disp(sprintf('T%d=>F%d = %d',countTask,countFog,round(x(countf))));
            end
                
            countTask = countTask + 1;
            countf = countf + 1;
        end
        
        disp(CloudPFogTable([countdevices:countdevices + 3],:))
        countdevices = countdevices + 4;
        countFog = countFog + 1;
        countTask = 1;
    end
          
end

disp(array2table(Task,'RowNames',{'CPU','Memory','Disk','BandWidth','Time'}));


end

