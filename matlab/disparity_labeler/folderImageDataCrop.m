function [ ] = folderImageDataCrop( dataset_dir )
% This function crops images in all the batches of a shuffled set. In order
% to create a folder of cropped disparity images copy the original
% disp_color folder and rename it to disp_color_crop

    dataset_folder = dir(dataset_dir);

    % loop over BATCHES
    for i = 3 : size(dataset_folder,1)
       
        % if the folder is a dataset batch...
        if contains(dataset_folder(i).name, 'batch')
            % ... and contains a label set
            if exist(fullfile(dataset_dir,dataset_folder(i).name, ...
                                                'labels_mat.mat'), 'file')
                                            
                 imageDataCrop(fullfile(dataset_dir,dataset_folder(i).name, ...
                                            'disp_color_crop'));                           
                
            end
        end        
    end

end

