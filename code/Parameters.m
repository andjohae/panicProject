%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Translation structor
PROPERTIES = struct('Position',[1,2],...
  'Velocity',[3,4],...
  'Mass',5,...
  'Radius',6,...
  'DesiredSpeed',7,...
  'DesiredDirection',[8,9],...
  'DesiredTimeResolution',10,...
  'RepulsionCoeff',11,...
  'RepulsionExp',12,...
  'Impatience',13);

% Simulation parameters
nAgents = 48;
nTimeSteps = 10^4;
deltaTime = 0.001;

% Room properties
roomSize=[20 20];
doorWidth=5;
openingLength=5;

% Agent properties
meanMass = 50;
meanRadius = 0.3;
initialVelocity = zeros(nAgents,2);
initialDesiredSpeed = 1*ones(nAgents,1);
maxDesiredSpeed = 5;
desiredTimeResolution = 1*ones(nAgents,1);
% Physics settings
maxVelocity = 1;
bodyForceCoeff = 1.2*10^5;
frictionForceCoeff = 2.4*10^5;

% Social settings
ratioBondsPerAgent = 0.1;
socialCorrelations = zeros(nAgents,nAgents);

% Graphics settings
