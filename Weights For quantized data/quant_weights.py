# %%
#Load Dataset
import numpy as np 
import pandas as pd 
data = pd.read_csv('bias2_unquantized.csv',header=None)

print('Dataset before the split:')
print(data.shape)

data = np.array(data)
max1=0.4640245139598846
max2=0.4003418684005737
max3=0.3760168254375458
max4=0.3277927935123443
X = data
X = X.reshape(X.shape[0],X.shape[1],1)
print(X[0][0])
# %%
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
# %%
for i in range(X.shape[0]):
    for j in range(X.shape[1]):
        temp=((X[i][j])/max2)*127
        X[i][j]=np.around(temp,0)
print(np.max(X))
print(np.min(X))
X_squeezed = np.squeeze(X)

# Convert the squeezed array to a DataFrame
df = pd.DataFrame(X_squeezed)

# Save the DataFrame to a CSV file
df.to_csv('bias2_quant.csv', index=False)
# %%
import numpy as np
import pandas as pd
import os

# Define the directory containing the files and list of files to process
directory = r'E:\CNN Test\Weights Norm_Abn'  # Update this path
filenames = [
    'layer1.csv', 'layer2_0.csv', 'layer2_1.csv', 'layer2_2.csv', 'layer2_3.csv', 
    'layer3_0.csv', 'layer3_1.csv', 'layer3_2.csv', 'layer3_3.csv', 'layer3_4.csv',
    'layer3_5.csv', 'layer3_6.csv', 'layer3_7.csv', 'layer4_0.csv', 'layer4_2.csv',
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
import numpy as np
import pandas as pd
import os

# Define the directory containing the files and list of files to process
directory = r'E:\CNN Final\Weights For quantized data'  # Update this path
layer_filenames = {
    'layer1': ['layer1_noquant.csv','bias1_unquantized.csv'],
    'layer2': ['layer2_1_noquant.csv', 'layer2_2_noquant.csv', 'layer2_3_noquant.csv', 'layer2_4_noquant.csv','bias2_unquantized.csv'],
    'layer3': ['layer3_1_noquant.csv', 'layer3_2_noquant.csv', 'layer3_3_noquant.csv', 'layer3_4_noquant.csv',
               'layer3_5_noquant.csv', 'layer3_6_noquant.csv', 'layer3_7_noquant.csv', 'layer3_8_noquant.csv','bias3_unquantized.csv'],
    'layer4': ['layer4_1_noquant.csv', 'layer4_2_noquant.csv', 'layer4_3_noquant.csv', 'layer4_4_noquant.csv',
               'layer4_5_noquant.csv', 'layer4_6_noquant.csv', 'layer4_7_noquant.csv', 'layer4_8_noquant.csv','bias4_unquantized.csv'],
    'fc':     ['fc_noquant.csv','fc_bias_unquantized.csv']
}

# Define the minimum value for scaling
for layer, filenames in layer_filenames.items():
    max_values = []
    for filename in filenames:
        # Construct the full path to the file
        file_path = os.path.join(directory, filename)

        # Load Dataset
        data = pd.read_csv(file_path, header=None)
        X = np.array(data)

        # Find the maximum absolute value in the layer
        max_value = np.max(np.abs(X))
        max_values.append(max_value)

    # Use the maximum value for scaling in the layer
    max_layer = max(max_values)
    print(f'Maximum value in {layer}: {max_layer}')

    # Process and quantize the data in the layer
    for filename in filenames:
        # Construct the full path to the file
        file_path = os.path.join(directory, filename)

        # Load Dataset
        data = pd.read_csv(file_path, header=None)
        X = np.array(data)

        # Process the data
        for i in range(X.shape[0]):
            for j in range(X.shape[1]):
                temp = ((X[i][j]) / max_layer) * 127
                X[i][j] = np.around(temp, 0)

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
import pandas as pd

# Read the CSV files without treating the first row as header
df1 = pd.read_csv('fc_noquant_quant.csv')
df2 = pd.read_csv('layer4_2_noquant_quant.csv')
df3 = pd.read_csv('layer4_3_noquant_quant.csv')
df4 = pd.read_csv('layer4_4_noquant_quant.csv')
df5 = pd.read_csv('layer4_5_noquant_quant.csv')
df6 = pd.read_csv('layer4_6_noquant_quant.csv')
df7 = pd.read_csv('layer4_7_noquant_quant.csv')
df8 = pd.read_csv('layer4_8_noquant_quant.csv')







# Create Verilog initialization strings
def create_verilog_init_str(df, base_name, x):
    verilog_str = ""
    for i in range(2):  # Always iterate 8 times
        if i < len(df.columns):
            column = df.iloc[:, i].values.tolist()
        else:
            column = [0] * 64  # Use a default value if the column does not exist
        verilog_str += f"{base_name}{(i+1)} = '{{{', '.join(map(str, column[:64]))}}};\n"
    verilog_str+="\n"
    return verilog_str

# Generate Verilog initialization code
verilog_code = "// Initialize filter values using concatenation from layer2_X.csv\n"
verilog_code += create_verilog_init_str(df1, "filter", 1)





print(verilog_code)

# %%
