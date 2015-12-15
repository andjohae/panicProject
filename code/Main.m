%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Panic Project Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
%%%%%%%%%%%%%%%%%%%%% TODO List %%%%%%%%%%%%%%%%%%%%%%%%%%
%TODO: IntializeAgents()
%TODO: IntializeWalls()
%TODO: Main loop structure
%TODO: CalculateAgentForces()
%TODO: CalculateWallForces()
%TODO: Calculate variable time step
%TODO: UpdateVelocity()
%TODO: UpdatePosition()
%TODO: Graphics
% - InitializeGraphics()
% - UpdateGraphics()
%TODO: Implement impatience. In UpdateAcceleration or elsewhere?

%%%%%%%%%%%%%%%%%%%%%% Initilize %%%%%%%%%%%%%%%%%%%%%%%%%
%  Read settings
run('Parameters.m');

%  Initialization
targetPosition = [1.5*roomSize(1),0.5*roomSize(2)];
avgSpeedInDesiredDirection=zeros(nAgents,1);

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
movieStruct = getframe(gcf); % PLAY: movie(figure,movieStruct,5)

%%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%%
for iTime = 1:nTimeSteps
  
  % Update physics
  currentAcceleration = UpdateAcceleration(agents,walls,PROPERTIES,...
      bodyForceCoeff,frictionForceCoeff);
  
  
  agents(:,PROPERTIES.Velocity) = agents(:,PROPERTIES.Velocity) + ...
      currentAcceleration .* deltaTime;
  agents(:,PROPERTIES.Position) = agents(:,PROPERTIES.Position) + ...
      agents(:,PROPERTIES.Velocity).*deltaTime;
    % TODO: UpdatePositions() that checks if new positons are valid
  
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
  hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
  set(hAgentPlot, 'XData', agents(:,PROPERTIES.Position(1)), 'YData', ...
      agents(:,PROPERTIES.Position(2)));
  set(hTimeStamp, 'String', sprintf('Time: %d',iTime));
  drawnow update;

  movieStruct(iTime) = getframe(gcf);
  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%movie2avi(F, 'run1.avi', 'compression', 'None');
