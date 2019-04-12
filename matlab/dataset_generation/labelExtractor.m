function [ ] = labelExtractor( class, dest_dir )
% The function extract the train imges and relative labels of the dataset
% defined by the 'class' parameter.
% Inputs:   - class (type of dataset, could be 'lobe1', 'lobe2' or 'cyst1'
%           - dest_dir (destination folder for saving the dataset)
%
% Please note that the dataset will be saved in 'dest_dir/<class>_dataset'


addpath('functions')
if class == 'lobe1'
   dataset_dir = 'data/lobe1_10x100_shuffle';
elseif class == 'lobe2'
   dataset_dir = 'data/lobe2_10x100_shuffle';
elseif class == 'cyst1'
    dataset_dir = 'data/cyst_49x100_shuffle';
else
    error('The class you choose does not exist. Please use lobe1, lobe2 or cyst1')
end

batches = getValidBatches(dataset_dir);
labels = extractLabelsFromBatches(dataset_dir, batches);

% k = number of batch
for k = 1: size(labels, 1)
   
    % number of training in the batch
    for i = 1 : size(labels(k).gTruth.LabelData, 1)

        % Check if at least one label is available
        if ~isempty(labels(k).gTruth.LabelData.tissue{i,1}) || ...
                ~isempty(labels(k).gTruth.LabelData.tool{i,1})
                
            % Extract tissue mask
            if ~isempty(labels(k).gTruth.LabelData.tissue{i,1})
                tissue_mask = extractClassMask(labels, 'tissue', k, i, 'white');
            end

            complete_mask = cropMask(tissue_mask);
            
            tissue_mask = zeros(576,720,3);
            [img_name, train_img] = findTrainImage(dataset_dir, batches, k, i);
            
            % save file in folder
            path = fullfile(dest_dir,strcat(class, '_dataset'));
            saveTrainAndMask(path, train_img, complete_mask, img_name, ...
                                    strcat('disp_', class, '_'), ...
                                    strcat('mask_', class, '_'));
                                
        end
    end
end
end

