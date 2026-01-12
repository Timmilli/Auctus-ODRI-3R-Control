# About 

## Bot description

With the master board at the back of the robot, the motors are indexed accordingly:

| Position | Side | Joint | Index |
|---|---|---|---|
| F | R | HAA | 0 |
| F | R | HFE | 11 |
| F | R | K | 9 (not sure) |
| F | L | HAA | 1 |
| F | L | HFE | 3 |
| F | L | K | 2  |
| B | R | HAA | ? |
| B | R | HFE | ? |
| B | R | K | ?  |
| B | L | HAA | ? |
| B | L | HFE | ? |
| B | L | K | ? |

# ROS2 Docker

Directory already setup up to use a Docker with ROS2. See according [README](./ros_docker/README.md)

# Pinocchio

Directory to use Pinocchio. Environment can be setup up via Conda and the `environment.yml` file. See according [README](./Pinocchio/README.md).

# Matlab

Directory containing Matlab code about the dynamics of the robot. See according [README](./Matlab/README.md)
