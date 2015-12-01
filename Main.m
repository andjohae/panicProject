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
%TODO:

%%%%%%%%%%%%%%%%%%%%%% Initilize %%%%%%%%%%%%%%%%%%%%%%%%%
%  Read settings
run('Settings.m');

%  Initialization
% - Room (Walls)
% - Desired position
targetPosition = [1.5*roomSize(1),0.5*roomSize(2)];
% - Agents
agents = InitializeAgents(); 

% velocityVector = maxVelocity*rand(1,nIndividuals) % In --> InitializeAgents()

% MATRICES - Remove?
structor  = struct('target Position Vector',targetPositionVector,...
     'Velocity vector',velocityVector);
   
%%%%%%%%%%%%%%%%%%%%%% Main Loop %%%%%%%%%%%%%%%%%%%%%%%%% 
for iTime = 1:nTimeSteps
  currentAcceleration=UpdateAcceleration();
  agents(:,PROPERTIES.Velocity)=agents(:,PROPERTIES.Velocity)+UpdateVelocity(currentAcceleration)*deltaTime;
  agents(:,PROPERTIES.Position)=agents(:,PROPERTIES.Position) +UpdatePositions(currentVelocity)*deltaTime;
  
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
