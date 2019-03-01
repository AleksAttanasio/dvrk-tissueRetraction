function [ flip_img_1, flip_img_2 ] = randomFlipImageCouple( img_1, img_2 )
% This function takes an image and flips it randomly choosing between two
% options: vertical flip or horizontal flip

% randomly choose a direction to flip image
% 1 ->  vertical
% 2 -> horizontal
flip_direction = randi([1,2]);

flip_img_1 = flip(img_1, flip_direction);
flip_img_2 = flip(img_2, flip_direction);

end

