function[PD,Pstor,Pphev,Pphevv2g]=battery_soc_OVP(P,Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,d,Pphevv2gmax,Ephevv2ginit,e,Eelphevv2g)

    fun1 = @(x)(-x(1)-x(2)-x(5)+P+1*(x(3)-c*Pstormax)^2+1*(x(4)-d*Pphevmax)^2+(x(6)-e*Pphevv2gmax)^2);
A = [];
b = [];
Aeq = [ 0,-1,0,+1,0,0;
         -1,0,+1,0,0,0;
         0,0,0,0,-1,1];
  
beq = [Ephevinit;
    Estorinit;
    Ephevv2ginit;];
lb= [0,          0,   0.2*(Pstormax),Celphev,0,Eelphevv2g];
ub= [Pstormax,   Pphevmax,Pstormax,Pphevmax,Pphevv2gmax,Pphevv2gmax];
nonlcon = [];
x0 = [0,0,0,0,0,0];
options = optimoptions(@fmincon,'Algorithm','interior-point','MaxFunEvals',600000,'MaxIter',1000000);
[x,exitflag] = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x
exitflag
PD= -1*(P-x(1)-x(2)-x(5));
Pstor= x(3);
Pphev=x(4);
Pphevv2g=x(6);

% v1(1,i+1)=x(2);
% v1(2,i+1)=x(3);           
% v1(4,i+1)=x(4);


% [v2(i),PG2]=bus2(v1,v3,v4);
% [v3,PG3]=bus3(v1,v2,v4);
% [v4,PG3]=bus4(v1,v2,v3);
end



