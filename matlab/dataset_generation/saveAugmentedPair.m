function [ ] = saveAugmentedPair(path, disp, mask, disp_name, mask_name )
%SAVEAUGMENTEDPAIR Summary of this function goes here
%   Detailed explanation goes here

    train_path = fullfile(path, 'train');
    label_path = fullfile(path, 'labels');

    if ~exist(path, 'dir')
        mkdir(path);
        mkdir(train_path);
        mkdir(label_path);            
    end
    
    mask_filename = fullfile(label_path, mask_name);
    disp_filename = fullfile(train_path, disp_name);
    
    imwrite(disp, disp_filename);
    imwrite(mask, mask_filename);
    
end

