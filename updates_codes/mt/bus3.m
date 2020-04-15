function[v3,PG3,D1]=bus3(v1,v2,v3,v4,B,PL3)
PG3max= 0.222222;
% PG1max= 0.333333;
% PG1last = 0.3;
% PG2last = 0.3;
PG3last=0.2;
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
    B(:,i+1)= B(:,i)+ 0.5*(v3(:,i)-v2(:,i))+0.5*(v3(:,i)-v4(:,i)); 
    fun3 = @(z)(((0.00194*z(1)^2)+ 7.85*z(1)+10*((z(1)-PG3last)^2)+(2e10/2)*((1)*((z(2)-v3(2,i))^2+(z(3)-v3(3,i))^2+(z(4)-v3(4,i))^2)+0.5*z(2)*(v3(2,i)-v1(2,i))+0.5*z(3)*(v3(3,i)-v1(3,i))+0.5*z(4)*(v3(4,i)-v2(4,i))+0.5*((z(4)*(v3(4,i)-v4(4,i))))+0.5*z(3)*((v3(3,i)-v4(3,i)))+0.5*z(2)*((v3(2,i)-v4(2,i)))+B(2,i+1)*z(2)+B(3,i+1)*z(3)+B(4,i+1)*z(4))));
 A = [];
b = [];
Aeq = [1, 0   ,0    ,  0,0,  -1,0,0;
       0,G(3,2),G(3,3),G(3,4),-1,0,0,0;
       0,    -1, 1,    0,    0,0,1*(1/G(3,2)),0;
       0,    0,1,     -1,    0,0,0,1*(1/G(3,4));
       % 0,1,0,0,0,0,0,0;
   % 0,1,0,0,0,0,0,0;
     ];
beq = [PL3;0;0;0];
lb= [0,0.9,0.9,0.9,(-3*Iijmax),-1,(-1*Iijmax),(-1*Iijmax)];
ub= [PG3max,1.1,1.1,1.1,(3*Iijmax),1,(1*Iijmax),(1*Iijmax)];
nonlcon = @cofun3;
z0 = [PG3last,1,1,1,0,0,0,0];
options = optimoptions(@fmincon,'Algorithm','sqp');
[z,exitflag] = fmincon(fun3,z0,A,b,Aeq,beq,lb,ub,nonlcon,options)
z
exitflag
v3(2,i+1)=z(2);
v3(3,i+1)=z(3);           
v3(4,i+1)=z(4);
PG3=z(1);
D1=B(:,i+1);

% [v1,PG1]=bus1(v2,v3,v4);
% [v2,PG2]=bus2(v1,v3,v4);
% [v4,PG4]=bus4(v1,v2,v3);   
end
