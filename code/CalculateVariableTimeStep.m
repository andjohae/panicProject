function deltaTime = CalculateVariableTimeStep(acceleration, defaultDeltaTime,...
    velocityChangeLimit, timeStepMultiplier, minimumDeltaTime)
  
  deltaTime = defaultDeltaTime;
  
  isTooLargeDeltaTime = any( sqrt( sum((acceleration.*deltaTime).^2, 2)) > ...
      velocityChangeLimit );
    
  while ( isTooLargeDeltaTime && (deltaTime > minimumDeltaTime) )
    deltaTime = deltaTime * timeStepMultiplier;
    isTooLargeDeltaTime = any( sqrt( sum((acceleration.*deltaTime).^2, 2)) > ...
      velocityChangeLimit );
  end
  
end