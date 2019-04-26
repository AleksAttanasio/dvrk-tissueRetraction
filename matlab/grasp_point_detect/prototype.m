% random pick one image
addpath('functions')
img_folder = 'labels';
img_list = dir(img_folder);
img_name = fullfile(img_folder,img_list(randi([3,size(img_list,1)])).name);

% img_name = 'labels\mask_lobe1_04725.png';

%% show original image and inverted
I = imread(img_name);
% figure
% imshow(I)
% title('Original Picture')
%% Invert image

bw = im2bw(I);
bw = imfill(bw,'holes');
bw_invert = imcomplement(bw);

%%
[label_origin, num_lbs] = bwlabel(bw);
label_invert = bwlabel(bw_invert);
stat = regionprops(label_invert,'centroid');
cent = [stat(1).Centroid(1),stat(1).Centroid(2)];
figure
imshow(I); hold on;
plot(cent(1),cent(2),'ro');
title('Background Centroid')

%% evaluate distance map

dist_map = uint8(zeros(size(bw)));
dist_img = uint8(zeros(size(bw)));
gp_cell_avg = cell(0);
gp_cell_nor = cell(0);

for j = 1 : num_lbs
   
    [fl_x, fl_y] = find(label_origin == j);
    
    for i = 1 : numel(fl_x)
       
        dist_map(fl_x(i),fl_y(i)) = pdist([cent;[fl_y(i),fl_x(i)]], 'euclidean');
        dist_img = dist_img + dist_map;
        
    end
    
    min_val = min(dist_map(dist_map>0));
    [x,y] = find(dist_map == min_val);
    avg_pt = [mean(x),mean(y)];
    gp_cell_avg{j} = avg_pt;
    gp_cell_nor{j} = [x,y];
    dist_map = uint8(zeros(size(bw)));
    
end

%%

figure
imshow(dist_img)
hold on
for i = 1 : num_lbs
    plot(cent(1),cent(2),'co');
    
    for k = 1 : size(gp_cell_nor{i},1)
    
        plot(gp_cell_nor{i}(k,2),gp_cell_nor{i}(k,1),'ro');
    end
    plot(gp_cell_avg{i}(2),gp_cell_avg{i}(1), 'g*')
end
title('Grasping Point and Centroid')