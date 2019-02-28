function [ labels ] = loadBatchLabels( dataset_dir, num_batches)
    labels_map = [];
    list = dir(dataset_dir);
    
    % error in case of exceeding dimensions for the batch number to load
    if (num_batches > size(list,1))
        error('The number of batches selected exceeds the size.')
        return
    end
    
    % roll over all the labels and merge them into levels_map
    for i = 3 : (num_batches + 2) % +2 to skip the first two list elements

        load(strcat(dataset_dir,list(i).name,'/labels_mat.mat'));
        labels_map = [labels_map, gTruth];

    end
    
    labels = labels_map;
end

