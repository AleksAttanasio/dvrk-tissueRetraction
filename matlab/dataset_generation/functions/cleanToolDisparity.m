function [ ] = cleanToolDisparity( disp_dir, dim_th )
% This function removes automatically the labels with a percentage of pixel
% below dim_th (dimension threshold).
% Input:    - disp_dir: directory containing all the maps to check
%           - dim_th: dimension threshold for masks between 0 and 1. 
%                       -> dim_th = 0 => all images are kept
%                       -> dim_th = 1 => only full masks are allowed
%                       (very restrictive)

list = dir(disp_dir);
pixel_count = 0;

for i = 3 : size(list,1)
    
    curr_img = imread(fullfile(disp_dir, list(i).name));
    max_size = size(curr_img,1) * size(curr_img,2);

    for k = 1 : size(curr_img,1)
       for j = 1 : size(curr_img, 2)
            
           if sum(curr_img(k,j,:)) ~= 0
              
               pixel_count = pixel_count + 1;
               
           end
           
       end
    end
    
    if (pixel_count / max_size) < dim_th
       
        delete(fullfile(disp_dir, list(i).name));
        
    end
    
    pixel_count = 0;
        

end



end

