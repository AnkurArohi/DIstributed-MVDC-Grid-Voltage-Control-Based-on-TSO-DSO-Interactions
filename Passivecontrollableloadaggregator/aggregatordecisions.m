Celphev=0.048;
Ephevinit = 10/1000;
Estorinit=0.01;
Pphevmax=0.1;
Pstormax= 0.1;
Ploadinit=0.7;
Ploadmax=1.0;
Pnodemax=1.0;
control_flex= 0.1;
%intendedamount 
c = 0.04;
PphevcurrentSOC= 0.07;
Pphevflex=Pphevmax-PphevcurrentSOC;
P=-0.04 ;% positive if we want to augment the load and negative if we want to shed the load
%The constraint for this program is that the power shifted has to be the
%same or switching off loads must be higher or equal than the switching on loads
%amount in some specified period of time(24H)
% Here c has the same value to make sure that the controllable load is shifted with the same amount as is augmented later in a 24h period.
[Ploadshed,Ploadadd,rlshed,rladd,Pphevadd]=battery_soc(P,control_flex,Pphevflex)
% for i= 1:20
%     Pload(i,1)= i*(0.050)-0;
%     Pres(i,1)=0.6*Pnodemax;
%     
% end
% figure(1)
% plot(1:20,Pload)
% hold on
% plot(1:20,PD)
% hold on
% plot(1:20,Pphev)
% hold on
% plot(1:20,Pstor)
% hold on
% plot(1:20,Pres)
% legend('TOTAL LOAD','NET OPTIMIZED LOAD','Pphev','Pstor','Pres')
%     figure(2)
%     plot(PD(i,1),Pstor(i,1))
%     figure(3)
%     plot(Pstor(i,1),Pphev(i,1))
%     figure(4)
%     plot(Pstor(i,1),Pstormax)
%     figure(5)
%     plot(Pphev(i,1),Pphevmax)

