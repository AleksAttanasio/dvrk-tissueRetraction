import os
import flapnet
import csv
import numpy as np
import matplotlib as mpl
import pandas as pd
import tensorflow as tf
from tensorflow.python.keras import models
from sklearn.model_selection import KFold
from sklearn.model_selection import train_test_split

mpl.rcParams['axes.grid'] = False
mpl.rcParams['figure.figsize'] = (12,12)

#####################################################################
#---------------------------- PARAMETERS ---------------------------#
#####################################################################

img_shape = (64, 64, 3)     # Input image shape
batch_size = 30            # Batch size for training (decrease in case of memory error)
epochs = 200                # Training epochs
testset_size = 0.1          # Percentage of training set data (0.10 = 10%)
dropout_rate = 0.4          # Droput rate
num_filters = 32            # Number of neurons in first layer (subsequent layers have x2 neurons)
learning_rate = 0.001       # Learning rate tuning for optimizer
adam_opt = tf.keras.optimizers.Adam(lr=learning_rate)

kfold = KFold(n_splits=6, shuffle=True, random_state=42)

# FlapNet class init
fn = flapnet.Functions(img_shape, batch_size, epochs)
fn_struct = flapnet.Structure()
fn_losses = flapnet.LossFunction()



# Dataset folders init
# dataset_name = os.path.join('tissue_dataset', 'dataset_baseline')
# img_dir = os.path.join(dataset_name, "train")
# label_dir = os.path.join(dataset_name, "labels")
# df_train = pd.read_csv(os.path.join(dataset_name,'label_map_00.csv'))
# #
dataset_name = os.path.join('tissue_dataset', 'dataset_ready_aug_02')
img_dir = os.path.join(dataset_name, "train")
label_dir = os.path.join(dataset_name, "labels")
df_train = pd.read_csv(os.path.join(dataset_name,'ready_dataset_aug_02.csv'))

#####################################################################
#----------------------------- TRAINING ----------------------------#
#####################################################################

# Load filenames of labels and tra ining objects
x_train_filenames, y_train_filenames = fn.load_all_filenames(   df_train= df_train,
                                                                img_dir= img_dir,
                                                                label_dir= label_dir)

x_train_id = []
y_train_id = []
for i in range(0,len(x_train_filenames)):
    x_train_id.append(i)
    y_train_id.append(i)

print("Number of training examples: {}".format(len(x_train_filenames)))
print("Number of validation examples: {}".format(len(y_train_filenames)))

kfold_dir = 'kfold_5'
try:
    # Create target Directory
    os.mkdir(kfold_dir)
    print("Experiment folder ", kfold_dir, " ---> CREATED ")
except FileExistsError:
    print("Directory ", kfold_dir, " already exists")


csv_score = []
kfold_ind = 0
for train, test in kfold.split(x_train_id, y_train_id):

    if kfold_ind > -1:
        exp_folder, save_model_path = fn.save_filename_kfold(kfold_dir,kfold_ind)
        current_x_train = [x_train_filenames[i] for i in train]
        current_y_train = [y_train_filenames[i] for i in train]
        current_x_test = [x_train_filenames[i] for i in test]
        current_y_test = [x_train_filenames[i] for i in test]

        sub_x_train, sub_x_val, sub_y_train, sub_y_val= \
            train_test_split(current_x_train, current_y_train, test_size=0.2, random_state=42)

        train_ds, val_ds = fn.generate_train_and_val_ds(sub_x_train, sub_y_train, sub_x_val, sub_y_val)
        test_ds = fn.generate_test_ds(current_x_test, current_y_test)
        inputs, outputs = fn_struct.manual_model(img_shape, num_filters=num_filters, dropout_rate=dropout_rate)

        # Training of the model
        model = models.Model(inputs=[inputs], outputs=[outputs])
        model.compile(optimizer=adam_opt,  loss=fn_losses.bce_dice_loss, metrics=[fn_losses.dice_loss, 'accuracy'])
        model.summary()

        # Defining checkpoint to save model
        cp = tf.keras.callbacks.ModelCheckpoint(filepath=save_model_path,
                                                monitor='val_dice_loss',
                                                save_best_only=True,
                                                verbose=1)

        history = model.fit(train_ds,
                            steps_per_epoch=int(np.ceil(len(sub_x_train) / float(batch_size))),
                            epochs=epochs,
                            validation_data=val_ds,
                            validation_steps=int(np.ceil(len(sub_x_val) / float(batch_size))),
                            callbacks=[cp])


        hist_df = pd.DataFrame(history.history)
        hist_csv_file = os.path.join('/home/stormlab/nn_results/', exp_folder)
        name_hist = 'hist_' + str(kfold_ind) + '.csv'
        hist_csv_file = os.path.join(hist_csv_file, name_hist)

        with open(hist_csv_file, mode='w') as f:
            hist_df.to_csv(f)


        # plot and save results
        scores = model.evaluate(test_ds, verbose=0, steps=15)
        print('AAAAAAAAAAAAAAAAAAAA')
        print(scores)
        csv_score.append(scores)



        eval_csv_file = '/home/stormlab/nn_results/kfold_5'
        name_eval = 'eval_final_' + str(kfold_ind) + '.csv'
        eval_csv_file = os.path.join(eval_csv_file, name_eval)

        with open(eval_csv_file, 'w', newline='') as myfile:
            wr = csv.writer(myfile, quoting=csv.QUOTE_ALL)
            wr.writerow(scores)
    kfold_ind = kfold_ind + 1
