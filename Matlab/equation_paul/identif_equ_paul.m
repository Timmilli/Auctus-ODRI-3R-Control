function equation=identif_equ_paul(vars,equs,fileName_)

  syms W W1 W2 X Y Z X1 Y1 X2 Y2 Z1 Z2 Ai Ak Re Im real;
  syms ci si ck sk Rj real;
    if (nargin<3)
    fileName='clc';
  else
    fileName=fileName_;
  end

  equPaul=cell(8,1);
  % equations en colonne ( pour compatibilite de taille avec les mmatrices de permutation )
  [m,n]=size(equs);
  if (n>m)
    equs=equs.';
  end
  for i=1:length(equPaul)
    equPaul{i}.type=i;
  end
  % permutations in the case of 2 equations
  permutsEqu=cell(4,1);
  permutsEqu{1}=[1,0;0,1];
  permutsEqu{2}=[-1,0;0,1];
  permutsEqu{3}=[0,1;1,0];
  permutsEqu{4}=[0,1;-1,0];
  noPermut=cell(1,1);noPermut{1}=1;
  % chgt de variables avec 1 angle
  syms Ai Ak real;
  chgtVarAi=[  Ai;sym(pi)/2-Ai];
  chgtVarRjAi=[  Rj,Ai;Rj,sym(pi)/2-Ai;Ai,Rj;sym(pi)/2-Ai,Rj];

  % chgts de variables avec 2 angles
  syms Ai Ak real;
  chgtVarAkAi=[  Ak,Ai;
  Ai,Ak;
  sym(pi)/2-Ak,Ai;
  Ak,sym(pi)/2-Ai;
  sym(pi)/2-Ak,sym(pi)/2-Ai;
  sym(pi)/2-Ai,sym(pi)/2-Ak];
  % pour calculer les variables en entrée depuis les resultats des equations
  syms v1 v2 real;

  equPaul{1}.equ=[X*si-Im;X*ci-Re];
  equPaul{1}.vars=Ai;
  equPaul{1}.varsJac=[ci,si];
  equPaul{1}.chgtVar=chgtVarAi;
  equPaul{1}.permutsEqu=permutsEqu;

  equPaul{2}.equ=[X*si+Y*ci-Z];
  equPaul{2}.vars=Ai;
  equPaul{2}.varsJac=[ci,si];
  equPaul{2}.chgtVar=chgtVarAi;
  equPaul{2}.permutsEqu=noPermut;

  equPaul{3}.equ=[X1*si+Y1*ci-Z1;X2*si+Y2*ci-Z2];
  equPaul{3}.vars=Ai;
  equPaul{3}.varsJac=[ci,si];
  equPaul{3}.chgtVar=chgtVarAi;
  equPaul{3}.permutsEqu=permutsEqu;
  equPaul{4}.equ=[X1*Rj*si-Y1;X2*Rj*ci-Y2];
  equPaul{4}.vars=[Rj,Ai];
  equPaul{4}.varsJac=[{Rj,ci},{Rj,si}];
  equPaul{4}.chgtVar=chgtVarRjAi;
  equPaul{4}.permutsEqu=permutsEqu;

  equPaul{5}.equ=[X1*si-Y1-Z1*Rj;X2*ci-Y2-Z2*Rj];
  equPaul{5}.vars=[Rj,Ai];
  equPaul{5}.varsJac=[ci,si,Rj];
  equPaul{5}.chgtVar=chgtVarRjAi;
  equPaul{5}.permutsEqu=permutsEqu;

  equPaul{6}.equ=[W*sk-X*ci-Y*si-Z1;W*ck-X*si+Y*ci-Z2];
  equPaul{6}.vars=[Ak,Ai];
  equPaul{6}.varsJac=[ci,si,ck,sk];
  equPaul{6}.chgtVar=chgtVarAkAi;
  equPaul{6}.permutsEqu=permutsEqu;

  equPaul{7}.equ=[W2*sk+W1*ck-X*ci-Y*si-Z1;W2*ck-W1*sk-X*si+Y*ci-Z2];
  equPaul{7}.vars=[Ak,Ai];
  equPaul{7}.varsJac=[ci,si,ck,sk];
  equPaul{7}.chgtVar=chgtVarAkAi;
  equPaul{7}.permutsEqu=permutsEqu;

  equPaul{8}.equ=[X*ci+Y*ck-Z1;X*si+Y*sk-Z2];
  equPaul{8}.vars=[Ak,Ai];
  equPaul{8}.varsJac=[ci,si,ck,sk];
  equPaul{8}.chgtVar=chgtVarAkAi;
  equPaul{8}.permutsEqu=permutsEqu;



  nbEquPaul=length(equPaul);
  for i_type=1:nbEquPaul
    descript=equPaul{i_type};
    equ=descript.equ;
    ok=length(equ)==length(equs);
    if (ok)
      varsEqu=descript.vars;
      ok=length(vars)==length(varsEqu);
    end
    if ok
      chgtVar=descript.chgtVar;
      if (i_type==4)
        J=jacobian(equ,[ci,si]);
        J=diff(J,Rj);
      else
        J=jacobian(equ,descript.varsJac);
      end

      [nbEssais,~]=size(chgtVar);
      permuts=descript.permutsEqu;
      nbPermut=length(permuts);
      for i=1:nbEssais

        equs_i=subs(equs,vars(:),varsEqu(:));
        equs_i=subs(equs_i,varsEqu,chgtVar(i,:));
        equs_i=simplify(equs_i);
        equs_i=subs(equs_i,[cos(Ai);sin(Ai);cos(Ak);sin(Ak)],[ci;si;ck;sk]);
        if i_type==4
          Ji=jacobian(equs_i,[ci,si]);
          Ji=diff(Ji,Rj);
        else
          Ji=jacobian(equs_i,descript.varsJac);
        end
        for iPermut=1:nbPermut
          Ji_permut=permuts{iPermut}*Ji;
          err=Ji_permut-J;
          switch(i_type)
          case 0
            styp0=solve(err(:)==err(:)*0,[X],'ReturnConditions',true);

            if (length(styp0)>0)
              ok =verif_zero(err,X,styp0.X);
            end
            if ok
              equ_i_permut=permuts{iPermut}*equs_i;
              X=styp0;
              styp0=struct();styp0.X=X;
              Re=-subs(equ_i_permut(1),[ci,si],[0,0]);
              Im=-subs(equ_i_permut(2),[ci,si],[0,0]);
              ok=~any(has([X;Re;Im],varsEqu(:)));
            end
            if ok

              styp0.Ai=subs(chgtVar(i,1),varsEqu(:),vars(:));
              equation=styp0;
              equation.Re=Re;
              equation.Im=Im;
              equation.typ='type 0:  [X.Cos(Ai) -Re=0;X.sin(Ai)-Im=0]';
              equation.name=fileName;
              name=sprintf('params_type0_%s_.m',fileName);

              matlabFunction(X,Y,Z,'File',name);
              name=sprintf('vars_type0_%s_.m',fileName);
              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1]);
              s=solve({varsEqu(1)==equs_vars(1)},[v1],'ReturnConditions',true);
              var1=s.v1;
              matlabFunction(var1,'File',name);
              return
            end % if
          case 1
            % not yet implemented
          case 2
            styp2=solve(err(:)==err(:)*0,[X,Y],'ReturnConditions',true);
            ok=length(styp2)>0;
            if ok
              ok=length(styp2.X)>0;
            end
            if ok
               ok =verif_zero(err,[X,Y],[styp2.X,styp2.Y]);
            end
            if ok
              equ_i_permut=permuts{iPermut}*equs_i;
              X=styp2.X;
              Y=styp2.Y;
              Z=-subs(equ_i_permut(1),[ci,si,ck,sk],[0,0,0,0]);
              ok=~any(has([X;Y;Z],varsEqu(:)));
            end
            if ok
              
              styp2.Z=Z;
              styp2.Ai=subs(chgtVar(i,1),varsEqu(:),vars(:));
              equation=styp2;
              equation.type='equation de Paul de type 2';
              name=sprintf('params_type2_%s_.m',fileName);
              matlabFunction(X,Y,Z,'File',name);
              name=sprintf('vars_type2_%s_.m',fileName);
              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1]);
              s=solve({varsEqu(1)==equs_vars(1)},[v1],'ReturnConditions',true);
              var1=s.v1;
              matlabFunction(var1,'File',name);
              return
            end % if
          case 3
            styp3=solve(err(:)==err(:)*0,[X1,Y1,X2,Y2],'ReturnConditions',true);
            ok=length(styp3)>0;
            if ok
              ok=length(styp3.X1)>0;
            end
            if ok
               ok =verif_zero(err,[X1,Y1,X2,Y2],[styp3.X1,styp3.Y1,styp3.X2,styp3.Y2]);
            end
            if ok
              equ_i_permut=permutsEqu{iPermut}*equs_i;
              X1=styp3.X1;
              Y1=styp3.Y1;
              X2=styp3.X2;
              Y2=styp3.Y2;
              Z1=-subs(equ_i_permut(1),[ci,si,ck,sk],[0,0,0,0]);
              Z2=-subs(equ_i_permut(2),[ci,si,ck,sk],[0,0,0,0]);
              styp3.Z1=Z1;
              styp3.Z2=Z2;
              ok=~any(has([X1;Y1;X2;Y2;Z1;Z2],varsEqu(:)));
            end
            if ok
              
              styp3.Ai=subs(chgtVar(i,1),varsEqu(:),vars(:));
              equation=styp3;
              equation.type='equation de Paul de type 3';
              name=sprintf('params_type3_%s_.m',fileName);
              matlabFunction(X1,Y1,Z1,X2,Y2,Z2,'File',name);
              
              name=sprintf('vars_type3_%s_.m',fileName);
              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1]);
              s=solve({varsEqu(1)==equs_vars(1)},[v1],'ReturnConditions',true);
              var1=s.v1;
              matlabFunction(var1,'File',name);
              return
            end % if
          case 4
            styp4=solve(err(:)==err(:)*0,[X1;X2],'ReturnConditions',true);
            ok=length(styp4)>0;
            if ok
              ok=length(styp4.X1)>0;
            end
            if ok
               ok =verif_zero(err,[X1,X2],[styp4.X1,styp4.X2]);
            end
            ok4=ok;
            if ok4
              ok4=(styp4.X1~=0)&(styp4.X2~=0);
            end
            if (ok4)
              equ_i_permut=permutsEqu{iPermut}*equs_i;
              X1=styp4.X1;
              X2=styp4.X2
              Y1=-subs(equ_i_permut(1),[ci,si,ck,sk,Rj],[0,0,0,0,0]);
              Y2=-subs(equ_i_permut(2),[ci,si,ck,sk,Rj],[0,0,0,0,0]);
              ok4=~any(has([X1;Y1;X2;Y2],varsEqu(:)));
            end
            if ok4
              
              styp4.Y1=Y1;
              styp4.Y2=Y2;
              styp4.Rj=subs(chgtVar(i,1),varsEqu(:),vars(:));
              styp4.Ai=subs(chgtVar(i,2),varsEqu(:),vars(:));
              equation=styp4;
              equation.type='equation de Paul de type 4';
              name=sprintf('params_type4_%s_.m',fileName);
              matlabFunction(X1,Y1,X2,Y2,'File',name);
              name=sprintf('vars_type4_%s_.m',fileName);
              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1;v2]);
              s=solve({varsEqu(1)==equs_vars(1),varsEqu(2)==equs_vars(2)},[v1,v2],'ReturnConditions',true);
              var1=s.v1;var2=s.v2;
              matlabFunction(var1,var2,'File',name);
              return
            end % if

          case 5
            styp5=solve(err(:)==err(:)*0,[X1,Z1,X2,Z2],'ReturnConditions',true);
            ok=length(styp5)>0;
            if ok
              ok=length(styp5.X1)>0;
            end
            if ok            
               ok=~any(has([styp5.X1;styp5.Z1;styp5.X2;styp5.Z2],varsEqu(:))); % must not depend on vars equs
            end
            if ok
               ok =verif_zero(err,[X1,Z1,X2,Z2],[styp5.X1,styp5.Z1,styp5.X2,styp5.Z2]);
            end
            ok5=ok;

            if (ok5)
              equ_i_permut=permutsEqu{iPermut}*equs_i;
              X1=styp5.X1;
              X2=styp5.X2;
              Z1=styp5.Z1;
              Z2=styp5.Z2;
              Y1=-subs(equ_i_permut(1),[ci,si,ck,sk,Rj],[0,0,0,0,0]);
              Y2=-subs(equ_i_permut(2),[ci,si,ck,sk,Rj],[0,0,0,0,0]);
              styp5.Y1=Y1;
              styp5.Y2=Y2;
              styp5.Rj=subs(chgtVar(i,1),varsEqu(:),vars(:));
              styp5.Ai=subs(chgtVar(i,2),varsEqu(:),vars(:));
              equation=styp5;
              equation.type='equation de Paul de type 5';
              name=sprintf('params_type5_%s_.m',fileName);
              matlabFunction(X1,Y1,X2,Y2,Z1,Z2,'File',name);
              name=sprintf('vars_type5_%s_.m',fileName);
              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1;v2]);
              s=solve({varsEqu(1)==equs_vars(1),varsEqu(2)==equs_vars(2)},[v1,v2],'ReturnConditions',true);
              var1=s.v1;var2=s.v2;
              matlabFunction(var1,var2,'File',name);
              return
            end % if

          case 6
            styp6=solve(err(:)==err(:)*0,[W,X,Y],'ReturnConditions',true); % PB with octave, return a solution with err not equal 0
            ok=length(styp6)>0;
            if ok
              ok=length(styp6.W)>0;
            end
            if ok            
               ok=~any(has([styp6.W;styp6.X;styp6.Y],varsEqu(:))); % must not depend on vars equs
            end
            
            if ok
               ok =verif_zero(err,[W,X,Y],[styp6.W,styp6.X,styp6.Y]);
            end
            if ok
              equ_i_permut=permutsEqu{iPermut}*equs_i;
              W=styp6.W;
              X=styp6.X;
              Y=styp6.Y;
              Z1=-subs(equ_i_permut(1),[ci,si,ck,sk],[0,0,0,0]);
              Z2=-subs(equ_i_permut(2),[ci,si,ck,sk],[0,0,0,0]);
            end
            if ok            
               ok=~any(has([W;X;Y;Z1;Z2],varsEqu(:)));
            end
            if ok
              styp6.Ak=subs(chgtVar(i,1),varsEqu(:),vars(:));
              styp6.Ai=subs(chgtVar(i,2),varsEqu(:),vars(:));
              equation=styp6;
              equation.type='equation de Paul de type 6';
              name=sprintf('params_type6_%s_.m',fileName);
              matlabFunction(W,X,Y,Z1,Z2,'File',name);
              name=sprintf('vars_type6_%s_.m',fileName);
              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1;v2]);
              s=solve({varsEqu(1)==equs_vars(1),varsEqu(2)==equs_vars(2)},[v1,v2],'ReturnConditions',true);
              var1=s.v1;var2=s.v2;
              matlabFunction(var1,var2,'File',name);
              return
            end % if
          case 7
            styp7=solve(err(:)==err(:)*0,[W1,W2,X,Y],'ReturnConditions',true);
            ok=length(styp7)>0;
            if ok
              ok=length(styp7.W1)>0;
            end
            if ok            
               ok=~any(has([styp7.W1;styp7.W2;styp7.X;styp7.Y],varsEqu(:))); % must not depend on vars equs
            end
            if ok
               ok =verif_zero(err,[W1,W2,X,Y],[styp7.W1,styp7.W2,styp7.X,styp7.Y]);
            end
            if ok
              equ_i_permut=permutsEqu{iPermut}*equs_i;
              styp7.Z1=-subs(equ_i_permut(1),[ci,si,ck,sk],[0,0,0,0]);
              styp7.Z2=-subs(equ_i_permut(2),[ci,si,ck,sk],[0,0,0,0]);
            end
            if ok            
               ok=~any(has([styp7.W1,styp7.W2,styp7.X,styp7.Y,styp7.Z1,styp7.Z2],varsEqu(:)));
            end
            if ok              
              styp7.type='equation de type 7';
              styp7.Ak=subs(chgtVar(i,1),varsEqu(:),vars(:));
              styp7.Ai=subs(chgtVar(i,2),varsEqu(:),vars(:));
            end
            if ok
              name=sprintf('params_type7_%s_.m',fileName);
              W1=styp7.W1;
              W2=styp7.W2;X=styp7.X;Y=styp7.Y,Z1=styp7.Z1;Z2=styp7.Z2;
              
              matlabFunction(W1,W2,X,Y,Z1,Z2,'File',name);
              % fonction generant les variables depuis les resultats
              name=sprintf('vars_type7_%s_.m',fileName);
              % calcul des variables = f(resultats de solve)

              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1;v2]);
              s=solve({varsEqu(1)==equs_vars(1),varsEqu(2)==equs_vars(2)},[v1,v2],'ReturnConditions',true);
              var1=s.v1;var2=s.v2;
              matlabFunction(var1,var2,'File',name);

              equation=styp7;
              return
            end % if
          case 8
            styp8=solve(err(:)==err(:)*0,[X,Y],'ReturnConditions',true);
            ok=length(styp8)>0;
            if ok
              ok=length(styp8.X)>0;
            end
            if ok            
               ok=~any(has([styp8.X,styp8.Y],varsEqu(:)));
            end
            if ok
               ok =verif_zero(err,[X,Y],[styp8.X,styp8.Y]);
            end
            if ok
              equ_i_permut=permutsEqu{iPermut}*equs_i;
              styp8.Z1=-subs(equ_i_permut(1),[ci,si,ck,sk],[0,0,0,0]);
              styp8.Z2=-subs(equ_i_permut(2),[ci,si,ck,sk],[0,0,0,0]);
            end
            if ok            
               ok=~any(has([styp8.X,styp8.Y,styp8.Z1,styp8.Z2],varsEqu(:)));
            end
            if ok
              styp8.type='equation de type 8';
              styp8.Ak=subs(chgtVar(i,1),varsEqu(:),vars(:));
              styp8.Ai=subs(chgtVar(i,2),varsEqu(:),vars(:));

              name=sprintf('params_type8_%s_.m',fileName);
              X=styp8.X;Y=styp8.Y,Z1=styp8.Z1;Z2=styp8.Z2;
              matlabFunction(W1,W2,X,Y,Z1,Z2,'File',name);
              % fonction generant les variables depuis les resultats
              name=sprintf('vars_type8_%s_.m',fileName);
              % calcul des variables = f(resultats de solve)

              equs_vars=subs(chgtVar(i,:),varsEqu(:),[v1;v2]);
              s=solve({varsEqu(1)==equs_vars(1),varsEqu(2)==equs_vars(2)},[v1,v2],'ReturnConditions',true);
              var1=s.v1;var2=s.v2;
              matlabFunction(var1,var2,'File',name);

              equation=styp8;
              return
            end % if
          end %switch
        end  % for iPermut
      end % for i=1:nbEssais
    end % if (ok)
  end % for i_type
  equation=[]; % no solution
end

