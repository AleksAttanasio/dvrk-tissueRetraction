clc 
clear all
addpath('Da Vinci Captures')

%%
I2 = imread('hand_left.png');
I1 = imread('hand_right.png');

figure
imshow(stereoAnaglyph(I1,I2));
stereo_over = stereoAnaglyph(I1,I2);
title('Red-cyan composite view of the stereo images');

disparityRange = [-70 -38];
disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
    11,'DisparityRange',disparityRange, 'ContrastThreshold', 0.2);

figure 
imshow(disparityMap,disparityRange);
title('Disparity Map');
% colormap(gca,jet) 
colorbar