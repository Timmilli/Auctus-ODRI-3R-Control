
clear all;
syms V1 W1 X1 Y1 Z1 V2 W2 X2 Y2 Z2;
syms c1 s1 t1 c2 s2 t2;;
%---------------------------------------------------------------------------------------------------
% PROBLEME A RESOUDRE 
% on cherche  a trouver A1 and A2 solutions de  
%  V1.c1 + W1.s1 + X1.c2 +Y1.s2 - Z1=0                              [0 ]                                  
%                                                                       <=>    Err=        [   ]                                                      
%  V2.c1 + W2.s1 + X2.c2 +Y2.s2 - Z2=0                              [0]                                                                                                             
%                                                                                                                                                
% avec c1=cos(A1),s1=sin(A1), c2=cos(A2),s2=sin(A2)
%---------------------------------------------------------------------------------------------------
% Methode dyalitique 
% PHASE 1 : 
% on remplace c1 ,s1,c2, s2 par leurs expressions en fonction des tangentes des angle moitie: t1=tan(A1/2) , t2=tan(A2/2)
%  ce qui donne 
% c1= (1-t1^2)/(1+t1^2) , s1= 2.t1/(1+t1^2) , c2= (1-t2^2)/(1+t2^2) , s1= 2.t2/(1+t2^2) 
Err=[V1*c1+W1*s1+X1*c2+Y1*s2-Z1;V2*c1+W2*s1+X2*c2+Y2*s2-Z2];
Err=subs(Err,[c1,s1,c2,s2],[(1-t1^2)/(1+t1^2),(2*t1)/(1+t1^2),(1-t2^2)/(1+t2^2),(2*t2)/(1+t2^2)]);
% on fait apparaitre une erreur sans denominateur
Err=simplify(Err*(1+t1^2)*(1+t2^2));
[num,den]=numden(Err);
Err=num./den;
%----------------------------------------------------------------------------------------
% PHASE 2 :
% on ecrit l'erreur sous la forme : Err = M(t1,t1^2) .[1,t2;t2^2], 
% M est une matrice 2X3, 
% et le systeme a resoudre s'ecrit 
% [1]:  M.[1;t2;t2^2]=[0;0], 
%on a donc une infinite de solutions non triviales
%----------------------------------------------------------------------------------
syms t2_2;
Err=subs(Err,[t2^2],[t2_2]);
M=[subs(Err,[t2,t2_2],[0,0]),diff(Err,t2),diff(Err,t2_2)];
Verif= simplify(Err-M*[1;t2;t2_2]) % si tout est correct Verif est un vecteur 2X1 de zeros
%------------------------------------------------------------------------------------------------------------------------
% PHASE 3 :
% On multiplie mentalement l'erreur par t2 , ce qui fait apparaitre 
% 2 nouvelles equations et une nouvelle inconnue t2^3
% [2] : M.[t2;t2^2;t2^3]=[0;0]
% le systeme global a resoudre devient un systeme de 4 equations a 4 inconnues
% [1] :  [M,Z] .[1;t2;t2^2;t2^3] = [0;0]
% [2] :  [Z,M] .[1;t2;t2^2;t2^3] = [0;0]
% avec Z une matrice de zeros a 2 lignes et une colonne
% <=> H . [1;t2;t2^2;t2^3] =[0;0;0;0]
%------------------------------------------------------------------------------------------------------
Z=sym(zeros(2,1));
H=[M,Z;Z,M];
%------------------------------------------------------------------------------------------------------------------------
% PHASE 4 :
% ce nouveau systeme a une solution non triviale uniquement si det(H) =0
% Or det(H) est un polynome de degre 8 en t1,
% dont on n'a plus qu'a calculer les coeffs pour trouver les racines
% pour chacune des racines t1_i du deteminant :
% la solution non triviale  [1;t2;t2^2;t2^3] 
% est le vecteur propre de H(t1) associe a la valeur propre 0
% Donc pour resoudre le probleme numeriquement
% on doit disposer 
% 1- d'une fonction qui calcule les coeffs c du polynome en t1 det_H
% 2- d'une fonction  qui calcule la matrice H connaissant t1
%------------------------------------------------------------------------------------------------------
det_H=det(H);
[c,t]=coeffs(det_H,t1)
matlabFunction(c,'File','calcCoeffsdetH_t1','Vars',[V1 W1 X1 Y1 Z1 V2 W2 X2 Y2 Z2]);
matlabFunction(H,'File','calcH_t1','Vars',[V1 W1 X1 Y1 Z1 V2 W2 X2 Y2 Z2,t1]);
%-------------------------------------------------------------------------------------
% c'est termine :
% ces fonctions seront employees dans la fonction
% solve_2angles_dyalitic
%--------------------------------------------------------------------------------------












