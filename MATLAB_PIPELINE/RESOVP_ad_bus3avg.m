function[v3,PG3,D1,I34,RESOVP3]=RESOVP_ad_bus3avg(v1,v2,v3,v4,B,i43,PRESOVP3)
PG3max= 0.222222;

PG3last=0.2;

Iijmax= 0.8;

G = [18,-18,0,0;
     -18,31,0,-13;
     0,0,22,-22;
     0,-13,-22,35;];
for i = 1:1
    B(:,i+1)= (B(:,i)+ 1*(v3(:,i)-v4(:,i))); 
    fun3 = @(z)((2)*((1)*((z(3)-v3(3,i))^2+(z(4)-v3(4,i))^2))+1*z(2)*(v3(3,i)-(v4(3,i)))+1*z(3)*(v3(4,i)-(v4(4,i)))+B(3,i+1)*z(2)+B(4,i+1)*z(3));
 A = [];
b = [];
Aeq = [1, 0   ,0 ,0,  -1,0,1;
       0,G(3,3),G(3,4),-1,0,0,0;
       0,  1, -1, 0, 0,1*(1/G(3,4)),0;
       
       % 0,1,0,0,0,0,0,0;
   % 0,1,0,0,0,0,0,0;
     ];
beq = [0;0;0];
lb= [0,0.92,0.92,(-3*Iijmax),-1,(-1*Iijmax),0-0.05];
ub= [0,1.1,1.1,(3*Iijmax),1,(1*Iijmax),PRESOVP3+0.05];
nonlcon = @cofun3;
z0 = [0,1,1,0,0,0,0];
options = optimoptions(@fmincon,'Algorithm','sqp');
[z,exitflag] = fmincon(fun3,z0,A,b,Aeq,beq,lb,ub,nonlcon,options)
z
exitflag
%v3(2,i+1)=z(2);
v3(3,i+1)=z(2);           
v3(4,i+1)=z(3);
PG3=z(1);
D1=B(:,i+1);
%I32(1,i+1) = z(7);
I34(1,i+1)= z(6);
RESOVP3 = z(7)
% [v1,PG1]=bus1(v2,v3,v4);
% [v2,PG2]=bus2(v1,v3,v4);
% [v4,PG4]=bus4(v1,v2,v3);   
end
