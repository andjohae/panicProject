function closetstDistWalls = GetClosestDistWalls(nAgents,agents,walls)
%Output size = [nAgents,5] 
%Only for the innerwalls
le = length(walls);
distCorners = zeros(le,2);
dimensionCorrection = ones(nAgents,1);
for j = 1:nAgents
  if agents(j,PROPERTIES.Position(2))<walls(3,1);
    distw(j,1) =  norm(agents(:,PROPERTIES.Position)-...
      dimensionCorrection*walls(3,1));
  else
    distw(j,1) = roomSize(1) - agents(j,PROPERTIES.Position(1));
  end
  
  distw(j,2) = agents(j,PROPERTIES.Position(2));
  distw(j,3) = agents(j,PROPERTIES.Position(1));
  distw(j,4)= roomSize(2) - agents(j,PROPERTIES.Position(2));
  
  if agents(j,PROPERTIES.Position(2))>walls(8,1);
    distw(j,5) =  norm(agents(:,PROPERTIES.Position)-...
      dimensionCorrection*walls(8,1));
  else
    distw(j,5) = roomSize(1) - agents(j,PROPERTIES.Position(1));
  end
end

closestDistWalls = distw;
end
