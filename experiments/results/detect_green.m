clear all
clc

img = imread('test_image_green_square.png');

%enhance brightness
img_br = img + 50;
mask_HSV = zeros(size(img_br,1), size(img_br,2));
img_hsv = rgb2hsv(img_br);

for i = 1 : size(img_hsv,1)
   for j = 1 : size(img_hsv,2)
   
       if      img_hsv(i,j,1) > 0.17 && img_hsv(i,j,1) < 0.60 && ...
               img_hsv(i,j,2) > 0.15 && img_hsv(i,j,2) < 0.90 && ...
               img_hsv(i,j,3) > 0.15 && img_hsv(i,j,3) < 0.90
           
           mask_HSV(i,j) = 1;
       end
   end
end

imshow(mask_HSV)