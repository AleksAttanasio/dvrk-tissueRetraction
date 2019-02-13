%% init
clc
clear all

addpath('dataset_labels')
load 01_lobe_labels_1-1000.mat
labels = [labels_1_500, labels_501_750, labels_751_1000];

tissue_mask_folder = 'tissue_masks/';
tool_mask_folder = 'masks/tool_masks/';
idk_mask_folder = 'masks/idk_masks/';

format_img = 'gif';
train_img_name = 'disp_';

%% proc

I = uint8(zeros(576,720,3));
img_cnt = 0;
csv_cell = {};
name_train = [];
name_label = [];

for k = 1 : 3
    for i = 1 : size(labels(k).LabelData,1)
        
        mask_tissue = zeros(576,720,3);
        train_file_name = strcat('disp_', num2str(img_cnt, '%05.f%'),'.jpeg');
        % ---- tissue mask generation
        if ~isempty(labels(k).LabelData.tissue{i,1})      
            for j = 1 : size(labels(k).LabelData.tissue{i,1} , 1)
                % get point coordinates
                r = labels(k).LabelData.tissue{i,1}{j,1}(:,1);
                c = labels(k).LabelData.tissue{i,1}{j,1}(:,2);

                % extract region of ROI
                BW = roipoly(I,r,c);

                % smooth edges of ROI
                windowSize = 25; % smoothing factor
                kernel = ones(windowSize) / windowSize ^ 2;
                blurryImage = conv2(single(BW), kernel, 'same');
                binaryImage = blurryImage > 0.5; % rethreshold
                %binaryImage = binaryImage(56:521,160:665,:);

                mask_tissue = imoverlay(mask_tissue, binaryImage, 'white');
                tissue_mask_name = strcat('tissue_mask_', num2str(img_cnt, '%05.f%'),'.png');
                
                imwrite(mask_tissue, strcat(tissue_mask_folder, tissue_mask_name));
                
                name_train = [name_train ; train_file_name];
                name_label = [name_label ; tissue_mask_name];
                
                
            end
        end
        
        
        img_cnt = img_cnt + 1;
    end
end

train_file_list = unique(name_train,'rows');
label_file_list = unique(name_label,'rows');

tab_name = cell(size(train_file_list, 1), 2);
tab_name(:,1) = cellstr(train_file_list);
tab_name(:,2) = cellstr(label_file_list);

T = cell2table(tab_name);
writetable(T, 'tissue_labels.csv');

%% cropping 

clear all 
clc

origin_folder = 'tissue_masks/';
list = dir(origin_folder);

for i = 3 : size(list,1)
%     file_name = strcat(origin_folder, 'tissue_mask_', num2str(i, '%05.f%'), '.png');
    I_tissue = imread(strcat(origin_folder, list(i).name));
    I_tissue = I_tissue(56 : 521 , 160 : 665 , :);
    
    imwrite(I_tissue, strcat(origin_folder, list(i).name));
end

