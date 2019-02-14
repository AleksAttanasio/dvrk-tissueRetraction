function [ outputImg ] = overlapTools( depth_tissue, depth_tool, mask_tool )

    for i = 1 : size(depth_tissue, 1)
        for j = 1 : size(depth_tissue, 2)
            
            if (mask_tool(i,j) == 255)
               
                depth_tissue(i,j,:) = depth_tool(i,j,:); 
                
            end
        end
    end
    
    outputImg = depth_tissue;
end

