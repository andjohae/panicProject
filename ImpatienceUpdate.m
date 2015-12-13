function newDesiredVelocity=ImpatienceUpdate(agentVelocity,agentDesiredSpeed,speedInDesiredDirection,iTime);
  meanVelocity=speedInDesiredDirection/iTime;
  p=1 -meanVelocity./agentVelocity;
  newDesiredVelocity= (1-p)*initialVelocity +p*agentDesiredSpeed;
end
