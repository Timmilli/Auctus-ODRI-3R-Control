# Récupération de données du robot
Ce répertoire se sépare en deux parties :
- les *sub-modules* utilisés provenant du projet ODRI original
- les fichiers de code utilisant le `master-board-sdk` pour piloter le robot

Les deux sub-modules sont celui de la carte électronique principale et de
l'interface de contrôle du robot.

## Fichiers de code personnels
Les dossiers `src/` et `srcpy/` contiennent du code écrit par nous avec certains
morceaux directement repris du projet ODRI. 

### `srcpy/`
Le script `trajectory.py` permet de générer une liste de points par
interpolation linéaire, à partir d'une vitesse maximale et d'une fréquence de
communication avec le robot. Ce script prend en entrées une liste
de points (x, y, z) donnée dans un repère quelconque à atteindre.

Pour une fréquence de communication à 500 Hz, chaque commande est envoyée tout
les 2ms. En prenant deux points A et B, issus de la trajectoire générée, on
aimerait que le robot ait atteint le point A à la fin des 2 ms, et qu'une
nouvelle commande le fasse aller au point B, tout en étant limité à une certaine
vitesse maximale.

Les points sont inscrits dans le code, et à l'exécution, le script génère un
fichier .csv avec les points générés.


Le script `pid_study.py` ouvre un fichier produit par le binaire
`pid_optimization`, et génère un graphique afin de visualiser l'erreur de la
commande envoyée au fil du temps, qu'on utilise pour adapter les coefficients
du contrôleur PID. Le nom de fichier est à renseigner dans le code.

### `src/`

## Sub-modules du projet ODRI
En parallèle, les modules `master-board` et `odri_control_interface`. L'objectif
était d'utiliser l'interface de contrôle fournie par le projet ODRI afin de
profiter de ses fonctionnalités (calibration des zéros, inversion des phases..).
Par manque de temps, il n'a pas pu être modifié pour le contrôle d'une patte.
Cependant l'image Docker produite dans le dossier plus haut permet de compiler
ces deux dossiers afin de lancer les exemples présents dans
`odri_control_interface/demos`, depuis le conteneur.



