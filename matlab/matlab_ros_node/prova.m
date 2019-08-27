curpos=[0 0 -0.113];
curquat=[0.7 0.7 0 0];

pos=[0.01 0.01 -0.113;...
    0.02 0.011 -0.123];

%safe z quote at which no touch tissue
safe_z=-0.1;

%on xy plane find line connecting points
p=polyfit(pos(:,1),pos(:,2),1);
%compute euclidean distance
dist=norm(pos(:,1)-pos(:,2));
% want to move into background tissue of 10% of distance between the points
dist=dist*0.1;

%compute x and y of first point
if(pos(2,1)-pos(1,1)>0)
    if(pos(2,2)-pos(1,2)>0)
    %first quadrant
        xp = pos(2,1)+dist/sqrt(1+p(1));
        yp = polyval(p,xp);
    else
    %fourth quadrant
        xp = pos(2,1)-dist/sqrt(1+p(1));
        yp = polyval(p,xp);
    end
else
    if(pos(2,2)-pos(1,2)>0)
    %second quadrant
        xp = pos(2,1)+dist/sqrt(1+p(1));
        yp = polyval(p,xp);
    else
    %third quadrant  
        xp = pos(2,1)-dist/sqrt(1+p(1));
        yp = polyval(p,xp);
    end
end

%compute angle
%local rotation
rotloc=axang2quat([0 0 1 -p(1)]);
rotglob=quatmultiply(curquat,rotloc);

%move to x,y of grasping point with vertical orientation and above
% move to xp, yp, safe_z, curquat (vertical)
%move to x and y of grasping point and z of first detected point
% move to xp yp, pos(2,3), curquat, 
% move to xp yp, pos(2,3), rotglob, 
% rotate to scoooooop
% move to pos(2,:), rotglob
% move to pos(1,:)