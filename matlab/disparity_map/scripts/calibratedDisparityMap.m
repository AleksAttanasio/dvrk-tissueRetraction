%% Initialization

clc
clear all
addpath('disparity_map')
addpath('disparity_map/objects')
load 'stereoParams_dvrk_8e-1.mat'

%% Evaluate Disparity map,

% Read images
I2 = imread('hand_left.png');
I1 = imread('hand_right.png');

% Rectify Images
[I1Rect, I2Rect] = rectifyStereoImages(I1, I2, stereoParams,'OutputView','full');

figure 
imshow(cat(3,I1Rect(:,:,1),I2Rect(:,:,2:3)),'InitialMagnification',100);

disparityRange = [-53, 11];
disparityMap = disparity(rgb2gray(I1Rect),rgb2gray(I2Rect),'BlockSize',...
    11,'DisparityRange',disparityRange, 'ContrastThreshold', 0.9, ...
    'DistanceThreshold', 1, 'UniquenessThreshold', 10);

stereo_over = stereoAnaglyph(I1Rect,I2Rect);
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


%%