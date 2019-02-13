%% init 

clc 
clear all

masks_path = 'dataset/masks/';
rgb_path = 'dataset/cropped/';
destination_folder = 'test_resize/';

addpath(masks_path)
addpath(rgb_path)

%% proc

n_data = 1000;

for i = 0 : n_data
    
%     left_img_name = strcat('left_', num2str(i, '%05.f%'),'.jpeg');
%     right_img_name = strcat('right_', num2str(i, '%05.f%'),'.jpeg');
    disp_img_name = strcat('disp_', num2str(i, '%05.f%'),'.jpeg');
    tissue_mask_name = strcat('tissue_mask_', num2str(i, '%05.f%'),'.png');
%     tool_mask_name = strcat('tool_mask_', num2str(i, '%05.f%'),'.png');
%     idk_mask_name = strcat('idk_mask_', num2str(i, '%05.f%'),'.png');

%     I_left = imread(strcat('unproc_dataset/left/',left_img_name));
%     I_right = imread(strcat('unproc_dataset/right/',right_img_name));
    I_disp = imread(strcat(rgb_path,'disp_color/',disp_img_name));
    I_tissue_masks = imread(strcat(masks_path,'tissue_masks/',tissue_mask_name));
%     I_tool_masks = imread(strcat(masks_path,'tool_masks',disp_img_name));
%     I_idk_masks = imread(strcat(masks_path,'idk_masks',disp_img_name));
    
    I_disp = imresize(I_disp, [448,480]);
    I_tissue_masks = imresize(I_tissue_masks, [448,480]);

%     imwrite(I_left, strcat(destination_folder, 'cropped/left/', left_img_name));
%     imwrite(I_right, strcat(destination_folder, 'cropped/right/', right_img_name));
    imwrite(I_disp, strcat(destination_folder, 'disp_color/', disp_img_name));
    imwrite(I_tissue_masks, strcat(destination_folder, 'tissue_masks/', tissue_mask_name));
%     imwrite(I_tool_masks, strcat(destination_folder, 'masks/tool_masks/', tool_mask_name));
%     imwrite(I_idk_masks, strcat(destination_folder, 'masks/idk_masks/', idk_mask_name));
%     
end
