function [ gr_point, dist_map ] = findGraspingPoint( I, verbose )

% convert image to bw and invert it to have the background to '1'
bw = im2bw(I);
bw = imfill(bw,'holes');
bw_invert = imcomplement(bw);

% find centroid of background
Ilabel = bwlabel(bw_invert);
stat = regionprops(Ilabel,'centroid');
cent = [stat(1).Centroid(1),stat(1).Centroid(2)];

% evaluate distance map
dist_map = uint8(zeros(size(bw)));

for i = 1 : size(bw,1)
    for k = 1 : size(bw,2)
        if bw(i,k) == 1
            dist_map(i,k) = pdist([cent;[k,i]], 'euclidean')/1.5;
        end
    end
end

min_val = min(dist_map(dist_map>0));
[x,y] = find(dist_map == min_val);

% if required visualize the distance map
if(verbose == 'v')
    figure
    imshow(dist_map)
    colormap summer
    hold on
    for i = 1 : size(x,1)

        plot(y(i),x(i),'ro');

    end
end

gr_point = [x,y];
end

