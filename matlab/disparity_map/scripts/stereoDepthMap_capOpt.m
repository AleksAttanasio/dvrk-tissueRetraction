clc 
clear all
addpath('Da Vinci Captures')

%%
I1 = imread('cap_left.png');
I2 = imread('cap_right.png');

figure
imshow(stereoAnaglyph(I1,I2));
stereo_over = stereoAnaglyph(I1,I2);
title('Red-cyan composite view of the stereo images');

disparityRange = [-92 -28];
disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
    9,'DisparityRange',disparityRange, 'ContrastThreshold', 0.7, ...
    'DistanceThreshold', 1, 'UniquenessThreshold', 4);

figure 
imshow(disparityMap,disparityRange);
title('Disparity Map');
% colormap(gca,jet) 
colorbar