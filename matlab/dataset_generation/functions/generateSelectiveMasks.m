function [ ] = generateSelectiveMasks( class, labels, dest_folder, csv_save )

I = uint8(zeros(576,720,3));
img_cnt = 0;
name_train = [];
name_label = [];


for k = 1 : size(labels, 2)
    for i = 1 : size(labels(k).LabelData,1)
        
        mask = zeros(576,720,3);
        
        % ---- tissue mask generation
        if ~isempty(labels(k).LabelData.tissue{i,1})      
            for j = 1 : size(labels(k).LabelData.tissue{i,1} , 1)
                
                train_file_name = strcat('disp_', num2str(img_cnt, '%05.f%'),'.jpeg');
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

                mask = imoverlay(mask, binaryImage, 'white');
                mask_name = strcat(class,'_mask_', num2str(img_cnt, '%05.f%'),'.png');
                
                % if destination folder doesn't exist create it
                if ~exist(dest_folder,'dir')
                    mkdir(strcat(dest_folder,'/', class ,'_masks/'));      
                end
                
                imwrite(mask, strcat(dest_folder, '/', class, '_masks/', mask_name));
                
                name_train = [name_train ; train_file_name];
                name_label = [name_label ; mask_name];

            end
        end

        img_cnt = img_cnt + 1;
        
    end
end

% save in csv file the maps of the dataset
if csv_save == 'y'
    train_file_list = unique(name_train,'rows');
    label_file_list = unique(name_label,'rows');

    tab_name = cell(size(train_file_list, 1), 2);
    tab_name(:,1) = cellstr(train_file_list);
    tab_name(:,2) = cellstr(label_file_list);

    T = cell2table(tab_name);
    writetable(T, strcat(dest_folder, '_labels.csv'));
end

end

