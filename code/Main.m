%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Panic Project Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for fghj = 1:20
clc;
clear all;
%%%%%%%%%%%%%%%%%%%%% TODO List %%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Run tests and collect data!

%%%%%%%%%%%%%%%%%%%%%% Initilize %%%%%%%%%%%%%%%%%%%%%%%%%
saveTime = zeros(1,52);
saveNSurvive = 0;
saveMaxForces = [0,0];%0]
%  Read settings
for indexDesiredVelocity = 1:0.2:8
  run('Parameters.m');
  %  Initialization
  targetPosition = [1.1*roomSize(1),0.5*roomSize(2)];
  avgSpeedInDesiredDirection=zeros(nAgents,1);
  timeOfAgentsOut = indexDesiredVelocity;
  time = 0;
  nAgentsOrg = nAgents;
  maxForceAgent = 0;
  maxForceWall = 0;
  % - Room (Walls)
  walls = WallGeneration(roomSize,doorWidth,openingLength);
  
  % - Agents
  agents = InitializeAgents(nAgents, PROPERTIES, meanMass, meanRadius,...
    radiusDistWidth, targetPosition, roomSize, initialVelocity, initialDesiredSpeed, ...
    desiredTimeResolution);
  
  % - Social Bonds
  socialCorrelations = InitilizeSocialNetwork(nAgents,socialCorrelations,...
    ratioBondsPerAgent);
  
  % Initialize simulation graphics
  run('SetupSimulationGraphics.m');
  % movieStruct = getframe(gcf); % PLAY: movie(figure,movieStruct,5)
  
  random = normrnd(0,1,nTimeSteps,nAgents)/2;
  %%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%%
  for iTime = 1:nTimeSteps
    
    %     nAlive = 0;
    %     for iAlive = 1:nAgents
    %       if agents(iAlive,PROPERTIES.InjuryStatus) < 1
    %         nAlive = nAlive + 1;
    %       end
    %     end
    nAlive = length(find(~agents(:,PROPERTIES.InjuryStatus)));
    %Break Condition
    if nAlive == 0;
      break;
    end
    
    % Update model physics
    % - acceleration
    [currentAcceleration, agents, checkForces] = UpdateAcceleration(agents,...
      walls,PROPERTIES,bodyForceCoeff,frictionForceCoeff,socialCorrelations,...
      injuryThreshold);
    
    if checkForces(1) > maxForceAgent
      maxForceAgent = checkForces(1);
    end
    if checkForces(2) > maxForceWall
      maxForceWall = checkForces(1);
    end
    
    % - variable time step
    deltaTime = CalculateVariableTimeStep(currentAcceleration,defaultDeltaTime,...
      velocityChangeLimit, timeStepMultiplier, minimumDeltaTime,...
      agents(:,PROPERTIES.InjuryStatus));
    time = time + deltaTime;
    % - velocity
    agents(:,PROPERTIES.Velocity) = agents(:,PROPERTIES.Velocity) + ...
      currentAcceleration .* deltaTime;
    % - position
    agents(:,PROPERTIES.Position) = agents(:,PROPERTIES.Position) + ...
      (~logical(agents(:,PROPERTIES.InjuryStatus)))*[1,1] .* ... % Don't move injured agents
      agents(:,PROPERTIES.Velocity).*deltaTime;
    
    [agents,nAgents,avgSpeedInDesiredDirection,initialDesiredSpeed,...
      socialCorrelations,timeOfAgentsOut ]...
      = RemoveAgentIfOut( agents,nAgents,PROPERTIES,...
      roomSize,avgSpeedInDesiredDirection,initialDesiredSpeed,...
      socialCorrelations,time,timeOfAgentsOut );
    %   % Accumulate speed in desired direction
    %   avgSpeedInDesiredDirection = (avgSpeedInDesiredDirection + ...
    %       sum(agents(:,PROPERTIES.Velocity).*(agents(:,PROPERTIES.DesiredDirection)),2)...
    %       .* deltaTime)/2;
    
    % Update desired direction'MarkerEdgeColor','red'
    
    %
    %     newDesiredDirection = (0.1*(2*random(iTime,1:nAgents)')+1)...
    %       *(targetPosition) - agents(:,PROPERTIES.Position);
    
    newDesiredDirection = ones(nAgents,1)...
      *(targetPosition) - agents(:,PROPERTIES.Position);
    newDesiredDirection(:,2) = newDesiredDirection(:,2) + (doorWidth*(random(iTime,1:nAgents)))';
    agents(:,PROPERTIES.DesiredDirection) = newDesiredDirection .* ...
      ( (1./sqrt( sum( newDesiredDirection.^2, 2 ) )) * [1,1] );
    
    % Update desired speed
    agents(:,PROPERTIES.DesiredSpeed) = indexDesiredVelocity;%(1-agents(:,PROPERTIES.Impatience)).* ...
    %initialDesiredSpeed + (agents(:,PROPERTIES.Impatience) .* maxDesiredSpeed);
    
    %   % Update impatience
    %   agents(:,PROPERTIES.Impatience) = 1 - avgSpeedInDesiredDirection ./ ...
    %       agents(:,PROPERTIES.DesiredSpeed);
    if mod(iTime,1000)==0
      disp(time);
      
      % Update graphics
      %   hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
      agentColors = agents(:,PROPERTIES.InjuryStatus)*[1 0.4 0] + ...
                    -(agents(:,PROPERTIES.InjuryStatus)-1)*[0 0 1];
      set(hAgentPlot, 'XData', agents(:,PROPERTIES.Position(1)), 'YData', ...
        agents(:,PROPERTIES.Position(2)),'CData',agentColors);
      
      radius = agents(:,PROPERTIES.Radius);
      markerWidth = (2*radius)./diff(xlim).*axpos(3);
      markerHeight = (2*radius)./diff(ylim).*axpos(4);
      set(hAgentPlot, 'SizeData', markerWidth.*markerHeight);
      
      set(hTimeStamp, 'String', sprintf('Time: %.5f s',time));
      drawnow update;
    end
    %   movieStruct(iTime) = getframe(gcf);
    
  end
  
  nSurvivors = nAgentsOrg + nAlive - nAgents;
  meanEscapeTime = sum(timeOfAgentsOut)/length(timeOfAgentsOut);
  figure(4)
  hold on
  if nAlive - nAgents == 0
    plot(indexDesiredVelocity,timeOfAgentsOut(end),'g*');
  else
    plot(indexDesiredVelocity,timeOfAgentsOut(end),'r*');
  end
  text(indexDesiredVelocity,timeOfAgentsOut(end),num2str(nSurvivors))
  
  figure(5)
  hold on
  if nAlive - nAgents == 0
    plot(indexDesiredVelocity,meanEscapeTime,'g*');
  else
    plot(indexDesiredVelocity,meanEscapeTime,'r*');
  end
  text(indexDesiredVelocity,meanEscapeTime,num2str(nSurvivors))
  hold off
  drawnow update
  %numberOfAgentsOut(:,1) = [];
  saveTime(end+1,:) = [timeOfAgentsOut, zeros(1,nAgentsOrg + 1-length(timeOfAgentsOut))];
  
  saveNSurvive(end+1) = nSurvivors;
  
  saveMaxForces(end+1,:) = [maxForceAgent, maxForceWall];%0]
end

SaveDataToFile(saveTime,'Time','',',',1);
saveDataToFile(saveNSurvive,'NSurvive','',',',1);

 SaveDataToFile(saveTime,'data_2/Time','',',',1);
  %SaveDataToFile(saveNSurvive,'data_2/NSurvive','',',',1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%movie2avi(F, 'run1.avi', 'compression', 'None');

