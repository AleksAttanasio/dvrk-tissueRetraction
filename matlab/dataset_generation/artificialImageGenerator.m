function [ ] = artificialImageGenerator( tissue_dir, tool_dir, n_aug )

addpath('functions')

lb_dir = fullfile(tissue_dir,'labels');
lb_list = dir(lb_dir);

tr_dir = fullfile(tissue_dir,'train');
tr_list = dir(tr_dir);

tool_list = dir(tool_dir);

for i = 3 : size(lb_list,1)

    curr_train = tr_list(i).name;
    curr_label = lb_list(i).name;
    
    disp = imread(fullfile(tr_dir, curr_train));
    mask = imread(fullfile(lb_dir, curr_label));
    
    for k = 1 : n_aug
        
        % transformation parameters
        flip_direction = randi([1,2]);  % random flip v/h
        rnd_ang = randi([-45,45]);      % random rotation angle
        over_tool = tool_list(randi([3,size(tool_list,1)])).name; % tool
        double_flip = round(rand);      % random flag for double flip
        
        tool_disp = imread(fullfile(tool_dir,over_tool)); % tool disparity
        aug_img = overlapToolsDisp(disp, tool_disp);      % aug_img
        
        % random flip 
        [flip_disp, flip_mask] = randomFlipPair(aug_img, mask, ...
                                            flip_direction, double_flip);
        
        % random rotation of flipped image
        rot_disp = imageAugmentRotation(flip_disp, rnd_ang);
        rot_mask = imageAugmentRotation(flip_mask, rnd_ang);
        
        disp_name = strcat('aug_', num2str(k, '%02.f%'), '_', curr_train);
        mask_name = strcat('aug_', num2str(k, '%02.f%'), '_', curr_label);
        
        saveAugmentedPair('data\AUGMENTED', rot_disp, rot_mask, disp_name, mask_name);
        
    end
end


end