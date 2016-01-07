function deltaTime = CalculateVariableTimeStep(acceleration, defaultDeltaTime,...
    velocityChangeLimit, timeStepMultiplier, minimumDeltaTime, injuryStatus)
  
  deltaTime = defaultDeltaTime;
  % Don't calculate for injured agents
  acceleration = acceleration .* -((injuryStatus-1)*[1,1]);
  
  isTooLargeDeltaTime = any( sqrt( sum((acceleration.*deltaTime).^2, 2)) > ...
      velocityChangeLimit );
    
  while ( isTooLargeDeltaTime && (deltaTime > minimumDeltaTime) )
    deltaTime = deltaTime * timeStepMultiplier;
    isTooLargeDeltaTime = any( sqrt( sum((acceleration.*deltaTime).^2, 2)) > ...
      velocityChangeLimit );
  end
  
end
