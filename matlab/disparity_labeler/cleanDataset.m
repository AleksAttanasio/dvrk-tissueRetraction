function [ ] = cleanDataset( mask_folder, thresh )

    list = dir(mask_folder);
    c_idx = 3; % current index
    
    while exist(strcat(mask_folder,list(c_idx + 1).name),'file')
        
        current_I_name = strcat(mask_folder,list(c_idx).name);
        next_I_name = strcat(mask_folder,list(c_idx + 1).name);
        
        current_I = imread(current_I_name);
        next_I = imread(next_I_name);
        
        if (ssim(current_I, next_I) <= thresh)
            
            c_idx = c_idx + 1;
            
        end
        
        if (ssim(current_I, next_I) > thresh)
            
            delete(next_I_name);
            
        end
        
        list = dir(mask_folder);
        
    end

end

