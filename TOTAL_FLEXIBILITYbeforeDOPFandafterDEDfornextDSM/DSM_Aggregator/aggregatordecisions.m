Celphev=0.048;% This can be requested and received form the PHEV aggregator,assuming tconnect-tdisconnect = 15/60 hours
Ephevinit = 10/1000;
Estorinit=0.01;
Pphevmax=0.1;
Pstormax= 0.1;
Ploadinit=0.8;%This has to be decided cautiously otherwise infeasible solutions are reached and can be changed depending on RES generation.
Ploadmax=1.0;
Pnodemax=1.0;
for i= 1:96
    Pload(i,1)= i*(0.01)-0;
    Pres(i,1)=0.4*Pnodemax;
    
    %Pload= 1100;
    %Pres=100;
    
    % Pl(i,1) = Pload(i,1)-Pres(i,1);
    %     if Pl(i,1) < 0
    %         disp('Overproduction case')
    %         if abs(Pl(i,1))<= 650
    %             c = 1.0;
    %             d=1.0;
    %         else abs(Pl(i,1))> 650
    %             PD(i,1) = -1*(abs(Pl(i,1))-650);
    %
    %         end
    %     [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc_OVP(Pl(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,d,Pnodemax)
    C=(Pres(i,1)-Pload(i,1));
    if C>0
    if     (Pres(i,1)-Pload(i,1))<0.650 
        c=1.0;
        d=1.0;
        [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc_OVP( (Pres(i,1)-Pload(i,1)),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,d)
    else  
        PD(i,1)=-1*((Pres(i,1)-Pload(i,1))-(Pstormax-Estorinit)-(Pphevmax-Ephevinit));
        Pstor(i,1)=Pstormax;
        Pphev(i,1)=Pphevmax;
    end
    
    elseif Pres(i,1)>Pnodemax && Pload(i,1)<0.8*Ploadmax
        c= 1.0; d= 1.0;
         [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
    elseif 0.8*Pnodemax<Pres(i,1)   && Pres(i,1)<Pnodemax && Pload(i,1)<0.8*Ploadmax
        c= 0.7; d= 0.7;
    elseif Pres(i,1)>Pnodemax && Pload(i,1)>0.8*Ploadmax
        c= 0.5;d=0.5;
    [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
    elseif Pload(i,1)<0.4*Ploadmax
        c = 1.0;
        d = 0.9;
         [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
    elseif Pres(i,1)>1.2*Pnodemax && Pload(i,1) < 0.8*Ploadmax
        c=1.0;
        d=1.0;
         [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
    elseif Pres(i,1)>0.6*Pnodemax && Pres(i,1)<0.8*Pnodemax && Pload(i,1)<0.6*Ploadmax
        c= 0.8; d=0.7;
         [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
    elseif Pload(i,1)< 0.5*Ploadmax   
        c= 0.8;
        d=0.8;
         [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
    else
        c=0.4;d=0.4;
        [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
        
    end
    
  % [PD(i,1),Pstor(i,1),Pphev(i,1)]=battery_soc(Pload(i,1),Pres(i,1),Celphev,Ephevinit,Estorinit,Pphevmax,Pstormax,c,Ploadinit,d)
end 
    figure(1)
    plot(1:96,Pload)
hold on
plot(1:96,PD)
hold on
plot(1:96,Pphev)
hold on
plot(1:96,Pstor)
hold on
plot(1:96,Pres)
legend('TOTAL LOAD','NET OPTIMIZED LOAD','Pphev','Pstor','Pres')
%     figure(2)
%     plot(PD(i,1),Pstor(i,1))
%     figure(3)
%     plot(Pstor(i,1),Pphev(i,1))
%     figure(4)
%     plot(Pstor(i,1),Pstormax)
%     figure(5)
%     plot(Pphev(i,1),Pphevmax)

