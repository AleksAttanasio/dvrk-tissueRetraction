%% init
clc
clear all

addpath('dataset_labels')
load 01_lobe_labels_1-1000.mat
labels = [labels_1_500, labels_501_750, labels_751_1000];

tissue_mask_folder = 'masks/tissue_masks/';
tool_mask_folder = 'masks/tool_masks/';
idk_mask_folder = 'masks/idk_masks/';

%% dataset generation

I = uint8(zeros(576,720,3));
img_cnt = 0;

for k = 1 : 3
    for i = 1 : size(labels(k).LabelData,1)
        
        mask_tissue = zeros(576,720,3);
        mask_tool = zeros(576,720,3);
        mask_idk = zeros(576,720,3);
        
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
            end
        end
        
        % ---- tool mask generation
        if ~isempty(labels(k).LabelData.tool{i,1})
            for j = 1 : size(labels(k).LabelData.tool{i,1} , 1)

                r = labels(k).LabelData.tool{i,1}{j,1}(:,1);
                c = labels(k).LabelData.tool{i,1}{j,1}(:,2);

                % extract region of ROI
                BW = roipoly(I,r,c);

                % smooth edges of ROI
                windowSize = 25; % smoothing factor
                kernel = ones(windowSize) / windowSize ^ 2;
                blurryImage = conv2(single(BW), kernel, 'same');
                binaryImage = blurryImage > 0.5; % rethreshold

                mask_tool = imoverlay(mask_tool, binaryImage, 'white');
            end
        end
        
        % ---- idk mask generation
        if ~isempty(labels(k).LabelData.idk{i,1})
            for j = 1 : size(labels(k).LabelData.idk{i,1} , 1)

                r = labels(k).LabelData.idk{i,1}{j,1}(:,1);
                c = labels(k).LabelData.idk{i,1}{j,1}(:,2);

                % extract region of ROI
                BW = roipoly(I,r,c);

                % smooth edges of ROI
                windowSize = 25; % smoothing factor
                kernel = ones(windowSize) / windowSize ^ 2;
                blurryImage = conv2(single(BW), kernel, 'same');
                binaryImage = blurryImage > 0.5; % rethreshold

                mask_idk = imoverlay(mask_idk, binaryImage, 'white');
            end
        end
        
        % crop images
        mask_tissue = mask_tissue(56:521,160:665,:);
        mask_tool = mask_tool(56:521,160:665,:);
        mask_idk = mask_idk(56:521,160:665,:);
        
        tissue_mask_name = strcat('tissue_mask_', num2str(img_cnt, '%05.f%'),'.png');
        tool_mask_name = strcat('tissue_mask_', num2str(img_cnt, '%05.f%'),'.png');
        idk_mask_name = strcat('tissue_mask_', num2str(img_cnt, '%05.f%'),'.png');
        
        imwrite(mask_tissue, strcat(tissue_mask_folder, tissue_mask_name));
        imwrite(mask_tool, strcat(tool_mask_folder, tool_mask_name));
        imwrite(mask_idk, strcat(idk_mask_folder, idk_mask_name));
       
        img_cnt = img_cnt + 1;
    end
end
