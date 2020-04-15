function [lb,ub] = gen_param(n,d,P_lower,P_upper)
lb =   (P_lower - n)/d;
ub= (P_upper - n)/d;
end