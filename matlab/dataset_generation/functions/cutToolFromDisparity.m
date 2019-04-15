function [ cut_disparity ] = cutToolFromDisparity( mask, disparity )

cut_disparity = uint8(zeros(size(mask)));

for i = 1 : size(mask,1)
    for k = 1 : size(mask,2)
   
        if (mask(i,k) > 220)
           
            cut_disparity(i,k,:) = disparity(i,k,:);
            
        end
    end
end
end

