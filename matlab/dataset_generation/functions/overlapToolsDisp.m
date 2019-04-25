function [ outputImg ] = overlapToolsDisp( depth_tissue, depth_tool )
% This function takes a background tissue image and overlaps a set of tools
% (depth_tool) over it.

    for i = 1 : size(depth_tissue, 1)
        for j = 1 : size(depth_tissue, 2)
            
            if (sum(depth_tool(i,j,:)) > 100 )
                    
                depth_tissue(i,j,:) = depth_tool(i,j,:); 
                
            end
        end
    end
    
    outputImg = depth_tissue;
end

