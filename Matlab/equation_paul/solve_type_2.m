%--------------------------------------------------------------
% solution d'une equation de type 2
%--------------------------------------------------------------
  function S=solve_type_2(X,Y,Z)
  tolRel=1e-6; % relative Tolerance  for too big modulus  
  S=struct();S.name='equation de type 2 :X.sin(Ai)+Y.cos(Ai)=Z<=>sin(alpha+Ai)=cte';
    S.X=X;
    S.Y=Y;
    S.Z=Z;
    module=sqrt(X^2+Y^2);
    % no solutions if |Z| >(1+tolRel) .Module
    if module<abs(Z)/(1+tolRel) 
      S.nb_sols=0;
      S.well_posed=1;
      S.Ai=[];
      return;
    end
    S.Zlimited=min([abs(Z),module])*sign(Z); % limit |Z| if |Z]/module >1   
    if (module==0)
      S.nbsols=inf;
      S.well_posed=0;
      return;
    end
    
    if module==abs(S.Zlimited)
        S.nb_sols=1;
    else
        S.nb_sols=2;
    end    
    S.well_posed=1;
    S.cos_alpha=X/module;
    S.sin_alpha=Y/module;
    S.alpha=atan2(S.sin_alpha,S.cos_alpha);
    S.cte=S.Zlimited/module;
    S.Ai=zeros(S.nb_sols,1); % vecteur de zeros, 2 lignes, 1 colonne
    S.Ai(1)= asin(S.cte)-S.alpha;
    if S.nb_sols==2
       S.Ai(2)= pi-asin(S.cte)-S.alpha;
    end
    S.Ai=get_arg_nearest_zero(S.Ai);
    S.verif=zeros(S.nb_sols,1); % verification
    for n=1:S.nb_sols,
      Ai=S.Ai(n);
      S.verif(n)=Z- (X*sin(Ai)+Y*cos(Ai));
    end
  % les 2 solutions de sin(alpha+A)=cte sont  A1 =asin(cte)-alpha, et A2 =pi - asin(cte) -alpha
  end

  