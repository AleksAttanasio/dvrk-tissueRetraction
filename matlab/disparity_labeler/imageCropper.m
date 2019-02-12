% init

clc
clear all

addpath('unproc_dataset')
% addpath('left')
% addpath('right')
% addpath('disp_color')

%% proc

for i = 0 : 1000
    
    left_img_name = strcat('left_', num2str(i, '%05.f%'),'.jpeg');
    right_img_name = strcat('right_', num2str(i, '%05.f%'),'.jpeg');
    disp_img_name = strcat('disp_', num2str(i, '%05.f%'),'.jpeg');
    
    I_left = imread(strcat('unproc_dataset/left/',left_img_name));
    I_right = imread(strcat('unproc_dataset/right/',right_img_name));
    I_disp = imread(strcat('unproc_dataset/disp_color/',disp_img_name));
    
    I_left = I_left(56 : 521 , 160 : 665 , :);
    I_right = I_right(56 : 521 , 160 : 665, :);
    I_disp = I_disp(56 : 521 , 160 : 665, :);
    
    imwrite(I_left, strcat('cropped/left/', left_img_name));
    imwrite(I_right, strcat('cropped/right/', right_img_name));
    imwrite(I_disp, strcat('cropped/disp_color/', disp_img_name));
    
end
