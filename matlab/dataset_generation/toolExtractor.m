function [ ] = toolExtractor( class, dest_dir )
% The function extract the tools from disparity maps.
% Inputs:   - class (type of dataset, could be 'lobe1', 'lobe2' or 'cyst1'
%           - dest_dir (destination folder for saving the dataset)
%
% Note that the dataset will be saved in 'dest_dir/<class>_disparity_maps'

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
        if ~isempty(labels(k).gTruth.LabelData.tool{i,1})
                
            % Extract tool mask
            if ~isempty(labels(k).gTruth.LabelData.tool{i,1})
                tool_mask = extractClassMask(labels, 'tool', k, i, 'white');      
            end

            complete_mask = cropMask(tool_mask);
            [img_name, train_img] = findTrainImage(dataset_dir, batches, k, i);
            cut_tool_mask = cutToolFromDisparity(complete_mask,train_img);
            
            % save file in folder
            path = fullfile(dest_dir,strcat(class, '_tool_disparity'));
            
            saveToolDisparity(path, cut_tool_mask, img_name, ...
                                strcat('disp_tool_', class, '_'));
                                
        end
    end
end


end

