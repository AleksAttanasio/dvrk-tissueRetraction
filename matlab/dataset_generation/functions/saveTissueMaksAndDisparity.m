function [ ] = saveTissueMaksAndDisparity( path, train, mask, img_name, train_name, mask_name )
% This function saves the extracted tool disparity maps in a folder.
% Inputs:   - path: path of the destination folder for the data
%           - diparity: disparity image to save
%           - img_name: original image name (used to get a compliant filename)
%           - mask_name: name of the mask to be given the filename
% Note: the final filename is <mask_name> + <img_name>.number

    train_path = fullfile(path, 'train');
    label_path = fullfile(path, 'labels');

    if ~exist(path, 'dir')
        mkdir(path);
        mkdir(train_path);
        mkdir(label_path);            
    end

    num_mask = split(img_name,{'.','_'});
    num_mask = num_mask{2};
    
    imwrite(train, fullfile(train_path,strcat(train_name, num_mask,'.jpeg')));
    imwrite(mask, fullfile(label_path, strcat(mask_name,num_mask,'.png')))



end

