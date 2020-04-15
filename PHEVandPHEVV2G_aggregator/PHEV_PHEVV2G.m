%here we find the PHEV and PHEVV2G power requirements and assume that the
%aggregator uses the current state of its entities to determine the same.

% IT is also assumed that given the rescheduling setpoints and the voltage of the DSO bus, the PHEV agg is responsibe to maintain the technical limits and provide the DSO with the requested power values

deltconnect = 15/60; %15mins
P_largevehicle = 60000/(deltconnect*5e6);
PHEV_max=0.1;
P_mediumvehicle = 24000/(deltconnect*5e6);
P_smallvehicle = 18800/(deltconnect*5e6);

%%PHEVV2G
deltconnect = 15/60; %15mins
P_largevehicle2g = 60000/(deltconnect*5e6);
PHEV_max2g=0.08;
P_mediumvehicle2g = 24000/(deltconnect*5e6);
P_smallvehicle2g = 18800/(deltconnect*5e6);