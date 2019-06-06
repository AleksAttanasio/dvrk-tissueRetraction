function [ ] = frame3d(origin,orientation)

quiver3(origin(1), origin(2), origin(3), orientation(1,1), orientation(2,1) , orientation(3,1), 'color', 'g');
hold on
quiver3(origin(1), origin(2), origin(3), orientation(1,2), orientation(2,2) , orientation(3,2),  'color', 'r');
quiver3(origin(1), origin(2), origin(3), orientation(1,3), orientation(2,3) , orientation(3,3), 'color', 'b');

end

