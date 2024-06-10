# %%
# Load Dataset
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv1D, MaxPooling1D, Flatten, Dense
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix, precision_score

data = pd.read_csv('dataset_quantized_NA.csv')

print('Dataset before the split:')
print(data.shape)

# %%
# Train and Test split
data = np.array(data)

# Extracting X from the specified columns
X = data[1:, 1:2501]
print(X[10767][2499])

# Extracting y from the first column, starting from the second row
y = data[1:, 0]

# Converting y to categorical
y = to_categorical(y)
print(y.shape)

# Reshaping X for CNN input
X = X.reshape(X.shape[0], X.shape[1], 1)
print(X.shape)

# Splitting the data into training and testing sets
train_data, test_data, train_labels, test_labels = train_test_split(X, y, test_size=0.2, random_state=42)

# Flatten test_data for saving to CSV
test_data_flat = test_data.reshape(test_data.shape[0], -1)

# Combine test_data_flat and test_labels into a single DataFrame
test_data_with_labels = np.hstack((test_data_flat, np.argmax(test_labels, axis=1).reshape(-1, 1)))
test_df = pd.DataFrame(test_data_with_labels)

# Save the DataFrame to a CSV file
#test_df.to_csv('test_data_with_labels_quant.csv', index=False, header=False)

print("Test data and labels saved to 'test_data_with_labels_final1.csv'")

# %%
# Model setup
batch = 64
epochs = 10
input_shape = (2500, 1)

# Layers
model = Sequential()
model.add(Conv1D(4, 5, activation='relu', strides=1, padding='same', input_shape=input_shape))
model.add(MaxPooling1D(5))
model.add(Conv1D(8, 5, activation='relu', strides=1, padding='same'))
model.add(MaxPooling1D(5))
model.add(Conv1D(8, 5, activation='relu', strides=1, padding='same'))
model.add(MaxPooling1D(5))
model.add(Conv1D(16, 5, activation='relu', strides=1, padding='same'))
model.add(MaxPooling1D(5))
model.add(Flatten())
model.add(Dense(2, activation='softmax'))

model.summary()
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

# Training the model
model.fit(train_data, train_labels, batch_size=batch, epochs=epochs)

# Model evaluation
score = model.evaluate(test_data, test_labels, batch_size=batch)
print(f'Test loss: {score[0]} / Test accuracy: {score[1]}')

# %%
X_train = np.expand_dims(train_data, 2)
X_test = np.expand_dims(test_data, 2)
print(X_test[11])
# %%
X_test[11] = np.expand_dims(X_test[10], 0)
test = X_test[11].reshape(1,2500,1)
y_pred = model.predict(test, batch_size = batch)
if(y_pred[0][0]>y_pred[0][1]):
    print('Normal')
else:
    print('Abnormal')
# %%
X_train = np.expand_dims(train_data, 2)
X_test = np.expand_dims(test_data, 2)
normal = 0
abnormal = 0
for i in range(1000):
    X_test[i] = np.expand_dims(X_test[i], 0)
    test = X_test[i].reshape(1,2500,1)
    y_pred = model.predict(test, batch_size = batch)
    if(y_pred[0][0]>y_pred[0][1]):
        print('Normal')
        normal=normal+1
    else:
        print('Abnormal')
        abnormal=abnormal+1


# %%
print('Normal:',normal)
print('Abnormal:',abnormal)
# %%
# %%
# Predicting on the test set
y_pred = model.predict(test_data, batch_size=batch)
y_pred_classes = np.argmax(y_pred, axis=1)
y_true = np.argmax(test_labels, axis=1)

# %%
# Confusion Matrix and Precision


# Compute confusion matrix
cm = confusion_matrix(y_true, y_pred_classes)

# Plot confusion matrix
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=['Normal', 'Abnormal'], yticklabels=['Normal', 'Abnormal'])
plt.xlabel('Predicted labels')
plt.ylabel('True labels')
plt.title('Confusion Matrix')
plt.show()

# Calculate precision
precision = precision_score(y_true, y_pred_classes)
print(f'Precision: {precision:.4f}')


# %%
# serialize weights to HDF5
model.save_weights("model_final_ecg_quant.h5")
print("Saved model to disk")
 

# %%
# Save the model architecture
model_json = model.to_json()
with open('model_architecture.json', 'w') as json_file:
    json_file.write(model_json)

# Save the weights
model.save_weights('model_final_ecg_quant.h5')


# %%
import numpy as np
import tensorflow as tf
import json
import h5py

# Load model architecture
with open('model_architecture.json', 'r') as json_file:
    model_json = json_file.read()

model = tf.keras.models.model_from_json(model_json)

# Load model weights
model.load_weights('model_final_ecg_quant.h5')

# Quantize the weights to signed 8-bit integers
def quantize_weights(weights):
    if len(weights) == 0:
        return []
    max_val = np.max(np.abs(weights))
    scale = 127 / max_val  # 127 is the max value of int8
    quantized_weights = np.round(weights * scale).astype(np.int8)
    return quantized_weights

# Go through each layer, quantize non-empty weights, and save
with h5py.File('model_final_ecg_quantized.h5', 'w') as f:
    layer_idx = 0
    for layer in model.layers:
        layer_weights = layer.get_weights()
        if layer_weights:  # Check if the layer has weights
            quantized_layer_weights = [quantize_weights(w) for w in layer_weights]
            layer_group = f.create_group(f'layer_{layer_idx}')
            for j, w in enumerate(quantized_layer_weights):
                layer_group.create_dataset(f'weight_{j}', data=w)
            layer_idx += 1


# %%
# Evaluate on the first 1000 samples with timing
import time

first_1000_test_data = test_data[:1000]
first_1000_test_labels = test_labels[:1000]

start_time = time.time()
score_1000 = model.evaluate(first_1000_test_data, first_1000_test_labels, batch_size=batch)
end_time = time.time()

time_taken = end_time - start_time
print(f'Time taken to evaluate first 1000 samples: {time_taken:.4f} seconds')

print(f'First 1000 samples - Test loss: {score_1000[0]} / Test accuracy: {score_1000[1]}')

# Predict on the first 1000 samples
y_pred_1000 = model.predict(first_1000_test_data, batch_size=batch)
y_pred_classes_1000 = np.argmax(y_pred_1000, axis=1)
y_true_1000 = np.argmax(first_1000_test_labels, axis=1)

# Confusion Matrix and Precision for the first 1000 samples
cm_1000 = confusion_matrix(y_true_1000, y_pred_classes_1000)

plt.figure(figsize=(8, 6))
sns.heatmap(cm_1000, annot=True, fmt='d', cmap='Blues', xticklabels=['Normal', 'Abnormal'], yticklabels=['Normal', 'Abnormal'])
plt.xlabel('Predicted labels')
plt.ylabel('True labels')
plt.title('Confusion Matrix for the first 1000 samples')
plt.show()

precision_1000 = precision_score(y_true_1000, y_pred_classes_1000)
print(f'Precision for the first 1000 samples: {precision_1000:.4f}')
# %%
