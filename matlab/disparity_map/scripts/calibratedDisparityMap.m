%% Initialization

clc
clear all
addpath('matlab\video_frame_sgmt\videos\frames_smp24_10k_samples\tons\Tonsillectomy_Sync_EYE1-converted.mp4\')
addpath('matlab\video_frame_sgmt\videos\frames_smp24_10k_samples\tons\Tonsillectomy_Sync_EYE0-converted.mp4\')
addpath('dvrk_calibrate\')
load ct_cam_params.mat

%% Evaluate Disparity map,

% Read images
I2 = imread('tons\Tonsillectomy_Sync_EYE1-converted.mp4\frame_1248.png');
I1 = imread('tons\Tonsillectomy_Sync_EYE0-converted.mp4\frame_1248.png');

% Rectify Images
[I1Rect, I2Rect] = rectifyStereoImages(I1, I2, ct_cam_params,'OutputView','full');

figure 
imshow(cat(3,I1Rect(:,:,1),I2Rect(:,:,2:3)),'InitialMagnification',100);

disparityRange = [16, 96];
disparityMap = disparity(rgb2gray(I1Rect),rgb2gray(I2Rect),'BlockSize',...
    15,'DisparityRange',disparityRange, 'ContrastThreshold', 0.4, ...
    'DistanceThreshold', 1, 'UniquenessThreshold', 10);

stereo_over = stereoAnaglyph(I1Rect,I2Rect);
% Show disparity map
figure 
imshow(disparityMap,disparityRange);
title('Disparity Map');
colorbar

%% Detect edges and depth amp
edges_stereo_over = edge(rgb2gray(I1Rect), 'Canny',[0.05, 0.30]);

% Create red mask
red = cat(3, ones(size(disparityMap)), zeros(size(disparityMap)), ...
            zeros(size(disparityMap)));
        
%% Overlay and show edges and depth map
figure
imshow(red)
hold on 
h = imshow(disparityMap, disparityRange);
hold off
set(h, 'AlphaData', ~edges_stereo_over); 