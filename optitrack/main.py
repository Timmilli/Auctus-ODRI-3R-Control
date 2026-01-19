from setup_csv import csv_to_list
from obtain_position_true import general_compute
from display_position import display_frame
import matplotlib.pyplot as plt


if __name__ == "__main__":
    csv_path = "take_test.csv"
    data = csv_to_list(csv_path)
    results = general_compute(data)
    # display_frame(results[-1])
    k=0
    for i in results:
        k+=1 
            # Separate coordinates
        x = [p[0] for p in i]
        y = [p[1] for p in i]
        z = [p[2] for p in i]

        # Create 3D plot
        fig = plt.figure()
        ax = fig.add_subplot(projection='3d')

        # Plot results[-1]
        ax.scatter(x, y, z, s=50)

        # Link results[-1] in order
        ax.plot(x, y, z)

        # Label axes
        ax.set_xlabel('X')
        ax.set_ylabel('Y')
        ax.set_zlabel('Z')
        plt.savefig(f"frame_{k}.png", dpi=300, bbox_inches="tight")

        # Close the figure
        plt.close(fig)
