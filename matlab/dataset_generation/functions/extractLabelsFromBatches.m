function [ labels ] = extractLabelsFromBatches( dataset_dir, batches )
%EXTRACTLABELSFROMBATCHES Summary of this function goes here
%   Detailed explanation goes here

labels = [];

for i = 1:size(batches, 1)
    
    current_labels = load(fullfile(dataset_dir,batches(i).name,'labels_mat.mat'));
    labels = [labels , current_labels];
    
end

labels = labels';


end

