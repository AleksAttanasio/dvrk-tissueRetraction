function [ ] = imageDataCrop( origin_folder )

list = dir(origin_folder);

for i = 3 : size(list,1)
    
    I_tissue = imread(strcat(origin_folder, '/', list(i).name));
    I_tissue = I_tissue(56 : 521 , 160 : 665 , :);
    
    imwrite(I_tissue, strcat(origin_folder, '/', list(i).name));
    
end

end

