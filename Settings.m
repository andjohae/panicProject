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
nAgents = 10;
nTimeSteps = 10;
deltaTime=0.1;

% Room properties
roomSize = 10;

% Agent properties
meanMass = 50;
meanRadius = 0.5;

% Physics settings
maxVelocity = 1;

% Graphics settings
