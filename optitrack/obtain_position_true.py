# Effector(x,y,z) Knee(x,y,z) Hip_1 (x,y,z) Hip_2 (x,y,z) Base(x,y,z)
from typing import List

Heffector = 0.035 #m
Hhip2 = 0.030 #m
H1 = 0.093 #m
H2 = 0.055 #m

# move space origin to the base
def place_origin(points): #[Effector, Knee, Hip_1, Hip_2, Base]
    for i in points:
        for j in range(3):
            i[j] = i[j] - points[-1][j]
    return points

# vectors reprensent links between tracked balls
def build_vectors(points ): #[Effector, Knee, Hip_1, Hip_2]
    EK = [0,0,0]
    KH = [0,0,0]
    HH = [0,0,0]
    links = [EK, KH, HH]
    for i in range (len(links)):
        for j in range(3):
            links[i][j] =  points[i][j]-points[i+1][j]
    return links

# find the normal vector of the leg
def build_normal_vector(vectorA, vectorB):
    return [
        vectorA[1]*vectorB[2] - vectorA[2]*vectorB[1],
        vectorA[2]*vectorB[0] - vectorA[0]*vectorB[2],
        vectorA[0]*vectorB[1] - vectorA[1]*vectorB[0]
        ]

# use normal vector and known length do go from tracked ball position to articulations
def correct_point_position(H1,H2,Heffector,Hhip2,normal_vector,points):
    points[0] = points[0] - [Heffector*x for x in normal_vector]
    points[1] = points[1] - [H2*x for x in normal_vector]
    points[2] = points[2] - [H1*x for x in normal_vector]
    points[3] = points[3] - [Hhip2*x for x in normal_vector]
    return points

# wrapping function for computing seen above
def compute(points,H1,H2,Heffector,Hhip2):
    points_o = place_origin(points)
    links = build_vectors(points_o)
    normal = build_normal_vector(links[0],links[1])
    points_o_a = correct_point_position(H1,H2,Heffector,Hhip2,normal, points_o)
    return points_o_a

# wrapping function to treat a whole data set
def general_compute(data):
    true_points = []
    for i in data:
        true_points.append(compute(i,H1,H2,Heffector,Hhip2))
    return true_points