import matplotlib.pyplot as plt
import csv
import numpy as np


def main():
    i = 0
    t, err = np.array([]), np.array([])
    with open("filename.csv", newline="") as csvfile:
        file = csv.reader(csvfile, delimiter=",")
        for row in file:
            i += 1
            try:
                t = np.append(t, float(row[0]))
                err = np.append(err, float(row[1]))
            except ValueError as e:
                print("row", i, ":", e)

    # min_err = np.min(err)
    # err -= min_err

    # cons63 = np.zeros(np.size(err))
    # cons63 += 63
    # cons95 = np.zeros(np.size(err))
    # cons95 += 95
    # cons105 = np.zeros(np.size(err))
    # cons105 += 105

    plt.plot(t, err)
    # plt.plot(t, cons63)
    # plt.plot(t, cons95)
    # plt.plot(t, cons105)
    plt.grid()
    plt.show()


if __name__ == "__main__":
    main()
