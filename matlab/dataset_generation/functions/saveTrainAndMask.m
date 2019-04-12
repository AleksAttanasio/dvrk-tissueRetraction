function [ ] = saveTrainAndMask( path, train, mask, img_name, train_name, mask_name)
%SAVETRAINANDMASK Summary of this function goes here
%   Detailed explanation goes here

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

