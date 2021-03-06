function agents = InitializeAgents(nAgents,PROPERTIES,meanMass,...
  meanRadius,radiusDistWidth,targetPosition,roomSize,initialVelocity,initialDesiredSpeed,...
  desiredTimeResolution)

%agents = zeros(nAgents,nProperties);
% Properties:
  % - Position [1,2]
nAgentsSquared = ceil(nAgents^0.5);
pos = zeros(nAgents,2);
for j = 0:nAgentsSquared-1
  pos((1:nAgentsSquared)+j*nAgentsSquared) = (j+1)*ones(nAgentsSquared,1);
end
for i = 1:nAgents
  pos(i,2) = mod(i,nAgentsSquared)+1;
end
pos(:,1) = pos(:,1)/(max(pos(:,1))+1)*roomSize(1);
pos(:,2) = pos(:,2)/(max(pos(:,2))+1)*roomSize(2);
%plot(pos(:,1),pos(:,2),'.','MarkerSize',20)
pertubation = ((pos(2,1)-pos(2,2))-meanRadius)/4*(2*rand(nAgents,2)-1);
agents(:,PROPERTIES.Position) = pos + pertubation;
  % - Velocity [3,4]
agents(:,PROPERTIES.Velocity) = initialVelocity;
  % - Mass [5]
    agents(:,PROPERTIES.Mass) = meanMass*ones(nAgents,1);
  % - Radius [6]
    agents(:,PROPERTIES.Radius) = meanRadius + radiusDistWidth .* (rand(nAgents,1)-0.5);
  % - Desired speed [7]
    agents(:,PROPERTIES.DesiredSpeed) = initialDesiredSpeed;
  % - Desired direction [8,9]
    agents(:,PROPERTIES.DesiredDirection) = ones(nAgents,1)*targetPosition-pos;
  % - Desired time resolution [10]
    agents(:,PROPERTIES. DesiredTimeResolution) = desiredTimeResolution;
  % - Repulsion coefficient [11]
    agents(:,PROPERTIES.RepulsionCoeff) = 2000*ones(nAgents,1);
  % - Repulsion exponent [12]
    agents(:,PROPERTIES.RepulsionExp) = 0.08*ones(nAgents,1);
  % - Impatience [13]
    agents(:,PROPERTIES.Impatience) = zeros(nAgents,1);
  % - Injury Status [13]
    agents(:,PROPERTIES.InjuryStatus) = zeros(nAgents,1);
end
