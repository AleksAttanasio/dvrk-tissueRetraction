function [ mask ] = extractClassMask( labels, class, k, i, color )
%EXTRACTCLASSMASK Summary of this function goes here
%   Detailed explanation goes here

I = uint8(zeros(576,720,3));
mask = zeros(576,720,3);
exp = strcat("labels(k).gTruth.LabelData.", class, "{i,1}");

for j = 1 : size(eval(exp) , 1)

    % Getting coordinates points
    r = eval(strcat(exp,"{j,1}(:,1);"));
    c = eval(strcat(exp,"{j,1}(:,2);"));

    % extract region of ROI
    BW = roipoly(I, r, c);
    BW_tissue_smooth = smoothMask(BW, 25);

    mask = imoverlay(mask, BW_tissue_smooth, color);

end

end

