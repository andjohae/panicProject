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
for indexDesiredVelocity = 0.6:0.2:8
  run('Parameters.m');
  %  Initialization
  targetPosition = [1.1*roomSize(1),0.5*roomSize(2)];
  avgSpeedInDesiredDirection=zeros(nAgents,1);
  numberOfAgentsOut = [0;0];
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
  %run('SetupSimulationGraphics.m');
  % movieStruct = getframe(gcf); % PLAY: movie(figure,movieStruct,5)
  
  random = rand(nTimeSteps,nAgents);
  %%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%%
  for iTime = 1:nTimeSteps
    if nAgents == 0% time >= 30 ||
      break;
    end
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
    [agents,nAgents,avgSpeedInDesiredDirection,initialDesiredSpeed,...
      socialCorrelations,numberOfAgentsOut ]...
      = RemoveAgentIfOut( agents,nAgents,PROPERTIES,...
      roomSize,avgSpeedInDesiredDirection,initialDesiredSpeed,...
      socialCorrelations,time,numberOfAgentsOut );
    %   % Accumulate speed in desired direction
    %   avgSpeedInDesiredDirection = (avgSpeedInDesiredDirection + ...
    %       sum(agents(:,PROPERTIES.Velocity).*(agents(:,PROPERTIES.DesiredDirection)),2)...
    %       .* deltaTime)/2;
    
    % Update desired direction 
    
% 
%     newDesiredDirection = (0.1*(2*random(iTime,1:nAgents)')+1)...
%       *(targetPosition) - agents(:,PROPERTIES.Position);
    
     newDesiredDirection = ones(nAgents,1)...
      *(targetPosition) - agents(:,PROPERTIES.Position);
    newDesiredDirection(:,2) = newDesiredDirection(:,2) + (2*doorWidth*(2*random(iTime,1:nAgents)-1))';
    agents(:,PROPERTIES.DesiredDirection) = newDesiredDirection .* ...
      ( (1./sqrt( sum( newDesiredDirection.^2, 2 ) )) * [1,1] );
    
    % Update desired speed
    agents(:,PROPERTIES.DesiredSpeed) = indexDesiredVelocity;%(1-agents(:,PROPERTIES.Impatience)).* ...
    %initialDesiredSpeed + (agents(:,PROPERTIES.Impatience) .* maxDesiredSpeed);
    
    %   % Update impatience
    %   agents(:,PROPERTIES.Impatience) = 1 - avgSpeedInDesiredDirection ./ ...
    %       agents(:,PROPERTIES.DesiredSpeed);
    %
%       % Update graphics
%     %   hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
%       set(hAgentPlot, 'XData', agents(:,PROPERTIES.Position(1)), 'YData', ...
%           agents(:,PROPERTIES.Position(2)));
%       set(hTimeStamp, 'String', sprintf('Time: %.5f s',time));
%       drawnow update;
    
    %   movieStruct(iTime) = getframe(gcf);
    if mod(iTime,10000)==0
      disp(time);
    end
  end
  figure(4)
  hold on
  plot(indexDesiredVelocity,numberOfAgentsOut(2,end),'*');
  drawnow update
  saveTime(indexDesiredVelocity*2,:) = numberOfAgentsOut(2,:);
  saveAgentsOut(indexDesiredVelocity*2,:) = sum(numberOfAgentsOut(1,:));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%movie2avi(F, 'run1.avi', 'compression', 'None');

