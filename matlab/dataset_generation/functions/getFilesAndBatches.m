function [ file_map ] = getFilesAndBatches( dataset_dir, files_per_batch)
% This function returns a cell containing the internal structure of a 

    % read dataset path
    dataset_folder = dir(dataset_dir);
    
    
    % initialization of output variables
    map = {};                               % output folder map
    batch.path = '';                        % batch name (e.g. 'batch_00')
    batch.files = cell(files_per_batch,1);  % batch files in batch folder
    
    % loop over BATCHES
    for i = 3 : size(dataset_folder,1)
       
        % if the folder is a dataset batch...
        if contains(dataset_folder(i).name, 'batch')
            % ... and contains a label set
            if exist(fullfile(dataset_dir,dataset_folder(i).name, ...
                                                'labels_mat.mat'), 'file')
                                            
                batch_path = fullfile(dataset_dir, dataset_folder(i).name);
                batch.path = batch_path;
                batch_files = dir(fullfile(batch_path,'disp_color'));
                
                % loop over batches FILES
                for j = 3 : size(batch_files,1)
                
                    batch.files{j-2} = batch_files(j).name;
                    
                end
                
                map{i-2} = batch;
                
            end
        end        
    end
    
    file_map = map;
    
end

