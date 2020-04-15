v1(4,1)= zeros;
v2(4,1)= zeros;
v3(4,1)= zeros;
v4(4,1)= zeros;
B(4,1)=zeros;
C(4,1)=zeros;
D(4,1)=zeros;
E(4,1)=zeros;

for k= 1:110
    [V2,PG2,C1]=bus2(v1,v2,v3,v4,C(:,k));
    P2(1,k)=PG2;
    C(:,k+1)=C1;
    [V1,PG1,B1]=bus1(v1,v2,v3 ,v4,B(:,k));
    P1(1,k)=PG1;
    B(:,k+1)=B1;
    [V3,PG3,D1]=bus3(v1,v2,v3 ,v4,D(:,k));
    P3(1,k)=PG3;
    D(:,k+1)=D1;
    [V4,PG4,E1]=bus4(v1,v2,v3,v4,E(:,k));
    P4(1,k)=PG4;
    E(:,k+1)=E1;
    
    v2= V2(:,2);
    v1= V1(:,2);
    v4= V4(:,2);
    v3= V3(:,2);
    
   Vo1 = V1;
   V02 =V2;
   V03 =V3;
   V04 =V4;
%          v2= V2(:,k-1);
%     v1= V1(:,k-1);
%     v4= V4(:,k-1);
%     v3= V3(:,k-1);
   
end
