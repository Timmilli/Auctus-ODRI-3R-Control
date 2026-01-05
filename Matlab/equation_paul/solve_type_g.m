%--------------------------------------------------------------
% solution d'une equation unifiee avec 2 angles
%--------------------------------------------------------------
  function S=solve_type_g(V1,W1,X1,Y1,Z1,V2,W2,X2,Y2,Z2)
    S=struct();S.name='2 equations quelconques avec 2 angles:[1] V1.cos (Ai)+W1.sin(Ai) + X1.cos(Ak) +Y1.sin(Ak)-Z1=0;[2] V2.cos (Ai)+W2.sin(Ai) + X2.cos(Ak) +Y2.sin(Ak)-Z2=0';
    S.V1=V1;
    S.W1=W1;
    S.X1=X1;
    S.Y1=Y1;
    S.Z1=Z1;
    S.V2=V2;
    S.W2=W2;
    S.X2=X2;
    S.Y2=Y2;
    S.Z2=Z2;
   %coefficients du polynome en t1 =det(H) ; avec t1= tan(Ai/2)
   S.c=calcCoeffsdetH_t1(V1,W1,X1,Y1,Z1,V2,W2,X2,Y2,Z2);
   % solutions en t1
   sols_t1=roots(S.c);
   % on ne garde que les solutions reelles
   k=find(abs(imag(sols_t1))<=1e-9);
   sols_t1=real(sols_t1(k));
   % pour chacune des solutions, on calcule H, on en deduit le vecteur
   % propre X0=[1;t2;t2^2;t2^3] associe a la valeur propre 0, 
   % et on verifie apres normalisation qu'il a bien cette forme
   t1=zeros(0,1);t2=zeros(0,1);
   for i1=1:length(sols_t1)
       t1i=sols_t1(i1);
       H=calcH_t1(V1,W1,X1,Y1,Z1,V2,W2,X2,Y2,Z2,t1i);
       [UH,SH,VH]=svd(H);
       X0=VH(:,end);
       if (abs(X0(1))>=1e-9)
           X0=X0/X0(1);
           % si solution valable, X0 est de la forme [1,t2,t2^2,t2^3], on
           % verifie avec methode des moindres carres
           Y=X0(2:end);A=X0(1:(end-1));t2i=pinv(A)*Y;
           Err=Y-A*t2i;
           ok = norm(Err)<=1e-5*norm(Y);
           if ok ,
               t1=[t1;t1i];
               t2=[t2;t2i];
           end           
       end
   end
   S.tg_Aisur2=t1;
   S.tg_Aksur2=t2;
   S.Ai=2*atan(S.tg_Aisur2);
   S.Ak=2*atan(S.tg_Aksur2);
   S.nb_sols=length(S.Ai);
   S.Verif1=cos(S.Ai)*V1+sin(S.Ai)*W1+cos(S.Ak)*X1+sin(S.Ak)*Y1-Z1;
   S.Verif2=cos(S.Ai)*V2+sin(S.Ai)*W2+cos(S.Ak)*X2+sin(S.Ak)*Y2-Z2;
   
   
   
  end
  
  