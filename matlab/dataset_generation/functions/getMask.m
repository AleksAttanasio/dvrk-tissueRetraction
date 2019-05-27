function [ mask ] = getMask( labels , class, smooth, k_batch, i_label)
% This function returns a mask given:   - labels: a labels batch
%                                       - class: a class of mask 
%                                       - smooth: a smoothing factor
%                                       - k, i: batch and label index
% The available classes are: 'tissue', 'tool' and 'idk'
        
        I = uint8(zeros(576,720,3));
        mask = zeros(576,720,3);

        if strcmp(class,'tissue')
            for j = 1 : size(labels(k_batch).LabelData.tissue{i_label,1} , 1)
                
                r = labels(k_batch).LabelData.tissue{i_label,1}{j,1}(:,1);
                c = labels(k_batch).LabelData.tissue{i_label,1}{j,1}(:,2);

                BW = roipoly(I,r,c);
                smooth_BW = smoothMask(BW, smooth);
                
                mask = imoverlay(mask, smooth_BW, 'white');
            end

        elseif strcmp(class,'tool')
            for j = 1 : size(labels(k_batch).LabelData.tool{i_label,1} , 1)
                
                r = labels(k_batch).LabelData.tool{i_label,1}{j,1}(:,1);
                c = labels(k_batch).LabelData.tool{i_label,1}{j,1}(:,2);

                BW = roipoly(I,r,c);
                smooth_BW = smoothMask(BW, smooth);

                mask = imoverlay(mask, smooth_BW, 'white');
            end
            
        elseif strcmp(class,'idk')
            for j = 1 : size(labels(k_batch).LabelData.idk{i_label,1} , 1)
                
                r = labels(k_batch).LabelData.idk{i_label,1}{j,1}(:,1);
                c = labels(k_batch).LabelData.idk{i_label,1}{j,1}(:,2);

                BW = roipoly(I,r,c);
                smooth_BW = smoothMask(BW, smooth);

                mask = imoverlay(mask, smooth_BW, 'white');
                
            end
            
        end
        
end

