function  [agents,nAgents,avgSpeedInDesiredDirection,initialDesiredSpeed,socialCorrelations ] ...
    = RemoveAgentIfOut( agents,nAgents,...
    PROPERTIES,roomSize,avgSpeedInDesiredDirection,initialDesiredSpeed, socialCorrelations )
  % - Check Position
  if any(agents(:,PROPERTIES.Position(1)) > (roomSize(1)+agents(:,PROPERTIES.Radius)))
    indexToRM =  find(agents(:,PROPERTIES.Position(1)) > (roomSize(1)+agents(:,PROPERTIES.Radius)));
    agents(indexToRM,:) = [];
    avgSpeedInDesiredDirection(indexToRM) = [];
    nAgents = length(avgSpeedInDesiredDirection);
    initialDesiredSpeed(indexToRM) = [];
    socialCorrelations(indexToRM,:) = [];
    socialCorrelations(:,indexToRM) = [];
  end
end

