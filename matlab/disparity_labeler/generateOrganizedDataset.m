%% init 

clc
clear all

% this routine takes as input the dataset batch folder created by
% shuffleLabellingDataset() and returns the masks of the batches unified or
% not (depending on unify_flag) into a folder.

dataset_dir = 'data/10x100_shuffle_over_10k/';
addpath(dataset_dir) % main shuffle folder

%% proc

list_batches = dir('data/10x100_shuffle_over_10k/');
dest_folder = strcat(dataset_dir, 'tissue_masks');

unify_flag = 0; % unify masks in one folder (1) or divide them into bathces
I = uint8(zeros(576,720,3));

% loading batch labels
labels = loadBatchLabels(dataset_dir, list_batches, 5);

% if destination folder doesn't exist create it
if ~exist(dest_folder, 'dir')
    mkdir(dest_folder);      
end
                
% --- EXTRACT MASKS
% for loop to roll over labels batches
for k = 1 : size(labels,2) 
    
    %for loop to roll over different labels
    for i = 1 : size(labels(k).LabelData,1)
        
        mask = zeros(576,720,3);  % empty mask to be filled
        
        if ~isempty(labels(k).LabelData.tissue{i,1})
            
            % for loop to roll over different instance of same label
            for j = 1 : size(labels(k).LabelData.tissue{i,1} , 1)
            
                % retrieve roi point coordinates
                r = labels(k).LabelData.tissue{i,1}{j,1}(:,1);
                c = labels(k).LabelData.tissue{i,1}{j,1}(:,2);
                
                % create, smooth and overlap mask
                BW = roipoly(I,r,c);                
                smooth_BW = smoothMask(BW, 25);
                mask = imoverlay(mask, smooth_BW, 'white');
                
                % find correct file name
                list_file = dir(strcat(dataset_dir,list_batches(k+2).name,'/disp_color'));
                split_file = strsplit(list_file(i).name, {'_', '.'});
                mask_name = strcat('tissue_mask_', split_file{2} ,'.png');
                
                mask_file = strcat(dest_folder, '/', mask_name);
                imwrite(mask, mask_file);
                
            end
        end
    end
end