function [ extracted_tools ] = extractToolsFromBatches( labels_batch, batch_map )
% This function extract tools given a label set and a batch map of the
% folder containing the labels set. The right format of the two variables
% are:  - labels_batch = groundTruth
%       - batch_map = cell{struct}

    extracted_tools = cell(0);
    
    % for loop over BATCHES
    for i = 1 : size(labels_batch,2)
        
        % for loop over LABELS
        for k = 1 : size(labels_batch(i).LabelData,1)
            
            % if the tool label is not empty
            if ~isempty(labels_batch(1,i).LabelData.tool{k,1})
                
                % load disparity map
                disp_map = imread(fullfile(batch_map{i}.path, ...
                    'disp_color_crop', batch_map{i}.files{k}));
                
                tool_mask = getMask(labels_batch, 'tool', 25, i, k);
                tool_mask = cropMask(tool_mask);
                tools = extractToolsFromSingleImage(disp_map, tool_mask);
                
                extracted_tools{end+1} = tools;
                
            end
            
        end
        
    end
    
    extracted_tools = extracted_tools';
end

