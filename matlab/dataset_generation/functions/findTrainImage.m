function [ img_name, train_img ] = findTrainImage( dataset_dir, batches, k, i )
%FINDTRAINIMAGE Summary of this function goes here
%   Detailed explanation goes here

    current_file_dir = fullfile(dataset_dir,batches(k).name,'disp_color_crop');
    train_filenames = dir(current_file_dir);
    train_img = imread(fullfile(current_file_dir, train_filenames(i+2).name));
    img_name = train_filenames(i+2).name;

end

