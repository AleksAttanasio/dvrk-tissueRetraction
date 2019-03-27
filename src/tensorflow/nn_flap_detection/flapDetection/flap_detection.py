import os
import functools
import flapnet
import numpy as np
import matplotlib.pyplot as plt
import matplotlib as mpl
import pandas as pd
import tensorflow as tf
import tensorflow.contrib as tfcontrib
from sklearn.model_selection import train_test_split
from tensorflow.python.keras import layers
from tensorflow.python.keras import losses
from tensorflow.python.keras import models
mpl.rcParams['axes.grid'] = False
mpl.rcParams['figure.figsize'] = (12,12)

#####################################################################
#---------------------------- PARAMETERS ---------------------------#
#####################################################################

dataset_name = os.path.join('tissue_dataset', 'dataset_ready_aug_00')

img_shape = (128, 128, 3)
batch_size = 25
epochs = 2
testset_size = 0.2
adam_opt = tf.keras.optimizers.Adam(lr=0.001)

save_model_path = '/home/aleks/nn_results/nn_std_lr10e-3_dropout_02_custom.hdf5'
img_dir = os.path.join(dataset_name, "merged_training_00")
label_dir = os.path.join(dataset_name, "merged_masks_00_gif")
df_train = pd.read_csv(os.path.join(dataset_name,'label_map_aug_00.csv'))

fn = flapnet.Functions(img_shape, batch_size, epochs)
fn_struct = flapnet.Structure()
fn_losses = flapnet.LossFunction()

#####################################################################
#----------------------------- TRAINING ----------------------------#
#####################################################################

x_train_filenames, x_val_filenames, y_train_filenames, y_val_filenames = fn.load_filenames(df_train= df_train,
                                                                                           img_dir= img_dir,
                                                                                           label_dir= label_dir,
                                                                                           test_size= testset_size)

print("Number of training examples: {}".format(len(x_train_filenames)))
print("Number of validation examples: {}".format(len(x_val_filenames)))

fn.show_dataset_labels(x_train=x_train_filenames, y_train=y_train_filenames)

train_ds, val_ds = fn.generate_train_and_val_ds(x_train_filenames, y_train_filenames, x_val_filenames, y_val_filenames)

inputs, outputs = fn_struct.custom_model(img_shape, num_filters=2)
model = models.Model(inputs=[inputs], outputs=[outputs]) # 128
model.compile(optimizer=adam_opt,  loss=fn_losses.bce_dice_loss, metrics=[fn_losses.dice_loss])
model.summary()

cp = tf.keras.callbacks.ModelCheckpoint(filepath=save_model_path,
                                        monitor='val_dice_loss',
                                        save_best_only=True,
                                        verbose=1)

history = model.fit(train_ds,
                    steps_per_epoch=int(np.ceil(len(x_train_filenames) / float(batch_size))),
                    epochs=epochs,
                    validation_data=val_ds,
                    validation_steps=int(np.ceil(len(x_val_filenames) / float(batch_size))),
                    callbacks=[cp])

fn.plot_loss(history)
fn.plot_predictions(model, val_ds)