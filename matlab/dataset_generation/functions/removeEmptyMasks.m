function [ ] = removeEmptyMasks( origin_dir )

    list = dir(origin_dir);
    
    for i = 3 : size(list,1)
       
        filename = strcat(origin_dir, list(i).name);
        curr_I = imread(filename);
        
        if (sum(curr_I(:)) == 0)
           
            delete(filename)
            
        end
        
    end
end

