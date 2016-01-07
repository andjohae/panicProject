function [acceleration, agents, checkForces] = UpdateAcceleration(agents,...
    walls,PROPERTIES,bodyForceCoeff,frictionForceCoeff,socialCorrelations,...
    injuryThreshold)

  % Read properties
  velocity = agents(:,PROPERTIES.Velocity);
  mass = agents(:,PROPERTIES.Mass);
  desiredSpeed = agents(:,PROPERTIES.DesiredSpeed);
  desiredDirection = agents(:,PROPERTIES.DesiredDirection);
  desiredTimeResolution = agents(:,PROPERTIES.DesiredTimeResolution);
  
  % Calculate acceleration components
  desiredVelocityCorrection = (repmat(desiredSpeed,1,2).*desiredDirection - ...
      velocity) .* repmat(desiredTimeResolution.^(-1),1,2);
    
  [agentForces, radialAgentForces] = CalculateAgentForces(agents, PROPERTIES,...
    bodyForceCoeff, frictionForceCoeff);
  
  [wallForces, radialWallForces] = CalculateWallForces_2(agents, PROPERTIES,...
    walls, bodyForceCoeff, frictionForceCoeff);  
  

%   % Check if any agents are injured
  radialMagnitude = sum((radialAgentForces + radialWallForces).^2,2).^0.5;      % OBS
  
  agents(:,PROPERTIES.InjuryStatus) = ((radialMagnitude./...
    (2*pi*agents(:,PROPERTIES.Radius))) >= injuryThreshold) + 0;

%   agents(:,PROPERTIES.RepulsionCoeff) = -(agents(:,PROPERTIES.InjuryStatus)...
%     - 1).*agents(:,PROPERTIES.RepulsionCoeff);
%   agents(:,PROPERTIES.Radius) = -(agents(:,PROPERTIES.InjuryStatus)...
%     - 1).*agents(:,PROPERTIES.Radius);

  
%   socialAcceleration = CalculateSocialAcc(agents,PROPERTIES,socialCorrelations); 
  
    checkForces = [radialAgentForces,radialWallForces];
  acceleration = desiredVelocityCorrection + (agentForces + wallForces).*...
      repmat(mass.^(-1),1,2);% + socialAcceleration;
%     
%   % Print out size of acceleration components
%   maxDesired = max(sqrt(sum(desiredVelocityCorrection.^2)));
%   maxAgents = max(sqrt(sum(agentForces.^2)))/(mass(1)*maxDesired);
%   maxWalls =  max(sqrt(sum(wallForces.^2)))/(mass(1)*maxDesired);
%   maxSocial = max(sqrt(sum(socialAcceleration.^2)))/maxDesired;
%   % Max acc components relative to the desired velocity correction\n
%   fprintf('agents: %8.3f\t walls: %8.3f\t social %8.3f\n',maxAgents,maxWalls,maxSocial); 
end
