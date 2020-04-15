function[PD,Pstor,Pphev]=battery_s(Pload,Pres,Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c)

    fun1 = @(x)(x(1)-x(2)+Pres-Pload+1*(x(3)-c*(Pstormax))^1+1*(x(4)-Celphev));
A = [];
b = [];
Aeq = [-1,0 ,1 , 0;
       0,-1,0,+1;];
beq = [Estorinit;Ephevinit;];
lb= [-Pstormax, 0, 0.25*(Pstormax),Celphev];
ub= [Pstormax,   Pphevmax,Pstormax,Pphevmax];
nonlcon = [];
x0 = [0,0,0,0];
options = optimoptions(@fmincon,'Algorithm','interior-point ');
[x,exitflag] = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x
exitflag
PD= x(1)+x(2)-Pres+Pload;
Pstor= x(3);
Pphev=x(4);
% v1(1,i+1)=x(2);
% v1(2,i+1)=x(3);           
% v1(4,i+1)=x(4);


% [v2(i),PG2]=bus2(v1,v3,v4);
% [v3,PG3]=bus3(v1,v2,v4);
% [v4,PG3]=bus4(v1,v2,v3);
end

