import matplotlib.pyplot as plt

def display_frame(points):

    # Separate coordinates
    x = [p[0] for p in points]
    y = [p[1] for p in points]
    z = [p[2] for p in points]

    # Create 3D plot
    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')

    # Plot points
    ax.scatter(x, y, z, s=50)

    # Link points in order
    ax.plot(x, y, z)

    # Label axes
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')

    # Save image
    plt.savefig("points_3d.png", dpi=300, bbox_inches="tight")

    # Close the figure
    plt.close(fig)