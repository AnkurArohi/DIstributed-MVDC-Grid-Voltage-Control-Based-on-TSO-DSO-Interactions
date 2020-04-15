function[PD,Pstor,Pphev]=battery_soc(Pload,Pres,Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadint,d)

    fun1 = @(x)(-x(6)*x(1)-x(7)*x(2)-x(3)+Pres-Pload+1*(x(4)-c*Pstormax)^1+1*(x(5)-d*Pphevmax)^1)+x(9);
A = [];
b = [];
Aeq = [ 0,0,-1,0,+1,0,0,0,0;
    0,0,0,0,0,1,1,0,0;
    0,0,0,1,0,0,0,-1,0;
   0,0,-1,0,0,0,0,-1,1; ];
beq = [Ephevinit;1;Estorinit;Pload-Pres];
lb= [0,   -1*(Pstormax),0, 0.2*(Pstormax),Celphev,0,0,-Pstormax,0.3*Ploadint];
ub= [Pstormax,0,   Pphevmax,Pstormax,Pphevmax,1,1,Pstormax,1.17*Ploadint];
nonlcon = @cofun;
x0 = [0,0,0,0,0,0,0,0,Ploadint];
options = optimoptions(@fmincon,'Algorithm','interior-point','MaxFunEvals',600000,'MaxIter',1000000);
[x,exitflag] = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x
exitflag
PD= x(6)*x(1)+x(7)*x(2)+x(3)-Pres+Pload;
Pstor= x(4);
Pphev=x(5);
x(9)
% v1(1,i+1)=x(2);
% v1(2,i+1)=x(3);           
% v1(4,i+1)=x(4);


% [v2(i),PG2]=bus2(v1,v3,v4);
% [v3,PG3]=bus3(v1,v2,v4);
% [v4,PG3]=bus4(v1,v2,v3);
end

