function [ pre_res, post_res ] = extract_retraction_perc( folder, n_white )

    pre_res = zeros(5,1);
    post_res = zeros(5,1);

    addpath(folder)

    for i = 1 : 5

        img_pre = imread(fullfile(folder,num2str(i),'pre.png'));
        img_post = imread(fullfile(folder,num2str(i),'post.png'));

        pre_mask = mask_green(img_pre);
        post_mask = mask_green(img_post);

        n_white_pre = sum(sum(pre_mask));
        n_white_post = sum(sum(post_mask));

        perc_pre = (n_white_pre * 100)/n_white;
        perc_post = (n_white_post * 100)/n_white;

        pre_res(i) = perc_pre;
        post_res(i) = perc_post;

    end


end

