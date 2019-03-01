function [ aug_set ] = createAugmentedSet( labels_batch, batch_map, tools_disp )

aug_set = cell(0);

    % for loop over BATCHES
    for i = 1 : size(labels_batch,2)
        
        % for loop over LABELS
        for k = 1 : size(labels_batch(i).LabelData,1)
            
            % if the tool label is not empty
            if isempty(labels_batch(1,i).LabelData.tool{k,1}) && ...
                    ~isempty(labels_batch(1,i).LabelData.tissue{k,1})
                
                % load disparity map
                disp_map = imread(fullfile(batch_map{i}.path, ...
                    'disp_color_crop', batch_map{i}.files{k}));
                
                % load tissue_mask
                tissue_mask = getMask(labels_batch, 'tissue', 25, i, k);
                tissue_mask = cropMask(tissue_mask);
                
                % select random tools
                rnd_tools = tools_disp{randi([1,size(tools_disp,1)])};
                
                % flip them
                flip_rnd_tools = randomFlipSingleImage(rnd_tools);
                
                % overlap tools over the disparity map
                over_disp = overlapToolsDisp(disp_map, flip_rnd_tools);
                
                [aug_tissue_mask, aug_over_disp] = randomFlipImageCouple(...
                    tissue_mask, over_disp);
                
                % save augmented images
                aug_set{end+1,1} = aug_over_disp;
                aug_set{end,2} = aug_tissue_mask;
                
            end
            
        end
        
    end


end

