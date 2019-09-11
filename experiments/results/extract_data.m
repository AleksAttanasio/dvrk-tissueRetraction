clear all
clc
addpath('results-retraction')

%% Get baseline
bg = imread('results-retraction/bg.png');
bg_mask = mask_green(bg);

imshow(bg_mask);
n_white = sum(sum(bg_mask));
perc_white_bg = n_white/numel(bg_mask);

%% extract retraction results

% extract left retraction
[pre_left_res, post_left_res] = extract_retraction_perc('left' , n_white);
pre_left_std = std(pre_left_res);
pre_left_mean = mean(pre_left_res);
post_left_std = std(post_left_res);
post_left_mean = mean(post_left_res);

% extract right retraction
[pre_right_res, post_right_res] = extract_retraction_perc('right' , n_white);
pre_right_std = std(pre_right_res);
pre_right_mean = mean(pre_right_res);
post_right_std = std(post_right_res);
post_right_mean = mean(post_right_res);

% extract bottom retraction
[pre_bottom_res, post_bottom_res] = extract_retraction_perc('bottom' , n_white);
pre_bottom_std = std(pre_bottom_res);
pre_bottom_mean = mean(pre_bottom_res);
post_bottom_std = std(post_bottom_res);
post_bottom_mean = mean(post_bottom_res);

%% export to csv file for plot
results = cell(0)

% --- left
% pre
results{1,1} = pre_left_mean;
results{2,1} = pre_left_std;
% post
results{1,2} = post_left_mean;
results{2,2} = post_left_std;

% --- right 
% pre
results{1,3} = pre_right_mean;
results{2,3} = pre_right_std;
% post
results{1,4} = post_right_mean;
results{2,4} = post_right_std;

% --- bottom
% pre
results{1,5} = pre_bottom_mean;
results{2,5} = pre_bottom_std;
%post
results{1,6} = post_bottom_mean;
results{2,6} = post_bottom_std;

T = cell2table(results, 'VariableNames',{'pre_left','post_left', ...
                    'pre_right','post_right','pre_bottom','post_bottom'});
                    
writetable(T,'results.csv')
                    