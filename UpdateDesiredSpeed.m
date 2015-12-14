function newDesiredSpeed = UpdateDesiredSpeed(agent, PROPERTIES, ...
    speedInDesiredDirection,iTime, maxDesiredSpeed)
 
  % Read properties
  velocity = agents(:,PROPERTIES.Velocity);
  desiredSpeed = agents(:,PROPERTIES.DesiredSpeed);
  impatience = agents(:,PROPERTIES.Impatience);
  
%   Calculate new desired speed
  meanVelocity = speedInDesiredDirection/iTime;
  impatience = 1 -meanVelocity./agentVelocity;
  
  agents(:,PROPERTIES.Impatience) = 1 - (speedInDesiredDirection./iTime) ./ ...
      agents(:,PROPERTIES.Velocity);
  
  newDesiredSpeed = (1-impatience)*initialVelocity +impatience*desiredSpeed;

end
