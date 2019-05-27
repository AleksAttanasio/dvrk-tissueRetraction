function [ cropped_mask ] = cropMask( mask )
%CROPMASK Summary of this function goes here
%   Detailed explanation goes here
    
    cropped_mask = mask(56 : 521 , 160 : 665 , :);

end

