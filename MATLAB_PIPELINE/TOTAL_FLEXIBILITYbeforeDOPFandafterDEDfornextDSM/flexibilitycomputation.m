%status
%passive controllable loads (pos for augnmenting,neg for shedding)
totalcontrollableloadsflexpos = 0.03/4;
totalcontrollableloadsflexneg = -0.03/4;
controllableloadsflexpos = totalcontrollableloadsflexpos- CLpreviousflexusedpos;
controllableloadsflexneg = totalcontrollableloadsflexneg- CLpreviousflexusedneg;
Phevflex = Pphev-Celphev;%it can only supply
%active controllable loads
Fuelcellub=500;
Pphevv2gflexub = Pphevv2gmax-Pphevv2g;
%storage
Pstormax=0.1;
if Pstor>0.8*Pstormax
    Pstorageub = 0.8*Pstormax;
    Pstoragelb=0.2*Pstormax;
else
    Pstorageub = Pstor;
    Pstoragelb=0.2*Pstormax;
end 
%%Add here the 24H constraint for the controllable load flexibility.
%%This would run only after 24/2 hours to let the TSo choice affect by itself
if abs(CLprevioususedneg) > 0.2*Pstormax
    PstorageubfornextDSM =  Pstorageub-(0.2*Pstormax-abs(CLprevioususedneg));
else
    PstorageubfornextDSM= Pstorageub;
end 
if CLprevioususedpos> 0.2*Pstormax
    PstoragelbfornextDSM = CLprevioususedpos-Phevflex;
else
    PstoragelbfornextDSM = Pstoragelb;
end 
