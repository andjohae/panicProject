function newDesiredSpeed = UpdateDesiredSpeed(agent, PROPERTIES, ...
    speedInDesiredDirection,iTime)
 
  % Read properties
  velocity = agents(:,PROPERTIES.Velocity);
  desiredSpeed = agents(:,PROPERTIES.DesiredSpeed);
  
  % Calculate new desired speed
  meanVelocity=speedInDesiredDirection/iTime;
  impatience = 1 -meanVelocity./agentVelocity;
  newDesiredSpeed = (1-impatience)*initialVelocity +impatience*aesiredSpeed;

end
