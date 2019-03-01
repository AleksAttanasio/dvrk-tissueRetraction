%% init 

clc
clear all

% dataset paths
dataset_lobe_1_path = 'data/lobe1_10x100_shuffle/';
dataset_lobe_2_path = 'data/lobe2_10x100_shuffle/';

% dataset batches
batches_lobe_1 = getFilesAndBatches(dataset_lobe_1_path, 100);
batches_lobe_2 = getFilesAndBatches(dataset_lobe_2_path, 100);

% dataset labels
labels_lobe_1 = loadBatchLabels(dataset_lobe_1_path, 5);
labels_lobe_2 = loadBatchLabels(dataset_lobe_2_path, 3);

% adding paths to WD
addpath(dataset_lobe_1_path)
addpath(dataset_lobe_2_path)

% extract tools from disparity images
tools_lobe_1 = extractToolsFromBatches(labels_lobe_1, batches_lobe_1);
tools_lobe_2 = extractToolsFromBatches(labels_lobe_2, batches_lobe_2);
tools = [tools_lobe_1; tools_lobe_2];

aug_set_1 = createAugmentedSet(labels_lobe_1, batches_lobe_1, tools);
aug_set_2 = createAugmentedSet(labels_lobe_2, batches_lobe_2, tools);
aug_set = [aug_set_1; aug_set_2];

%%
exportAugmentedSet(aug_set, 'aug_test');

