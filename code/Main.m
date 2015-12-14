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
speedInDesiredDirection=zeros(nAgents,1);

% - Room (Walls)
walls = WallGeneration(roomSize,doorWidth,openingLength);

% - Agents
agents = InitializeAgents(nAgents,PROPERTIES,meanMass,meanRadius,...
  targetPosition,roomSize, initialVelocity);

% - Social Bonds
socialCorrelations = InitilizeSocialNetwork(agents,PROPERTIES,socialCorrelations,...
bondProbabilityPerAgent);

% Initialize simulation graphics
run('SetupSimulationGraphics.m');
movieStruct = getframe(gcf); % PLAY: movie(figure,movieStruct,5)

%%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%%
for iTime = 1:1
  
  % Update physics
  currentAcceleration = UpdateAcceleration(agents,walls,PROPERTIES,...
      bodyForceCoeff,frictionForceCoeff);
  agents(:,PROPERTIES.Velocity) = agents(:,PROPERTIES.Velocity) + ...
      currentAcceleration .* deltaTime;
  agents(:,PROPERTIES.Position) = agents(:,PROPERTIES.Position) + ...
      agents(:,PROPERTIES.Velocity).*deltaTime;
    % TODO: UpdatePositions() that checks if new positons are valid
  
  % Update desired direction
  newDesiredDirection = ones(nAgents,1)*targetPosition - agents(:,PROPERTIES.Position);
  agents(:,PROPERTIES.DesiredDirection) = newDesiredDirection .* ...
      ( (1./sqrt( sum( newDesiredDirection.^2, 2 ) )) * [1,1] );

  % Accumulate speed in desired direction
  speedInDesiredDirection = speedInDesiredDirection + ...
      sum(agents(:,PROPERTIES.Velocity).*(agents(:,PROPERTIES.DesiredDirection)),2);
  
  % Update impatience
  agents(:,PROPERTIES.Impatience) = 1 - (speedInDesiredDirection./iTime) ./ ...
      sqrt( sum(agents(:,PROPERTIES.Velocity).^2,2) );
 
  % Update desired speed
  agents(:,PROPERTIES.DesiredSpeed) = (1-agents(:,PROPERTIES.Impatience)).* ...
      sqrt(sum(initialVelocity.^2,2)) + (agents(:,PROPERTIES.Impatience) .* maxDesiredSpeed);
  
  % Update graphics
  % draw connections
  set(hAgentPlot, 'XData', agents(:,PROPERTIES.Position(1)), 'YData', ...
      agents(:,PROPERTIES.Position(2)));
  hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
  set(hTimeStamp, 'String', sprintf('Time: %d',iTime));
  drawnow update;
  movieStruct = getframe(gcf);
  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
