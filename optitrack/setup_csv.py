import csv

frames = []

with open("data.csv", newline="") as f:
    reader = csv.DictReader(f)

    for row in reader:
        frame = []

        for i in range(1, 6):
            frame.append([
                float(row[f"X{i}"]),
                float(row[f"Y{i}"]),
                float(row[f"Z{i}"]),
            ])

        frames.append(frame)
