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
nAgents = 81;
nTimeSteps = 10^4;
defaultDeltaTime = 0.01;    % Author's suggestion: 0.01 [s]
timeStepMultiplier = 0.95;  % Author's suggestion: 0.95 [s]
minimumDeltaTime = 10^(-5); 
velocityChangeLimit = 0.05; % Author's suggestion: 0.01 [s]

% Room properties
roomSize = [20 20]; % Author's suggestion: [15 15] [m]
doorWidth = 1;      % Author's suggestion: 1 [m]
openingLength = 5;

% Agent properties
meanMass = 80;    % Author's suggestion: 80 [kg]
meanRadius = 0.3; % Author's suggestion: 0.25-0.35 [m]
initialVelocity = zeros(nAgents,2);
initialDesiredSpeed = 1*ones(nAgents,1);
maxDesiredSpeed = 5;
desiredTimeResolution = 1*ones(nAgents,1);
% Physics settings
maxVelocity = 1;
bodyForceCoeff = 1.2*10^5;      % Author's suggestion: 1.2*10^5 [kg s^(-2)]
frictionForceCoeff = 2.4*10^5;  % Author's suggestion: 2.4*10^5 [kg m^(-1) s^(-1)]

% Social settings
ratioBondsPerAgent = 0.1;
socialCorrelations = zeros(nAgents,nAgents);

% Graphics settings
