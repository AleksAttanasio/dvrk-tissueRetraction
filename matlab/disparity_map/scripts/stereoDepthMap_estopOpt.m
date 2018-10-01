clc 
clear all
addpath('Da Vinci Captures')

%%
I1 = imread('estop_left.png');
I2 = imread('estop_right.png');

figure
imshow(stereoAnaglyph(I1,I2));
stereo_over = stereoAnaglyph(I1,I2);
title('Red-cyan composite view of the stereo images');

disparityRange = [-108 -60];
disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
    5,'DisparityRange',disparityRange);

figure 
imshow(disparityMap,disparityRange);
title('Disparity Map');
% colormap(gca,jet) 
colorbar