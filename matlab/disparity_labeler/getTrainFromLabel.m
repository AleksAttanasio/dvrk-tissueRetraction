function [ ] = getTrainFromLabel( masks_dir , class_train, train_dir)
%GETTRAINFROMLABEL Summary of this function goes here
%   Detailed explanation goes here

    list = dir(masks_dir);
    origin = strsplit(masks_dir, '/');
    
    dest_folder = strcat( origin{1},'/training_set/');
    
    if ~exist(dest_folder,'dir')
        mkdir(dest_folder);
    end
    
    for i = 3 : size(list,1)
       
        split_name = strsplit(list(i).name, {'_', '.'});
        
        file_name = strcat(train_dir, class_train, '_', split_name{end - 1},'.jpeg');
        
        I_train = imread(file_name);
 
        imwrite(I_train, strcat(dest_folder,class_train,'_',split_name{end - 1},'.jpeg'));
       
    end

end

