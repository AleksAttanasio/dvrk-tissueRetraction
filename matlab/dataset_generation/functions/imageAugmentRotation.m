function [ rot_img ] = imageAugmentRotation( I, ang )
% The function rotates an image by an angle. Afterwards a scaling allows to
% fit the image in the original dimension canvas.
% Inputs:   - I: input image
%           - ang: rotating angle

A = imrotate(I, ang ,'crop', 'bilinear');
mag_fact = 0.015 * abs(ang) + 1;
B = imresize(A,mag_fact);

y_crop = floor(size(B,2)/2);
x_crop = floor(size(B,1)/2);

x_min = x_crop - (size(I,1)/2);
y_min = y_crop - (size(I,2)/2);

rot_img = imcrop(B, [x_min,y_min,size(A,2)-1,size(A,1)-1]);

end

