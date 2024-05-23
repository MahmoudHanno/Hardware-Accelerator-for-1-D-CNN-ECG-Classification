# %%
# Load Dataset
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv1D, MaxPooling1D, Flatten, Dense

data = pd.read_csv('ECG_window_df.csv')

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
test_df.to_csv('test_data_with_labels_final1.csv', index=False, header=False)

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
normal = 0
abnormal = 0
for i in range(X_test.shape[0]):
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
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import confusion_matrix, precision_score

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
model.save_weights("model_final_ecg.h5")
print("Saved model to disk")
 

# %%
