function acceleration = UpdateAcceleration(agents,PROPERTIES,bodyForceCoeff,...
    frictionForceCoeff)

  % Read properties
  position = agents(:,PROPERTIES.Position);
  velocity = agents(:,PROPERTIES.Velocity);
  mass = agents(:,PROPERTIES.Mass);
  radius = agents(:,PROPERTIES.Radius);
  desiredSpeed = agents(:,PROPERTIES.DesiredSpeed);
  desiredDirection = agents(:,PROPERTIES.DesiredDirection);
  desiredTimeResolution = agents(:,PROPERTIES.DesiredTimeResolution);
  repulsionCoeff = agents(:,PROPERTIES.RepulsionCoeff);
  repulsionExp = agents(:,PROPERTIES.RepulsionExp);
  impatience = agents(:,PROPERTIES.Impatience);  
  
  % Initialization
  nAgents = size(agents,1);
%   acceleration = zeros(nAgents,2); % Not needed if no loop over agents
  desiredVelocityCorrection= zeros(nAgents,2);
  individualForces = zeros(nAgents,2);
  wallForces = zeros(nAgents,2);
  
  % Calculate acceleration components
  desiredVelocityCorrection = desiredSpeed(iAgent)
    
    
  acceleration = desiredVelocityCorrection + (individualForces + wallForces).*...
      repmat(mass.^(-1),1,2);
  
end