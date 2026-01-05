function [sinAi,cosAi]=get_coeffs_atan2(errs,theta)
% cette fonction renvoie le sin et le cos d'un angle Ai, a partir des 2 composantes d'erreur
% pour les 2 cas suivants, dans les quels Cte ne doit pas dépendre de Ai
% CAS 1 :
% errs(1) = A1.sin (Ai) - Cte(1)            
% errs(2) = A2.cos (Ai) - Cte(2)           
% CAS 2 :
% errs(1) = A1.cos (Ai) - Cte(1)            
% errs(2) = A2.sin (Ai) - Cte(2)           


syms c s;
errs=subs(errs,[cos(theta),sin(theta)],[c,s]);
coeffsSin=diff(errs,s);
coeffsCos=diff(errs,c);
Cte=-simplify(errs-coeffsSin*s-coeffsCos*c);
i=find(coeffsSin~=0);
sinAi=Cte(i)./coeffsSin(i);
j=find(coeffsCos~=0);
cosAi=Cte(j)./coeffsCos(j);
ok=(j+i)==3;
ok=ok & (diff(Cte(1),theta)==0)& (diff(Cte(2),theta)==0);
if ~ok,
    error('the 2 equations do not correspond to an atan2 ');
end
end