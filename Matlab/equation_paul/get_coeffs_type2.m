function [X,Y,Z]=get_coeffs_type2(err,Ai)
% cette fonction renvoie les coefficients X,Y,Z d'une equation de type 2 en Ai
% 'equation de type 2 :X.sin(Ai)+Y.cos(Ai)-Z =0 <=>sin(alpha+Ai)=cte'

syms c s;
err=subs(err,[cos(Ai),sin(Ai)],[c,s]);
X=diff(err,s);
Y=diff(err,c);
Z=-simplify(err-X*s-Y*c);
ok=diff(Z,Ai)==0;
if ~ok,
    error('not a type 2 equation');
end
end
