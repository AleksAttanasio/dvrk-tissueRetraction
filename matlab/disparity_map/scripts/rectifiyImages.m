%% Initialization

clc
clear all
addpath('Da Vinci Captures')
load tMatrix.mat

%% Evaluate Disparity map,

% Read images
I1 = imread('estop_left.png');
I2 = imread('estop_right.png');

% Rectify Images
[I1Rect, I2Rect] = rectifyStereoImages(I1, I2, tform1, tform2);

% Show Anaglyph
figure
imshow(stereoAnaglyph(I1Rect,I2Rect));
title('Red-cyan composite view of the stereo images');

% Evaluate disparity map
stereo_over = stereoAnaglyph(I1Rect,I2Rect);
disparityRange = [-12, 4];
disparityMap = disparity(rgb2gray(I1Rect),rgb2gray(I2Rect),'BlockSize',...
    11,'DisparityRange',disparityRange, 'ContrastThreshold', 0.5, ...
    'DistanceThreshold', 1, 'UniquenessThreshold', 2);

% Show disparity map
figure 
imshow(disparityMap,disparityRange);
title('Disparity Map');
colorbar

% Detect edges and depth amp
edges_stereo_over = edge(rgb2gray(I1Rect), 'Canny',[0.05, 0.30]);

% Create red mask
red = cat(3, ones(size(disparityMap)), zeros(size(disparityMap)), ...
            zeros(size(disparityMap)));
        
% Overlay and show edges and depth map
figure
imshow(red)
hold on 
h = imshow(disparityMap, disparityRange);
hold off
set(h, 'AlphaData', ~edges_stereo_over); 




