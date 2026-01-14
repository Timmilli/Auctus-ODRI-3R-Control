# Modeling and control of a 3R bot

Based on the ODRI [TODO link] quadruped bot, this project aims to perfect the modeling and the control of one paw.

<div style="display: flex; justify-content: center;">
    <img alt='gif of the bot'
         src='images/logo_auctus.png' />
</div> <!-- TODO-->

## 📄 This project in short

This paragraph is for the visitors who fly over your work and cannot read the whole documentation. They dislike long texts.

Be **concise** and **convincing** to show the potential of your project. Be **honest** and list the limitations.  

* The context and the intented users
* The problems solved by your project
* How it solves them

## 🚀 Quickstart (if relevant)

* **Install instructions**: List of software/hardware dependencies, and instructions to install them if relevant
* **Launch instructions**: Few lines of code to launch the main feature of your project

If this is written in user or dev docs, provide links.

## 🔍 About this project

|       |        |
|:----------------------------:|:-----------------------------------------------------------------------:|
| 💼 **Client**                |  AUCTUS
| 🔒 **Confidentiality**        | **Public**                                          |
| ⚖️ **License**               |  [TODO]
| 👨‍👨‍👦 **Authors**               |  Thomas Wanchai **Menier**, Quentin **Fallito**, Guénaël **Roger**    |

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


# License

[TODO]

<div style="display: flex; justify-content: center; gap: 3rem;">
    <img alt='auctus logo'
         src='images/logo_auctus.png' 
         height=80/>
    <img alt='emmk_logo'
         src='images/logo_em.jpg'
         height=80/>
</div>
