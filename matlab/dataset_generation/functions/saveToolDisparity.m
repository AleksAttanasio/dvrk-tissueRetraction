function [ ] = saveToolDisparity( path, disparity, img_name, mask_name)
% This function saves the extracted tool disparity maps in a folder.
% Inputs:   - path: path of the destination folder for the data
%           - diparity: disparity image to save
%           - img_name: original image name (used to get a compliant filename)
%           - mask_name: name of the mask to be given the filename
% Note: the final filename is <mask_name> + <img_name>.number

    label_path = fullfile(path, 'disparity_maps');

    if ~exist(path, 'dir')
        mkdir(path);
        mkdir(label_path);            
    end

    num_mask = split(img_name,{'.','_'});
    num_mask = num_mask{2};
    
    imwrite(disparity, fullfile(label_path, strcat(mask_name,num_mask,'.jpeg')))



end

