function [ dataset ] = getValidBatches( dataset_dir )
%GETVALIDBATCHES Summary of this function goes here
%   Detailed explanation goes here
dataset_folder = dir(dataset_dir);
dataset = [];

for i = 1:size(dataset_folder,1)
    
   current_folder_name = dataset_folder(i).name;
   
    if(contains(current_folder_name,'batch'))
        if exist(fullfile(dataset_dir, dataset_folder(i).name, 'labels_mat.mat'), 'file') == 2
            
            dataset = [dataset ; dataset_folder(i)];
            
        end
    end
end


end

