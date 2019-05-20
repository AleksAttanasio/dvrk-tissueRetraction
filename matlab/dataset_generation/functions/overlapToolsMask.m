function [ outputImg ] = overlapToolsMask( depth_tissue, depth_tool, mask_tool )
% This function takes a background disparity map (depth_tissue) and
% extracts the tools out of a disparity map with tools (depth_tool) basing
% on the tool mask (mask_tool)

for i = 1 : size(depth_tissue, 1)
    for j = 1 : size(depth_tissue, 2)
        
        if (mask_tool(i,j) == 255)
            
            depth_tissue(i,j,:) = depth_tool(i,j,:);
            
        end
    end
end

outputImg = depth_tissue;

end

