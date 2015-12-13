%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Panic Project Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
speedInDesiopeningLower = (roomSize(2)-doorWidth)/2;
redDirection=zeros(1,nAgents);

% - Room (Walls)
walls = WallGeneration(roomSize,doorWidth,openingLength);
figure(1)
clf
hold on
plot(walls(:,1),walls(:,2),'LineWidth',2);
plot(targetPosition(1),targetPosition(2),'x')
axis([-roomSize(1)*0.25 roomSize(1)*1.7 -roomSize(2)*0.25 roomSize(2)*1.25])
% - Desired position
% - Agents
agents = InitializeAgents(nAgents,PROPERTIES,meanMass,meanRadius,...
  targetPosition,roomSize);

% velocityVector = maxVelocity*rand(1,nIndividuals) % In --> InitializeAgents()

% MATRICES - Remove?
structor  = struct('target Position Vector',targetPositionVector,...
  'Velocity vector',velocityVector);

%%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%%
for iTime = 1:nTimeSteps
  currentAcceleration=UpdateAcceleration(agents,walls,PROPERTIES,...
    bodyForceCoeff,frictionForceCoeff);
  desiredDirection=bsxfun(@minus,agents(:,Properties.Position),targetPosition);
  desiredDirection=desiredDirection/norm(desiredDirection);
  speedInDesiredDirection=speedInDesiredDirection+agents(:,Properties.Velocity)*(desiredDirection);
  agents(:,PROPERTIES.Velocity)=agents(:,PROPERTIES.Velocity)+currentAcceleration.*deltaTime;
  agents(:,PROPERTIES.Position)=agents(:,PROPERTIES.Position) +currentVelocity.*deltaTime;
  agents(:,PROPERTIES.DesiredSpeed)=ImpatienceUpdate(agents(:,PROPERTIES.Velocity),agents(:,PROPERTIES.DesiredSpeed),speedInDesiredDirection,iTime);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clf
run('Parameters.m');
walls = WallGeneration(roomSize,doorWidth,openingLength);

%Graphics
%


