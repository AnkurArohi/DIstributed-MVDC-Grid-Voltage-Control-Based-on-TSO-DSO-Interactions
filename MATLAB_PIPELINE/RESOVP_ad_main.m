tic
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
 PL1 = 0.0;
 PL3=0.0;
% PG=0.0;
% Pmismatch =(PL1+PL2+PL3+PL4)-1.0;
%while PG<(PL1+PL2+PL3+PL4)

TSO_choice =0.5    
PRESOVP1 = 0.3;
PRESOVP2=0.2 ;
PRESOVP3=0.3 ;
PRESOVP4=0.4 ;
%PL4= (PRESOVP1+0.2+PRESOVP2+0.2+PRESOVP3+0.2+PRESOVP4+0.2)/2;
%PL2= (PRESOVP1+0.2+PRESOVP2+0.2+PRESOVP3+0.2+PRESOVP4+0.2)/2;
PRESTOTAL=(PRESOVP1+0.05+PRESOVP2+0.05+PRESOVP3+0.05+PRESOVP4+0.05);
 %PL2=0.4;
 %PL4=0.5;
k=1;
flag=0;
while flag == 0 && k<500 
    
%for k= 1:5000
    [V2,PG2,C1,I21,I24,pl2,RESOVP2]=RESOVP_ad_bus2avg(v1,v2,v3,v4,B,i12,i42,PRESOVP2,PRESTOTAL,TSO_choice);
    P2(1,k)=PG2;
    C(:,k+1)=C1;
    RES_OVP2(1,k)=RESOVP2;
    %v2= V2(:,2);
    i21=I21(:,2);
    %i23=I23(:,2);
    i24=I24(:,2);
    %ptso2(1,k)=PTSO2;
    [V1,PG1,B1,I12,RESOVP1]=RESOVP_ad_bus1avg(v1,v2,v3 ,v4,B(:,k),i21,PRESOVP1);
    P1(1,k)=PG1;
    RES_OVP1(1,k)=RESOVP1;
    B(:,k+1)=B1;
%     v1= V1(:,2);
    i12= I12(:,2);
    %i14= I14(:,2);
   [V3,PG3,D1,I34,RESOVP3]=RESOVP_ad_bus3avg(v1,v2,v3,v4,B,i43,PRESOVP3);
    P3(1,k)=PG3;
    RES_OVP3(1,k)=RESOVP3;
    D(:,k+1)=D1;
%      v3= V3(:,2);
   %i32= I32(:,2);
    i34= I34(:,2);
    
    [V4,PG4,E1,I42,I43,pl4,RESOVP4]=RESOVP_ad_bus4avg(v1,v2,v3,v4,B,i24,i34,PRESOVP4,PRESTOTAL,TSO_choice);
    P4(1,k)=PG4;
    RES_OVP4(1,k)=RESOVP4;
    E(:,k+1)=E1;
     %ptso4(1,k)=PTSO4;
%      v4= V4(:,2);
   %i41=I41(:,2);
    i42=I42(:,2);
    i43=I43(:,2);
%     
    v2= V2(:,2);
    v1= V1(:,2);
    v4= V4(:,2);
    v3= V3(:,2);
     PL2=pl2(:,1);
     PL4=pl4(:,1);
    
   Vo1 = V1;
   V02 =V2;
   V03 =V3;
   V04 =V4;
%          v2= V2(:,k-1);
%     v1= V1(:,k-1);
%     v4= V4(:,k-1);
%     v3= V3(:,k-1);
delv(1,1)= abs(v1(1,1)-v2(1,1));
   %delv(1,2)= abs(v1(1,1)-v4(1,1));
   delv(2,1)= abs(v2(2,1)-v1(2,1));
   %delv(2,2)= abs(v2(2,1)-v3(2,1));
   delv(2,3)= abs(v2(2,1)-v4(2,1));
   %delv(3,1)=abs(v3(3,1)-v2(3,1));
   delv(3,2)= abs(v3(3,1)-v4(3,1));
   %delv(4,1)=abs(v4(4,1)-v1(4,1));
   delv(4,2)=abs(v4(2,1)-v2(2,1));
   delv(4,3)= abs(v4(3,1)-v3(3,1));
   if max(max(delv))<10^(-5) && (RESOVP1)+(RESOVP2)+(RESOVP3)+(RESOVP4)>=TSO_choice*PRESTOTAL
       flag= 1;
   else 
       flag = 0;
   end
k=k+1;

PRESdispatch=RES_OVP1+RES_OVP2+RES_OVP3+RES_OVP4;

%[Pstorage_1,Pstorage_2,Pstorage_3,Pstorage_4]=mainwithstorage(v1,v2,v3,v4,I12,I14,I21,I23,I24,I32,I34,I41,I42,I43)
%P_STORAGE = [Pstorage_1;Pstorage_2;Pstorage_3;Pstorage_4];
% if max(P_STORAGE)<0 
%     flag = 1;
% else 
%     flag=0;
% end
end

toc
%P_RESOV=[PRESOVP1;PRESOVP2;PRESOVP3;PRESOVP4];
PLAcc =[TSO_choice*PRESTOTAL] ;
for i = 1:k-1
   PLAc(1,i)= TSO_choice*PRESTOTAL;
end

figure(1)
plot(1:k-1,RES_OVP1)
hold on
plot(1:k-1,RES_OVP2)
hold on
plot(1:k-1,RES_OVP3)
hold on
plot(1:k-1,RES_OVP4)
legend('power set points at bus 1','power set points at bus 2','power set points at bus 3','power set points at bus 4')
%bar(P_RESOV);
figure(2)
plot(1:k-1,PLAc)
hold on 
plot(1:k-1,PRESdispatch)
%bar(P_STORAGE);
legend('Power demanded by TSO','Total power dispatched by the DSO')