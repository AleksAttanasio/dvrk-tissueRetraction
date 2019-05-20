function [ flip_img ] = randomFlipSingleImage( img )
% This function takes an image and flips it randomly choosing between two
% options: vertical flip or horizontal flip

% randomly choose a direction to flip image
% 1 ->  vertical
% 2 -> horizontal
flip_direction = randi([1,2]);

flip_img = flip(img, flip_direction);

end

