function[Ploadshed,Ploadadd,rlshed,rladd,Pphevadd]=battery_soc(P,control_flex,Pphevflex)

    fun1 = @(x)(10000*(P-x(3)*(x(1)+x(5))-x(2)*x(4))^2+10000*(x(1)+x(5)-P)^2+1*(x(2)-P)^2)
A = [];
b = [];
Aeq = [ 0,0,+1,1,0;
    ];
beq = [1];
lb= [0,   -1*(control_flex),0,0,0];
ub= [control_flex+Pphevflex,0,       1,1,Pphevflex];
nonlcon = @cofun;
x0 = [0,0,0,0,0];
options = optimoptions(@fmincon,'Algorithm','interior-point','MaxFunEvals',600000,'MaxIter',1000000);
[x,exitflag] = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x
exitflag

Ploadadd=x(1);
Ploadshed=x(2);
rladd=x(3);
rlshed=x(4);
Pphevadd=x(5);
% v1(1,i+1)=x(2);
% v1(2,i+1)=x(3);           
% v1(4,i+1)=x(4);


% [v2(i),PG2]=bus2(v1,v3,v4);
% [v3,PG3]=bus3(v1,v2,v4);
% [v4,PG3]=bus4(v1,v2,v3);
end

