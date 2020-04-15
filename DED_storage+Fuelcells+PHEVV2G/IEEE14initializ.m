function [x,a,y] = IEEE14initializ(D,P_lower,P_upper,n,d)
if P_upper > 0 
if P_upper < D
    x = P_upper;
elseif P_lower<= D && D<P_upper
     x = D;
elseif D<P_lower 
    x = P_lower;
end
a = (x-n)/d;
y= D-x;
else
    x=0;
   a = 0 ;
    y= D-x;
end