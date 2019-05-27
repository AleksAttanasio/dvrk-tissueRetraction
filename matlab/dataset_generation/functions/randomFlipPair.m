function [ flip_disp, flip_mask ] = randomFlipPair( disp, mask, flip_direction, double_flip )
%RANDOMFLIPPAIR Summary of this function goes here
%   Detailed explanation goes here

        flip_disp = flip(disp, flip_direction);
        flip_mask = flip(mask, flip_direction);
        
        if double_flip == 1 && flip_direction == 1
            
            flip_disp = flip(disp, flip_direction + 1);
            flip_mask = flip(mask, flip_direction + 1);
            
        elseif double_flip == 1 && flip_direction == 2
            
            flip_disp = flip(disp, flip_direction - 1);
            flip_mask = flip(mask, flip_direction - 1);
            
        end


end

