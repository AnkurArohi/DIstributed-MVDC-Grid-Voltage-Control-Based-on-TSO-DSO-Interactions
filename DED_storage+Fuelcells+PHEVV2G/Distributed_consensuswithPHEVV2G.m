A = zeros(4,1);
Y=zeros(4,1);
% A(:,1)= [7.63;7.63;8.24;8.42]; 
D = [350;0;0; 0];

E = 7.026e-4;
P = [0.5 0 0 0.5;
    1/3 1/3 1/3 0;
    0 0 0.5 0.5;
    0 0.5 0 0.5;];
Q = [0.5 0 0 1/3;
    1/2 1/2 1/2 0;
    0 0 0.5 1/3;
    0 0.5 0 1/3;];
P_lower=[0;0;0;0];
P_upper=[250;500;100;0];
n= [-51;-46.8333;-51;-826.8];
d= [833.333;416.6667;833.333;103.7];
for i = 1:4
[X(i,1),A(i,1),Y(i,1)]= IEEE14initializ(D(i,1),P_lower(i,1),P_upper(i,1),n(i,1),d(i,1))

end

% AGENT 1 Storage+PHEVV2G
%X(:,1)= [150; 150 ; 100; 50];
P_lower1= 0;
P_upper1=250;
n1 = -51;
d1 = 833.333;
[lb1,ub1] = gen_param(n1,d1,P_lower1,P_upper1);

% AGENT 2 FUEL CELLS
P_lower2= 0;
P_upper2=500;
n2 = -46.8333;
d2 = 416.6667;
[lb2,ub2] = gen_param(n2,d2,P_lower2,P_upper2);
% AGENT 3  PHEVV2G
P_lower3=  0;
P_upper3=100;
n3 = -51;
d3 =833.333;
[lb3,ub3] = gen_param(n3,d3,P_lower3,P_upper3);

% AGENT 4  
P_lower4= 0;
P_upper4=0;
n4 = -826.8;
d4 = 103.7;
[lb4,ub4] = gen_param(n4,d4,P_lower4,P_upper4);



for i = 2:1000
    A (:,i)= P * A (:,i-1) + E*Y(:,i-1);
    X(1,i)= gendispatch(A(1,i),n1,d1,ub1,lb1,P_lower1,P_upper1);
    X(2,i)= gendispatch(A(2,i),n2,d2,ub2,lb2,P_lower2,P_upper2);
    X(3,i)= gendispatch(A(3,i),n3,d3,ub3,lb3,P_lower3,P_upper3);
    X(4,i)= gendispatch(A(4,i),n4,d4,ub4,lb4,P_lower4,P_upper4);
    Y(:,i)= Q*Y(:,i-1)-(X(:,i)-X(:,i-1));
    X_sum(1,i)= X(1,i)+X(2,i)+X(3,i)+X(4,i);
    D_sum(1,i)= D(1,1)+D(2,1)+D(3,1)+D(4,1);
end

figure(1)
plot(1:1000,A(1,:))
hold on
plot(1:1000,A(2,:))
hold on
plot(1:1000,A(3,:))
hold on
plot(1:1000,A(4,:))
legend('Generator at node 1','Generator at node 2','Generator at node 3','Generator at node 4')
figure(2)
plot(1:1000,X(1,:))
hold on
plot(1:1000,X(2,:))
hold on
plot(1:1000,X(3,:))
hold on
plot(1:1000,X(4,:))
legend('Generator at node 1','Generator at node 2','Generator at node 3','Generator at node 4')
figure(3)
plot(1:1000,D_sum)
hold on
plot(1:1000,X_sum)
legend('Total power demand','Total power generated')



