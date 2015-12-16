function  [agents,nAgents,avgSpeedInDesiredDirection,initialDesiredSpeed ] ...
    = RemoveAgentIfOut( agents,nAgents,...
    PROPERTIES,roomSize,avgSpeedInDesiredDirection,initialDesiredSpeed  )
  % - Check Position
  if any(agents(:,PROPERTIES.Position(1)) > (roomSize(1)+agents(:,PROPERTIES.Radius)))
    indexToRM =  find(agents(:,PROPERTIES.Position(1)) > (roomSize(1)+agents(:,PROPERTIES.Radius)));
    agents(indexToRM,:) = [];
    avgSpeedInDesiredDirection(indexToRM) = [];
    nAgents = length(avgSpeedInDesiredDirection);
    initialDesiredSpeed(indexToRM) = [];
  end
end

