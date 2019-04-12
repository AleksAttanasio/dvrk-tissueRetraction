function [ tools ] = extractToolsFromSingleImage( disp_map, tool_mask)

        tools = uint8(zeros(size(disp_map)));

        for i = 1 : size(tool_mask, 1)
            for j = 1 : size(tool_mask, 2)
                if(tool_mask(i,j) == 255)
                   
                    tools(i,j,:) = disp_map(i,j,:);
                    
                end
            end
        end

end

