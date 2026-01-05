function ok =verif_zero(err,vars,vars_sol)
    if exist('OCTAVE_VERSION')==0
      % always True for matlab solver
      ok=1;
      return;
    end
    err=err(:);
    err=subs(err,vars,vars_sol);
    ok=0;
    try
      err_num=double(err);
    catch
      return;
    end
    ok=max(abs(err_num))==0;
  end
