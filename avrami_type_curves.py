import pandas as pd
import matplotlib.pyplot as plt

def plot_data(csv_file):
    # Load the CSV data
    data = pd.read_csv(csv_file)

    # Filter out rows where both integral_c and integral_w are zero
    data = data[(data['integral_c'] != 0) | (data['integral_w'] != 0)]

    system_volume = 50 * 10  # Assuming dimensions are 50 nm x 10 nm

    # Divide integral_c and integral_w by the system volume
    data['integral_c'] /= system_volume
    data['integral_w'] /= system_volume

    # Debugging step: Print first few rows to ensure data is correct
    print(data.head())

    # Plot integral_c vs. time
    plt.figure(figsize=(10, 6))
    plt.plot(data['time'], data['integral_c'], label='Integral of c')
    plt.xlabel('Time')
    plt.ylabel('Integral of c')
    plt.title('Integral of c vs. Time')
    plt.ylim(0, 1)  # Set y-axis limits between 0 and 1
    plt.legend()
    plt.grid(True)
    plt.savefig('integral_c_vs_time.png')

    # Plot integral_w vs. time
    plt.figure(figsize=(10, 6))
    plt.plot(data['time'], data['integral_w'], label='Integral of w', color='orange')
    plt.xlabel('Time')
    plt.ylabel('Integral of w')
    plt.title('Integral of w vs. Time')
    plt.legend()
    plt.grid(True)
    plt.savefig('integral_w_vs_time.png')

if __name__ == "__main__":
    # Directly specify the CSV file name
    csv_file = 'composite_mobility_cahn_hilliard_out.csv'
    plot_data(csv_file)
