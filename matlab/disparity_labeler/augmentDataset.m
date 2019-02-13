%% init

clear all
clc

addpath('dataset');

max_aug = 6; % maximum allowed single image augmentation 
num_image_dataset = 1000; % number of images contained in the baseline data
aug_map = [0:1:num_image_dataset;zeros(1,num_image_dataset + 1)]'; % map to keep track of augmentation
img_cnt = 1001; %end of the baseline dataset
target_num = 5000; % number of images to create

% dataset root folder paths
cropped_path = 'dataset/cropped/';
masks_path = 'dataset/masks/';
destination_path = 'dataset/augmented/';

% masks paths
tissue_path = strcat(masks_path,'tissue_masks/');
tool_path = strcat(masks_path,'tool_masks/');
idk_path = strcat(masks_path, 'idk_masks/');

% rgb images paths
left_path = strcat(cropped_path, 'left/');
right_path = strcat(cropped_path, 'right/');
disp_path = strcat(cropped_path, 'disp_color/');

% destination folder
dest_tissue_path = strcat(destination_path,'masks/tissue_masks_aug/');
dest_tool_path = strcat(destination_path,'masks/tool_masks_aug/');
dest_idk_masks = strcat(destination_path, 'masks/idk_masks_aug/');
dest_left_path = strcat(destination_path, 'cropped/left_aug/');
dest_right_path = strcat(destination_path, 'cropped/right_aug/');
dest_disp_path = strcat(destination_path, 'cropped/disp_color_aug/');

%% proc

while (img_cnt <= target_num)
    index = randi([0, 1000],1,1); % image index to augment
    hor_flip_flag = randi([0,1],1,1); % horizontal flipping flag
    ver_flip_flag = randi([0,1],1,1); % vergical flipping flag
    
    I_mask_tissue = imread(strcat(tissue_path,'tissue_mask_',num2str(index, '%05.f%'),'.png'));
    I_mask_tool = imread(strcat(tool_path,'tool_mask_',num2str(index, '%05.f%'),'.png'));
    I_mask_idk = imread(strcat(idk_path,'idk_mask_',num2str(index, '%05.f%'),'.png'));
    I_RGB_left = imread(strcat(left_path,'left_',num2str(index, '%05.f%'),'.jpeg'));
    I_RGB_right = imread(strcat(right_path,'right_',num2str(index, '%05.f%'),'.jpeg'));
    I_RGB_disp = imread(strcat(disp_path,'disp_',num2str(index, '%05.f%'),'.jpeg'));
    
    % Check for horizontal flag and in case, flip image
    if(hor_flip_flag == 1)
        
        I_mask_tissue = flip(I_mask_tissue,2);
        I_mask_tool = flip(I_mask_tool,2);
        I_mask_idk = flip(I_mask_idk,2);
        I_RGB_left = flip(I_RGB_left,2);
        I_RGB_right = flip(I_RGB_right,2);
        I_RGB_disp = flip(I_RGB_disp,2);
        
    end
    
    % Check for vertical flag and in case, flip image
    if(ver_flip_flag == 1)
        
        I_mask_tissue = flip(I_mask_tissue,1);
        I_mask_tool = flip(I_mask_tool,1);
        I_mask_idk = flip(I_mask_idk,1);
        I_RGB_left = flip(I_RGB_left,1);
        I_RGB_right = flip(I_RGB_right,1);
        I_RGB_disp = flip(I_RGB_disp,1);
        
    end
    
    % translation factor random
    max_trans = 60;
    im_trans = [randi([-max_trans,max_trans],1,1),randi([-max_trans,max_trans],1,1)];
    
    % shift image
    I_mask_tissue = imtranslate(I_mask_tissue,im_trans);
    I_mask_tool = imtranslate(I_mask_tool,im_trans);
    I_mask_idk = imtranslate(I_mask_idk,im_trans);
    I_RGB_left = imtranslate(I_RGB_left,im_trans);
    I_RGB_right = imtranslate(I_RGB_right,im_trans);
    I_RGB_disp = imtranslate(I_RGB_disp,im_trans);
    
    imwrite(I_mask_tissue, strcat(dest_tissue_path, 'tissue_mask_',...
                                num2str(img_cnt, '%05.f%'), '.png'));
    imwrite(I_mask_tool, strcat(dest_tool_path, 'tool_mask_',...
                                num2str(img_cnt, '%05.f%'), '.png'));
    imwrite(I_mask_idk, strcat(dest_idk_masks, 'idk_mask_',...
                                num2str(img_cnt, '%05.f%'), '.png'));
    imwrite(I_RGB_left, strcat(dest_left_path, 'left_',...
                                num2str(img_cnt, '%05.f%'), '.jpeg'));
    imwrite(I_RGB_right, strcat(dest_right_path, 'right_',...
                                num2str(img_cnt, '%05.f%'), '.jpeg'));
    imwrite(I_RGB_disp, strcat(dest_disp_path, 'disp_',...
                                num2str(img_cnt, '%05.f%'), '.jpeg'));
    
    img_cnt = img_cnt + 1;
end










