import os
import flapnet
import numpy as np
import matplotlib as mpl
import pandas as pd
import tensorflow as tf
from tensorflow.python.keras import models
import matplotlib.pyplot as plt
mpl.rcParams['axes.grid'] = False
mpl.rcParams['figure.figsize'] = (12,12)

import os
import flapnet
import numpy as np
import matplotlib as mpl
import pandas as pd
import tensorflow as tf
from tensorflow.python.keras import models
mpl.rcParams['axes.grid'] = False
mpl.rcParams['figure.figsize'] = (12,12)

model_path = '/home/stormlab/nn_results/nn_ftw/model_ftw.hdf5'
# model_path = '/home/stormlab/nn_results/nn_custom_dout1.0_lr5E-04_04April2019_09-54AM/nn_custom_dout1.0_lr5E-04_04April2019_09-54AM.hdf5'

testset_size = 0.7

fn = flapnet.Functions(shape_img=(64,64,3))
fn_struct = flapnet.Structure()
fn_losses = flapnet.LossFunction()


# Da/home/aleks/nn_results/Gtaset folders init
dataset_name = os.path.join('tissue_dataset', 'cyst_dataset')
img_dir = os.path.join(dataset_name, "train")
label_dir = os.path.join(dataset_name, "label")
df_train = pd.read_csv(os.path.join(dataset_name,'cyst_dataset.csv'))

# Load filenames of labels and tra ining objects
x_train_filenames, x_val_filenames, y_train_filenames, y_val_filenames = fn.load_filenames(df_train= df_train,
                                                                                           img_dir= img_dir,
                                                                                           label_dir= label_dir,
                                                                                           test_size= testset_size)

# Generating dataset for training
train_ds, val_ds = fn.generate_train_and_val_ds(x_train_filenames, y_train_filenames, x_val_filenames, y_val_filenames)

model = models.load_model(model_path, custom_objects={'bce_dice_loss': fn_losses.bce_dice_loss,
                                                           'dice_loss': fn_losses.dice_loss})
model.summary()

fn.plot_predictions(model, val_ds)