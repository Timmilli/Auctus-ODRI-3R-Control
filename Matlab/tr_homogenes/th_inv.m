function T_inv = th_inv(T)
iRk = T(1:3, 1:3);
iOk = T(1:3, 4);

kRi = iRk';

kOi = -kRi*iOk;

kTi = [kRi, kOi];

T_inv = [kTi; 0 0 0 1];
end