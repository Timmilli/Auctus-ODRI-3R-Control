function [VWXYZ_12]=get_coeffs_2angles(err1,err2,A1,A2)
%  V1.c1 + W1.s1 + X1.c2 +Y1.s2 - Z1=0                              [0 ]                                  
%                                                                       <=>    Err=        [   ]                                                      
%  V2.c1 + W2.s1 + X2.c2 +Y2.s2 - Z2=0                              [0]                                  
syms c1 s1 c2 s2;
err1=subs(err1,[cos(A1),sin(A1)],[c1,s1]);
err1=subs(err1,[cos(A2),sin(A2)],[c2,s2]);
err2=subs(err2,[cos(A1),sin(A1)],[c1,s1]);
err2=subs(err2,[cos(A2),sin(A2)],[c2,s2]);

V1=diff(err1,c1);
W1=diff(err1,s1);
X1=diff(err1,c2);
Y1=diff(err1,s2);
Z1=-simplify(err1-V1*c1 - W1*s1 - X1*c2 -Y1*s2);
ok=( diff(Z1,A1)==0 )&( diff(Z1,A2)==0);
if ~ok,
    error('pb sur equation 1');
end
V2=diff(err2,c1);
W2=diff(err2,s1);
X2=diff(err2,c2);
Y2=diff(err2,s2);
Z2=-simplify(err2-V2*c1 - W2*s1 - X2*c2 -Y2*s2);
ok=( diff(Z2,A1)==0 )&( diff(Z2,A2)==0);
if ~ok,
    error('pb sur equation 2');
end
VWXYZ_12=[[V1,W1,X1,Y1,Z1];[V2,W2,X2,Y2,Z2]];

end
