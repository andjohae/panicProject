function acceleration = UpdateAcceleration(agents,walls,PROPERTIES,...
    bodyForceCoeff,frictionForceCoeff)

  % Read properties
  velocity = agents(:,PROPERTIES.Velocity);
  mass = agents(:,PROPERTIES.Mass);
  desiredSpeed = agents(:,PROPERTIES.DesiredSpeed);
  desiredDirection = agents(:,PROPERTIES.DesiredDirection);
  desiredTimeResolution = agents(:,PROPERTIES.DesiredTimeResolution);
  
  % Calculate acceleration components
  desiredVelocityCorrection = (repmat(desiredSpeed,1,2).*desiredDirection - ...
      velocity) .* repmat(desiredTimeResolution.^(-1),1,2);
    
  agentForces = CalculateAgentForces(agents, PROPERTIES, bodyForceCoeff,...
      frictionForceCoeff);
  
  wallForces = CalculateWallForces(agents, PROPERTIES, walls, bodyForceCoeff,...
      frictionForceCoeff);  
    
%   socialForces = CalculateSocialForces(agents,PROPERTIES,socialForceCoeff);  
    
  acceleration = desiredVelocityCorrection + (agentForces + wallForces).*...
      repmat(mass.^(-1),1,2);
  
end