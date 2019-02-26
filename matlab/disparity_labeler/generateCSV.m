function [  ] = generateCSV( mask_folder, train_folder, csv_name )
%GENERATECSV Summary of this function goes here
%   Detailed explanation goes here

    mask_list = dir(mask_folder);
    train_list = dir(train_folder);

    if (size(mask_list,1) == size(train_list,1))

        couple_table = cell((size(mask_list,1) - 2), 2);

        for i = 3 : size(mask_list,1)

            couple_table{i,1} = train_list(i).name;
            couple_table{i,2} = mask_list(i).name;

        end

        T = cell2table(couple_table);
        T(1:2,:) = [];
        writetable(T, csv_name);

    else
        error('Different number of elements in training and masks')
    end

end

