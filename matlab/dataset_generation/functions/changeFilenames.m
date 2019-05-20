function [ ] = changeFilenames( origin, original_name, dest_name )

    list = dir(origin);

    for i = 3 : size(list,1)

        file_path = strcat(origin,list(i).name);
        [path, file_name, ext] = fileparts(file_path);

        pic_num = (strsplit(file_name, original_name));
        pic_num = pic_num{2};

        new_name = strcat(dest_name, pic_num);

        I = imread(file_path);
        imwrite(I, strcat(path,'/',new_name, ext));
        delete(file_path);

    end 
end

