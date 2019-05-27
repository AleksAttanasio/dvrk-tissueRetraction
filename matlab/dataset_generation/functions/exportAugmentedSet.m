function [ ] = exportAugmentedSet( aug_set, folder_path )
%EXPORTAUGMENTEDSET Summary of this function goes here
%   Detailed explanation goes here

for i = 1 : size(aug_set,1)
   
        disp_img = aug_set{i,1};
        mask_img = aug_set{i,2};
        
        file_num = num2str(num2str(i, '%05.f%'));
        
        disp_img_file = strcat('aug_disp_', file_num,'.jpeg');
        mask_img_file = strcat('aug_tissue_mask_', file_num,'.png');
        
        disp_folder = fullfile(folder_path, 'aug_disp_color');
        mask_folder = fullfile(folder_path, 'aug_tissue_mask');
        
        % if folder doesn't exist create it
        if ~exist(disp_folder, 'dir')
            mkdir(disp_folder);      
        end
        
        if ~exist(mask_folder, 'dir')
            mkdir(mask_folder);      
        end
        
        imwrite(disp_img, fullfile(disp_folder, disp_img_file));
        imwrite(mask_img, fullfile(mask_folder, mask_img_file));
        
end


end

