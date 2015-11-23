%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%  Panic Project Main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%%%% TODO List %%%%%%%%%%%%%%%%%%%%%%%%%%
%TODO: IntializeAgents()
%TODO: IntializeWalls()
%TODO: Main loop structure
%TODO: UpdateAcceleration()
  % - Subfunctions for all forces
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

% Translation structor
% IDEA: We could just use constants? 'POSITION = [1,2]' etc. Faster?
translate = struct('Position',[1,2],...
                   'Velocity',[3,4],...
                   'Mass',5,...
                   'Radius',6); % etc.

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
 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
