clc
clear all
close all

% Insert folder names of the operations to read
op = ['cali']; % 'tons'; 'lobe'; 'cyst';
frame_skip = 24; % number of frame to skip
origin_folder = 'videos\compress\';
destination_folder = 'videos\frame_0\';

op = cellstr(op);
video_path = cell(size(op,1),1);
frames_paths = cell(size(op,1),1);

% Add and list paths
for i = 1 : size(op,1)
    tmp = origin_folder;
    tmp_new = destination_folder;
    tmp = strcat(tmp, op{i});
    tmp_new = strcat(tmp_new, op{i});
    video_path{i} = tmp;
    frames_paths{i} = tmp_new;
    addpath(tmp);
    addpath(tmp_new)
    
end

% for loop over operations
for i = 1 : size(op,1)
    
    files_dir = dir(video_path{i});
    
    if ~exist(frames_paths{i}, 'dir')
       mkdir(frames_paths{i})
    end
    
    % for loop over videos
    for k = 3 : size(files_dir, 1)
        
        file_name = files_dir(k).name;
        file_path = strcat(video_path{i}, '\' , file_name);
        video = VideoReader(file_path);
        n_frames = video.NumberOfFrames;
        file_folder = strcat(frames_paths{i}, '\' , file_name);
        
        if ~exist(file_folder, 'dir')
            mkdir(file_folder)
        end
        
        % for loop over frames
        for j = 1 : frame_skip : n_frames
            frames = read(video, j);
            title = strcat(file_folder, '\' ,'frame_', num2str(j-1),'.png');
            imwrite(frames, title);
        end
    end
end