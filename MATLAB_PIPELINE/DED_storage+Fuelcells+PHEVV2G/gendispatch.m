function [P]= gendispatch(A,n,d,ub,lb,P_lower,P_upper)
if A>ub
    P = P_upper;
elseif A<ub && A>lb
    P = d*A+n;
elseif A<lb
    P = P_lower;
end
end
