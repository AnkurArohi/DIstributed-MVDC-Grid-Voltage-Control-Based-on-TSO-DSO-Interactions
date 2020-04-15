function [c,ceq] = cofun4(q)

% Nonlinear inequality constraints
c = [];

% Nonlinear equality constraints

ceq(1) = q(7)- q(3)*q(6);
%ceq(2)= x(1)- (x(7)+(x(2)*(Iload1+Ivpp1)));
%ceq(3)= x(6)-x(8)-Iload1-Ivpp1;
%ceq(2)= y(8)*y(3)-y(7);
% lb= [0;0.9;0.9;0.9;0.9;0;(-1*Pinjmax),(-1*Iinjmax)];
% ub= [PGmax;1.1;1.1;1.1;1.1;IG1max;(1*Pinjmax),(1*Iinjmax)];
% Aeq = [1,-1*(Iload1+Ivpp1),0,0,0,0,0,-1,0;
%        0,0,0,0,0,1,0,(-1)];
% beq = [0;Iload1+Ivpp1];
end
