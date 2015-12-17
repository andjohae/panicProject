%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Panic Project Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
%%%%%%%%%%%%%%%%%%%%% TODO List %%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: UpdatePositions() that checks if new positons are valid and removes
%   agents that have arrived at goal (vertical line at target position)
% - Should also count when agents escape the room
% TODO: Implement social force
% - Modular mathematical formula for social force, ie. allow different
%   functions (exponential, linear, quadratic etc.) of partner distance 
% TODO: Fix agent plot --> scatter() can set individual markersizes!

%%%%%%%%%%%%%%%%%%%%%% Initilize %%%%%%%%%%%%%%%%%%%%%%%%%
%  Read settings
run('Parameters.m');

%  Initialization
targetPosition = [1.1*roomSize(1),0.5*roomSize(2)];
avgSpeedInDesiredDirection=zeros(nAgents,1);
time = 0;

% - Room (Walls)
walls = WallGeneration(roomSize,doorWidth,openingLength);

% - Agents
agents = InitializeAgents(nAgents,PROPERTIES,meanMass,meanRadius,...
  targetPosition,roomSize, initialVelocity, initialDesiredSpeed, ...
  desiredTimeResolution);

% - Social Bonds
socialCorrelations = InitilizeSocialNetwork(nAgents,socialCorrelations,...
ratioBondsPerAgent);

% Initialize simulation graphics
run('SetupSimulationGraphics.m');
% movieStruct = getframe(gcf); % PLAY: movie(figure,movieStruct,5)

%%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%%
for iTime = 1:nTimeSteps
  
  % Update model physics
  % - acceleration
  currentAcceleration = UpdateAcceleration(agents,walls,PROPERTIES,...
      bodyForceCoeff,frictionForceCoeff,socialCorrelations);
  % - variable time step
  deltaTime = CalculateVariableTimeStep(currentAcceleration,defaultDeltaTime,...
      velocityChangeLimit, timeStepMultiplier, minimumDeltaTime);
  time = time + deltaTime;
  % - velocity
  agents(:,PROPERTIES.Velocity) = agents(:,PROPERTIES.Velocity) + ...
      currentAcceleration .* deltaTime;
  % - position
  agents(:,PROPERTIES.Position) = agents(:,PROPERTIES.Position) + ...
      agents(:,PROPERTIES.Velocity).*deltaTime;
 [agents,nAgents,avgSpeedInDesiredDirection,initialDesiredSpeed,socialCorrelations ]...
       = RemoveAgentIfOut( agents,nAgents,PROPERTIES,...
       roomSize,avgSpeedInDesiredDirection,initialDesiredSpeed,socialCorrelations );
  % Accumulate speed in desired direction
  avgSpeedInDesiredDirection = (avgSpeedInDesiredDirection + ...
      sum(agents(:,PROPERTIES.Velocity).*(agents(:,PROPERTIES.DesiredDirection)),2)...
      .* deltaTime)/2;
    
  % Update desired direction
  newDesiredDirection = ones(nAgents,1)*targetPosition - agents(:,PROPERTIES.Position);
  agents(:,PROPERTIES.DesiredDirection) = newDesiredDirection .* ...
      ( (1./sqrt( sum( newDesiredDirection.^2, 2 ) )) * [1,1] );
 
  % Update desired speed
  agents(:,PROPERTIES.DesiredSpeed) = (1-agents(:,PROPERTIES.Impatience)).* ...
      initialDesiredSpeed + (agents(:,PROPERTIES.Impatience) .* maxDesiredSpeed);
    
  % Update impatience
  agents(:,PROPERTIES.Impatience) = 1 - avgSpeedInDesiredDirection ./ ...
      agents(:,PROPERTIES.DesiredSpeed);
  
  % Update graphics
%   hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
  set(hAgentPlot, 'XData', agents(:,PROPERTIES.Position(1)), 'YData', ...
      agents(:,PROPERTIES.Position(2)));
  set(hTimeStamp, 'String', sprintf('Time: %.5f s',time));
  drawnow update;

%   movieStruct(iTime) = getframe(gcf);
  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%movie2avi(F, 'run1.avi', 'compression', 'None');
