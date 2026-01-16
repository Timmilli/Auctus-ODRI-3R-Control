import csv
import numpy as np


def lerp(a: float, b: float, t: float) -> float:
    """
    Taken from https://gist.github.com/laundmo/b224b1f4c8ef6ca5fe47e132c8deab56

    Linear interpolate on the scale given by a to b, using t as the point on that scale.
    Examples
    --------
        50 == lerp(0, 100, 0.5)
        4.2 == lerp(1, 5, 0.8)
    """
    return (1 - t) * a + t * b


if __name__ == "__main__":
    traj = np.array(
        [[0.300, 0.030, 0.150], [0.0, 0.030, 0.450]]
    )  # list of (x,y,z) vectors
    p0, p1 = traj

    freq = 500  # Hz
    dt = 1 / freq  # s
    v_max = 0.01  # m/s

    d_travel = p1 - p0
    v_travel = np.linalg.norm(d_travel)

    points = []

    if v_travel > v_max:
        print("Need to interpolate trajectory")
        nb_points = int(v_travel / v_max)
        tr_ratio = lambda x: x / nb_points

        for t in range(nb_points):
            points.append(lerp(p0, p1, tr_ratio(t)))

    else:
        points.append(p1)
    points.append(p1)
    print(points)

    with open("trajectory.csv", mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(points)
