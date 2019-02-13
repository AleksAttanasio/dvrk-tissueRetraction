function [ ] = shuffleLabellingSet( origin_folder, dest_folder, batch_size, batch_num, idx_start)

% if destination folder doesn't exist create it
if ~exist(dest_folder,'dir')
    mkdir(strcat(dest_folder,'_shuffle/'));
end

disp_list = dir(strcat(origin_folder,'/','disp_color'));
r_list = dir(strcat(origin_folder,'/','right'));
l_list = dir(strcat(origin_folder,'/','left'));

num_data = (size(disp_list,1) -2) - idx_start;


if(batch_size * batch_num > num_data)
    error('batch_size * batch_num > number of elements in the set');
    return
end

img_idx = randperm(num_data, batch_size * batch_num);

for i = 0 : (batch_num - 1)
    mkdir(strcat(dest_folder,'_shuffle/batch_', num2str(i,'%02.f%'), '/disp_color'))
    mkdir(strcat(dest_folder,'_shuffle/batch_', num2str(i,'%02.f%'), '/right'))
    mkdir(strcat(dest_folder,'_shuffle/batch_', num2str(i,'%02.f%'), '/left'))
    
    for k = 1 : batch_size
        
        current_index = img_idx(batch_size * i + k);
        
        I_disp = imread(strcat(origin_folder, '/disp_color/disp_', ...
                                    num2str(current_index, '%05.f%'), '.jpeg' ));
        I_left = imread(strcat(origin_folder, '/left/left_', ...
                                    num2str(current_index, '%05.f%'), '.jpeg' ));
        I_right = imread(strcat(origin_folder, '/right/right_', ...
                                    num2str(current_index, '%05.f%'), '.jpeg' ));
        
        imwrite(I_disp, strcat(dest_folder,'_shuffle/batch_', num2str(i,'%02.f%'), '/disp_color/disp_', ...
                                num2str(current_index, '%05.f%'), '.jpeg'));
        imwrite(I_left, strcat(dest_folder,'_shuffle/batch_', num2str(i,'%02.f%'), '/left/left_', ...
                                num2str(current_index, '%05.f%'), '.jpeg'));
        imwrite(I_right, strcat(dest_folder,'_shuffle/batch_', num2str(i,'%02.f%'),'/right/right_', ...
                                num2str(current_index, '%05.f%'), '.jpeg'));
                
    end
end

end

