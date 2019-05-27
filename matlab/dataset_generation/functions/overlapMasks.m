function [ new_mask ] = overlapMasks( background, mask )
%OVERLAPMASKS Summary of this function goes here
%   Detailed explanation goes here

new_mask = background;

for i = 1:size(background,1)
    for k = 1: size(background,2)
        
        if mask(i,k) ~= 0
           
            new_mask(i,k,:) = mask(i,k,:);
            
        end
    end
end


end

