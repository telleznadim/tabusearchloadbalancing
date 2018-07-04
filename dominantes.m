function [menores,ivector] = dominantes(Cost,menores,i, ivector)
    
    if Cost(1)~=0
        [m,~] = size(menores);
        if m>=1
            
           j=1; 
           
           borrar = [];
           count=0;
           sw=true;
           while j <= m
                
                if (Cost(1) <= menores(j,1)) && (Cost(2) <= menores(j,2))
                    borrar = [borrar;j];
                elseif (Cost(1) >= menores(j,1)) && (Cost(2) >= menores(j,2))
                    sw=false;
                elseif (Cost(1) <= menores(j,1)) 
                    count = count +1;
                elseif (Cost(2) <= menores(j,2))
                    count = count +1;
                end
            j = j+1;
           end
           
           if sw
               if ~(isempty(borrar)) && count>0
                   menores(borrar,:)=[];
                   ivector(borrar) = [];
                   menores = [menores;Cost];
                   ivector =[ivector;i];
                   
               elseif ~(isempty(borrar))
                   menores(borrar,:)=[];
                   ivector(borrar) = [];
                   menores = [menores;Cost];
                   ivector =[ivector;i];
               elseif count>0
                   menores = [menores;Cost];
                   ivector =[ivector;i];
               end
           end
        end
    end
end
