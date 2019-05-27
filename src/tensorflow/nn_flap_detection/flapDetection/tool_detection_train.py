import os
import flapnet
import seismicnet
import numpy as np
import matplotlib as mpl
import pandas as pd
import tensorflow as tf
from tensorflow.python.keras import models
mpl.rcParams['axes.grid'] = False
mpl.rcParams['figure.figsize'] = (12,12)

#####################################################################
#---------------------------- PARAMETERS ---------------------------#
#####################################################################

img_shape = (64, 64, 3)     # Input image shape
batch_size = 30             # Batch size for training (decrease in case of memory error)
epochs = 2                # Training epochs
testset_size = 0.10         # Percentage of training set data (0.10 = 10%)
dropout_rate = 0.1          # Droput rate
num_filters = 2            # Number of neurons in first layer (subsequent layers have x2 neurons)
learning_rate = 0.001       # Learning rate tuning for optimizer

# FlapNet class init
fn = flapnet.Functions(img_shape, batch_size, epochs)
fn_struct = flapnet.Structure()
fn_losses = flapnet.LossFunction()
sn = seismicnet.seismicnet()

# Create folder for experimental results and model path
exp_folder, save_model_path = fn.save_filename_specs(testset_size, num_filters, dropout_rate, learning_rate)

# Dataset folders init
dataset_name = os.path.join('tissue_dataset', 'dataset_ready_aug_00')
img_dir = os.path.join(dataset_name, "merged_training_00")
label_dir = os.path.join(dataset_name, "merged_masks_00_gif")
df_train = pd.read_csv(os.path.join(dataset_name,'label_map_aug_00.csv'))

#####################################################################
#----------------------------- TRAINING ----------------------------#
#####################################################################

# Load filenames of labels and training objects
x_train_filenames, x_val_filenames, y_train_filenames, y_val_filenames = fn.load_filenames(df_train= df_train,
                                                                                           img_dir= img_dir,
                                                                                           label_dir= label_dir,
                                                                                           test_size= testset_size)

print("Number of training examples: {}".format(len(x_train_filenames)))
print("Number of validation examples: {}".format(len(x_val_filenames)))

# Show instances of the dataset
fn.show_dataset_labels(x_train=x_train_filenames, y_train=y_train_filenames)

# Generating dataset for training
train_ds, val_ds = fn.generate_train_and_val_ds(x_train_filenames, y_train_filenames, x_val_filenames, y_val_filenames)
adam_opt = tf.keras.optimizers.Adam(lr=learning_rate)

# NN structure definition
# inputs, outputs = fn_struct.custom_model(img_shape, num_filters=num_filters, dropout_rate=dropout_rate)
model = sn.get_unet(img_shape=img_shape)

# Training of the model
# model = models.Model(inputs=[inputs], outputs=[outputs])
model.compile(optimizer='adam',  loss=fn_losses.bce_dice_loss, metrics=[fn_losses.dice_loss])
model.summary()

# Defining checkpoint to save model
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

# plot and save results
fn.plot_and_save_loss(history, exp_folder)
fn.plot_and_save_predictions(model, val_ds, exp_folder)