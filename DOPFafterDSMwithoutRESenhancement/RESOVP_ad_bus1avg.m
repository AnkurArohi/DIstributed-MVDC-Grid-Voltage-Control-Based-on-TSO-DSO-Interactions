function[v1,PG1,B1,I12,RESOVP1]=RESOVP_ad_bus1avg(v1,v2,v3 ,v4,B,i21,PRESOVP1)
PG1max= 0.333333;
PG1last = 0.3;
% PG2last = 0.3;
% PG3last=0.1;
% PG4last=0.04;
Iijmax= 0.8;
% v1(4,4)= zeros;
% v2(4,4)= zeros; 
% v3(4,4)= zeros; 
% v4(4,4)= zeros; 
% B(4,1)=zeros;
G = [18,-18,0,0;
     -18,31,0,-13;
     0,0,22,-22;
     0,-13,-22,35;];
for i = 1:1
    B(:,i+1)= (B(:,i)+1*(v1(:,i)-v2(:,i))); 
    fun1 = @(x)(((2)*((1/1)*((x(2)-v1(1,i))^2+(x(3)-v1(2,i))^2))+1*x(2)*(v1(1,i)-(v2(1,i)))+1*x(3)*(v1(2,i)-(v2(2,i))))+B(1,i+1)*x(2)+B(2,i+1)*x(3));
A = [];
b = [];
Aeq = [1, 0   ,0    ,  0,  -1,0,1;
       0,G(1,1),G(1,2),-1,0,0,0;
       0,1,    -1, 0,0,1*(1/G(1,2)),0;
     ];
beq = [0;0;0];
lb= [0,0.92,0.92,(-3*Iijmax),-1,(-1*Iijmax),0-0.05];
ub= [0,1.1,1.1,(3*Iijmax),1,(1*Iijmax),PRESOVP1+0.05 ];
nonlcon = @cofun1;
x0 = [0,1.1,1.1,1,0,0,0];
options = optimoptions(@fmincon,'Algorithm','sqp ');
[x,exitflag] = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x
exitflag
v1(1,i+1)=x(2);
v1(2,i+1)=x(3);           
%v1(4,i+1)=x(4);
PG1= x(1);
B1=B(:,i+1);
I12(1,i+1) = x(6);
RESOVP1= x(7);


% [v2(i),PG2]=bus2(v1,v3,v4);
% [v3,PG3]=bus3(v1,v2,v4);
% [v4,PG3]=bus4(v1,v2,v3);
end
 end
