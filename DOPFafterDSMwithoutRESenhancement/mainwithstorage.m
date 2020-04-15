
function [Pstorage_1,Pstorage_2,Pstorage_3,Pstorage_4]= mainwithstorage(v1,v2,v3,v4,I12,I14,I21,I23,I24,I32,I34,I41,I42,I43)

I1= [I12;I14];
I2= [I21;I23;I24];
I3=[I32;I34];
I4= [I41;I42;I43];

% can be negative showing that the bus is receiving
%NODE 1
% if the current is positive the node is injecting so first we check this
% condition and set the flag depending on the same.
% if current is negative this means that the voltage determined by the node
% for itself was lesser than the injecter node.
if (I1(1,2) <= 0) && (I2(1,2) >= 0)
    flag12=1;% node is receiving
    P21_1= (v1(2,1)-v1(1,1))*(I1(1,2))
    P21_2= (v2(2,1)-v2(1,1))*(I2(1,2))
    P21inj_1= v1(1,1)*(I1(1,2))
    P21inj_2= v2(2,1)*(I2(1,2))
 
else flag12=0;
        P21inj_1= v1(1,1)*(I1(1,2))
    P21inj_2= v2(2,1)*(I2(1,2))
end 
 P12external= P21inj_1+P21inj_2;
 
if (I1(2,2)<=0 && I4(1,2)>=0)
    flag14=1;% node is receiving
    P41_1= (v1(4,1)-v1(1,1))*(I1(2,2))
    P41_4= (v4(4,1)-v4(1,1))*(I4(1,2))
    P41inj_1= v1(1,1)*(I1(2,2))
    P41inj_4= v4(4,1)*I4(1,2)
else flag14=0;
     P41inj_1= v1(1,1)*(I1(2,2))
    P41inj_4= v4(4,1)*I4(1,2)
end 
P14external= P41inj_1+P41inj_4;

Pstorage_1= P12external+P14external;

%NODE 2_ FREEZING NODE 1
if (I2(2,2) <= 0) && (I3(1,2) >= 0)
    flag23=1;% node is receiving
    P32_2= (v2(3,1)-v2(2,1))*(I2(2,2))
    P32_3= (v3(2,1)-v3(1,1))*(I3(1,2))
    P32inj_2= v2(2,1)*I2(2,2)
    P32inj_3 =v3(2,1)*(I3(1,2))
else flag23=0;
    P32_2= (v2(2,1)-v2(3,1))*(I2(2,2))
    P32_3= (v3(1,1)-v3(2,1))*(I3(1,2))
    P32inj_2= v2(2,1)*I2(2,2)
    P32inj_3 =v3(2,1)*(I3(1,2))
end 

if (I2(3,2)<=0 && I4(2,2)>=0)
    flag24=1;% node is receiving
    P42_2= (v2(2,1)-v2(3,1))*(I2(3,2))
    P42_4= (v3(2,1)-v3(1,1))*(I4(2,2))
    P42inj_2= v2(2,1)*I2(3,2)
    P42inj_4 =v4(4,1)*(I4(2,2))
else flag24=0;
    P42_2= (v2(2,1)-v2(3,1))*(I2(3,2))
    P42_4= (v3(2,1)-v3(1,1))*(I4(2,2))
    P42inj_2= v2(2,1)*I2(3,2)
    P42inj_4 =v4(4,1)*(I4(2,2))
end 

Pstorage_2= ( P32inj_2+P32inj_3)+(P42inj_2+P42inj_4)

%NODE 3_Freezing node 2 & 1

if (I3(2,2) <= 0) && (I4(3,2) >= 0)
    flag12=1;% node is receiving
    P34_3= (v3(3,1)-v3(2,1))*(I3(2,2))
    P34_4= (v4(4,1)-v4(3,1))*(I4(3,2))
    P34inj_3= v3(2,1)*I3(2,2)
    P34inj_4= v4(4,1)*I4(3,2)
else flag12=0;
    P34_3= (v3(2,1)-v3(3,1))*(I3(2,2))
    P34_4= (v4(3,1)-v4(4,1))*(I4(3,2))
    P34inj_3= v3(2,1)*I3(2,2)
    P34inj_4= v4(4,1)*I4(3,2)
end 

Pstorage_3= (P34inj_3+P34inj_4)
Pstorage_4=(P14external)+((P42inj_2+P42inj_4))+(P34inj_3+P34inj_4)
end


