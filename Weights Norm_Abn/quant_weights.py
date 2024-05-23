# %%
#Load Dataset
import numpy as np 
import pandas as pd 
data = pd.read_csv('fc.csv',header=None)
min=-5.12
print('Dataset before the split:')
print(data.shape)

data = np.array(data)

X = data
X = X.reshape(X.shape[0],X.shape[1],1)
print(X[0][0])
min=np.min(X)
max=np.max(X)
print(min)
print(max)
if abs(min)>max:
    max=abs(min)
else:
    max=max
print(max)

for i in range(X.shape[0]):
    for j in range(X.shape[1]):
        temp=((X[i][j])/max)*127
        X[i][j]=np.around(temp,0)
print(np.max(X))
print(np.min(X))
X_squeezed = np.squeeze(X)

# Convert the squeezed array to a DataFrame
df = pd.DataFrame(X_squeezed)

# Save the DataFrame to a CSV file
df.to_csv('fc_quant.csv', index=False)
# %%
import numpy as np
import pandas as pd
import os

# Define the directory containing the files and list of files to process
directory = r'E:\CNN Test\Weights Norm_Abn'  # Update this path
filenames = [
    'layer1.csv', 'layer2_0.csv', 'layer2_1.csv', 'layer2_2.csv', 'layer2_3.csv', 
    'layer3_0.csv', 'layer3_1.csv', 'layer3_2.csv', 'layer3_3.csv', 'layer3_4.csv',
    'layer3_5.csv', 'layer3_6.csv', 'layer3_7.csv', 'layer4_0.csv', 'layer4_1.csv',
    'layer4_2.csv', 'layer4_3.csv', 'layer4_4.csv', 'layer4_5.csv', 'layer4_6.csv',
    'layer4_7.csv'
]

# Define the minimum value for scaling

for filename in filenames:
    # Construct the full path to the file
    file_path = os.path.join(directory, filename)
    
    # Load Dataset
    data = pd.read_csv(file_path, header=None)
    print(f'Processing {filename}, Shape: {data.shape}')
    
    # Convert DataFrame to NumPy array
    X = np.array(data)
    
    # Reshape the data
    X = X.reshape(X.shape[0], X.shape[1], 1)
    min=np.min(X)
    max=np.max(X)
    if abs(min)>max:
        max=abs(min)
    else:
        max=max
    print(max)
    # Process the data
    for i in range(X.shape[0]):
        for j in range(X.shape[1]):
            temp = (((X[i][j]) / max)) * 127
            X[i][j] = np.around(temp, 0)
    print(f'Max value: {np.max(X)}')
    print(f'Min value: {np.min(X)}')
    # Remove the singleton dimension
    X_squeezed = np.squeeze(X)
    
    # Convert the squeezed array to a DataFrame
    df = pd.DataFrame(X_squeezed)
    
    # Save the DataFrame to a new CSV file
    output_filename = f'{os.path.splitext(filename)[0]}_quant.csv'
    output_path = os.path.join(directory, output_filename)
    df.to_csv(output_path, index=False)
    
    print(f'Saved processed data to {output_filename}')

# %%
