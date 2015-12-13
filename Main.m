%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Panic Project Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
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
figure(1)
clf
hold on
plot(walls(:,1),walls(:,2),'LineWidth',2);
plot(targetPosition(1),targetPosition(2),'x','MarkerSize',150)

  axis([-roomSize(1)*0.25 roomSize(1)*1.7 -roomSize(2)*0.25 roomSize(2)*1.25])

% - Desired position
% - Agents
agents = InitializeAgents(nAgents,PROPERTIES,meanMass,meanRadius,...
  targetPosition,roomSize);

% velocityVector = maxVelocity*rand(1,nIndividuals) % In --> InitializeAgents()

% MATRICES - Remove?


%%%%%%%%%%%%%%%%%%%%%% MainLoop %%%%%%%%%%%%%%%%%%%%%%%%%
for iTime = 1:nTimeSteps*100
  currentAcceleration=UpdateAcceleration(agents,walls,PROPERTIES,...
    bodyForceCoeff,frictionForceCoeff);
  
  desiredDirection=bsxfun(@minus,targetPosition,agents(:,PROPERTIES.Position));
  agents(:,PROPERTIES.DesiredDirection)=desiredDirection/norm(desiredDirection,2);
  speedInDesiredDirection=speedInDesiredDirection+sum(agents(:,PROPERTIES.Velocity).*(agents(:,PROPERTIES.DesiredDirection)),2);
  
  agents(:,PROPERTIES.Velocity)=agents(:,PROPERTIES.Velocity)+currentAcceleration.*deltaTime;
  agents(:,PROPERTIES.Position)=agents(:,PROPERTIES.Position)+ agents(:,PROPERTIES.Velocity).*deltaTime;
  agents(:,PROPERTIES.DesiredSpeed)=ImpatienceUpdate(agents, PROPERTIES,speedInDesiredDirection,iTime,maxDesiredVelocity)
  clf
  hold on
	
      axis([-roomSize(1)*0.25 roomSize(1)*1.7 -roomSize(2)*0.25 roomSize(2)*1.25])

  plot(walls(:,1),walls(:,2),'LineWidth',2);
  plot(targetPosition(1),targetPosition(2),'x','MarkerSize',20)

  plot(agents(:,PROPERTIES.Position(1)),agents(:,PROPERTIES.Position(2)),'.','MarkerSize',30);

  drawnow update;
  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clf
run('Parameters.m');
walls = WallGeneration(roomSize,doorWidth,openingLength);

%Graphics
%
