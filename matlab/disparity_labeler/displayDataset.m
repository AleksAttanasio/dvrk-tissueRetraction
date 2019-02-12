%% init
clc
clear all
masks_path = 'dataset/augmented/masks/';
rgb_path = 'dataset/augmented/cropped/';

addpath(masks_path);
addpath(rgb_path);

%%
n_disp = 6;
rnd_idx = randi([1000,3000],n_disp,1);
imgs = cell(n_disp,n_disp);

for i = 1 : n_disp
   
    I_left = imread(strcat(rgb_path, 'left_aug/left_', num2str(rnd_idx(i), '%05.f%'),'.jpeg'));
    I_right = imread(strcat(rgb_path, 'right_aug/right_', num2str(rnd_idx(i), '%05.f%'),'.jpeg'));
    I_disp = imread(strcat(rgb_path, 'disp_color_aug/disp_', num2str(rnd_idx(i), '%05.f%'),'.jpeg'));
    I_mask_tissue = imread(strcat(masks_path, 'tissue_masks_aug/tissue_mask_', num2str(rnd_idx(i), '%05.f%'),'.png'));
    I_mask_tool = imread(strcat(masks_path, 'tool_masks_aug/tool_mask_', num2str(rnd_idx(i), '%05.f%'),'.png'));
    I_mask_idk = imread(strcat(masks_path, 'idk_masks_aug/idk_mask_', num2str(rnd_idx(i), '%05.f%'),'.png'));


    imgs{i,1} = I_left;
    imgs{i,2} = I_right;
    imgs{i,3} = I_disp;
    imgs{i,4} = I_mask_tissue;
    imgs{i,5} = I_mask_tool;
    imgs{i,6} = I_mask_idk;

end

%% display

n_row = 4;
n_col = 6;
index = 1;

for k = 1 : n_row
    for j = 1 : n_col
        
        subplot(n_row,n_col , index)
        imshow(imgs{k , j})
        index = index + 1;
        
    end
end