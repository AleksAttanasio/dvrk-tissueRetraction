function [ ] = generateTissueToolMasks( dataset_dir )

dataset_folder = dir(dataset_dir)

lobe1_labels = loadBatchLabels('data/lobe1_10x100_shuffle/');

labels = [lobe1_labels, lobe2_labels];

I = uint8(zeros(576,720,3));
img_cnt = 0;
name_train = [];
name_label = [];



for k = 1 : size(labels, 2)
    for i = 1 : size(labels(k).LabelData,1)
        
        tissue_mask = zeros(576,720,3);
        tool_mask = zeros(576,720,3);
        disp_folder = dir()
        % ---- tissue mask generation
        if ~isempty(labels(k).LabelData.tissue{i,1})      
            for j = 1 : size(labels(k).LabelData.tissue{i,1} , 1)
                
                train_file_name = strcat('disp_', num2str(img_cnt, '%05.f%'),'.jpeg');
                
                % get point coordinates
                r_tissue = labels(k).LabelData.tissue{i,1}{j,1}(:,1);
                c_tissue = labels(k).LabelData.tissue{i,1}{j,1}(:,2);
                
                r_tool = labels(k).LabelData.tool{i,1}{j,1}(:,1);
                c_tool = labels(k).LabelData.tool{i,1}{j,1}(:,2);
                
                 % extract region of ROI
                BW_tissue = roipoly(I,r_tissue,c_tissue);
                BW_tool = roipoly(I,r_tool,c_tool);
                
                % smooth edges of ROI
                BW_tissue_smooth = smoothMask(BW_tissue, 25);
                BW_tool_smooth = smoothMask(BW_tool, 25);
                
                tissue_mask = imoverlay(tissue_mask, BW_tissue, 'white');
                tool_mask = imoverlay(tool_mask, BW_tool, 'yellow');
        
            end
        end
    end
end

end

