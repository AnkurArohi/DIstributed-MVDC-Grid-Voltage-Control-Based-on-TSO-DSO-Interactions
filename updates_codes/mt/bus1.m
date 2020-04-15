 function[v1,PG1,B1]=bus1(v1,v2,v3,v4,B,PL1)
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
G = [36,-18,0,-18;
     -18,44,-13,-13;
     0,-13,35,-22;
     -18,-13,-22,53;];
for i = 1:1
    B(:,i+1)= B(:,i)+ 0.5*(v1(:,i)-v2(:,i))+0.5*(v1(:,i)-v4(:,i)); % only vare about the value of lambda which belongs to the consensus variables so the stopping criteria should be met only when the consensus matrix is multiplied with lambda
    
fun1 = @(x)(((0.00142*x(1)^2)+ 7.2*x(1)+10*((x(1)-PG1last)^2)+(2e10/2)*((1/2)*((x(2)-v1(1,i))^2+(x(3)-v1(2,i))^2+(x(4)-v1(4,i))^2)+0.5*x(2)*(v1(1,i)-v2(1,i))+0.5*x(3)*(v1(2,i)-v2(2,i))+0.5*x(4)*(v1(4,i)-v2(4,i))+0.5*((x(4)*(v1(4,i)-v4(4,i))))+0.5*x(2)*((v1(1,i)-v4(1,i)))+0.5*x(3)*((v1(2,i)-v4(2,i)))+B(1,i+1)*x(2)+B(2,i+1)*x(3)+B(4,i+1)*x(4))));
A = [];
b = [];
Aeq = [1, 0   ,0    ,0   ,  0,  -1,0,0;
       0,G(1,1),G(1,2),G(1,4),-1,0,0,0;
       0,1,    -1,     0,    0,0,1*(1/G(1,2)),0;
       0,1,    0,     -1,    0,0,0,1*(1/G(1,4));
       % 0,1,0,0,0,0,0,0;
   % 0,1,0,0,0,0,0,0;
     ];
beq = [PL1;0;0;0];
lb= [0,0.9,0.9,0.9,(-3*Iijmax),-1,(-1*Iijmax),(-1*Iijmax)];
ub= [PG1max,1.1,1.1,1.1,(3*Iijmax),1,(1*Iijmax),(1*Iijmax)];
nonlcon = @cofun1;
x0 = [PG1last,1,1,1,0,0,0,0];
options = optimoptions(@fmincon,'Algorithm','sqp ');
[x,exitflag] = fmincon(fun1,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
x
exitflag
v1(1,i+1)=x(2);
v1(2,i+1)=x(3);           
v1(4,i+1)=x(4);
PG1= x(1);
B1=B(:,i+1);

% [v2(i),PG2]=bus2(v1,v3,v4);
% [v3,PG3]=bus3(v1,v2,v4);
% [v4,PG3]=bus4(v1,v2,v3);
end
 end
