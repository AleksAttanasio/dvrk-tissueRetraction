import os
import functools
import numpy as np
import matplotlib as mpl
import pandas as pd
from sklearn.model_selection import train_test_split

mpl.rcParams['axes.grid'] = False
mpl.rcParams['figure.figsize'] = (12, 12)

# Load dataset from image file names
dataset_name = os.path.join('tissue_dataset', 'dataset_ready_00')

img_dir = os.path.join(dataset_name, "merged_training_00")
label_dir = os.path.join(dataset_name, "merged_masks_00_gif")

df_train = pd.read_csv(os.path.join(dataset_name,'label_map_00.csv'))

x_train_filenames = []
y_train_filenames = []

for img_id in df_train['couple_table1']:
    x_train_filenames.append(img_id)

for lab_id in df_train['couple_table2']:
    y_train_filenames.append(lab_id)

x_train_filenames, x_val_filenames, y_train_filenames, y_val_filenames = \
    train_test_split(x_train_filenames, y_train_filenames, test_size=0.2, random_state=42)

num_train_examples = len(x_train_filenames)
num_val_examples = len(x_val_filenames)

print("Number of training examples: {}".format(num_train_examples))
print("Number of validation examples: {}".format(num_val_examples))

display_num = 5

r_choices = np.random.choice(num_train_examples, display_num)
