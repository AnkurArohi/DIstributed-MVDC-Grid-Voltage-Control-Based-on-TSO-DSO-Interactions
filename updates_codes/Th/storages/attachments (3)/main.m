v1(4,1)= zeros;
v2(4,1)= zeros;
v3(4,1)= zeros;
v4(4,1)= zeros;
B(4,1)=zeros;
C(4,1)=zeros;
D(4,1)=zeros;
E(4,1)=zeros;
i12(1,1)=zeros;
i14(1,1)=zeros;
i21(1,1)=zeros;
i23(1,1)=zeros;
i24(1,1)=zeros;
i32(1,1)=zeros;
i34(1,1)=zeros;
i41(1,1)=zeros;
i42(1,1)=zeros;
i43(1,1)=zeros;
PL3 = 0.417;
PL1=0.417;
PL2=0.0;
PL4=0.0;
for k= 1:5000
    [V2,PG2,C1,I21,I23,I24]=bus2(v1,v2,v3,v4,C(:,k),PL2,i12,i32,i42);
    P2(1,k)=PG2;
    C(:,k+1)=C1;
    v2= V2(:,2);
    i21=I21(:,2);
    i23=I23(:,2);
    i24=I24(:,2);
    
    [V1,PG1,B1,I12,I14]=bus1(v1,v2,v3 ,v4,B(:,k),PL1,i21,i41);
    P1(1,k)=PG1;
    B(:,k+1)=B1;
    v1= V1(:,2);
    i12= I12(:,2);
    i14= I14(:,2);
    
    [V3,PG3,D1,I32,I34]=bus3(v1,v2,v3 ,v4,D(:,k),PL3,i23,i43);
    P3(1,k)=PG3;
    D(:,k+1)=D1;
     v3= V3(:,2);
      i32= I32(:,2);
    i34= I34(:,2);
    
    [V4,PG4,E1,I41,I42,I43]=bus4(v1,v2,v3,v4,E(:,k),PL4,i14,i24,i34);
    P4(1,k)=PG4;
    E(:,k+1)=E1;
   v4= V4(:,2);
   i41=I41(:,2);
    i42=I42(:,2);
    i43=I43(:,2);
    
   Vo1 = V1;
   V02 =V2;
   V03 =V3;
   V04 =V4;
   PG=PG1+PG2+PG3+PG4;
%          v2= V2(:,k-1);
%     v1= V1(:,k-1);
%     v4= V4(:,k-1);
%     v3= V3(:,k-1);
   
end