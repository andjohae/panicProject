function agents = InitializeAgents(nAgents,PROPERTIES,roomSize)

agents = zeros(nAgents,nProperties);
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
agents(:,PROPERTIES.Position) = pos;
  % - Velocity [3,4]
agents(:,3) = zeros(nAgents,1);
agents(:,4) = zeros(nAgents,1);
  % - Mass [5]
    agents(:,5) = meanMass*ones(nAgents,1);
  % - Radius [6]
    agents(:,6) = meanRadius*ones(nAgents.1);
  % - Desired speed [7]
    agents(:,7) = ones(nAgents,1);%Completely arbitrary
  % - Desired direction [8,9]
    agents(:,8) = targetPosition*ones(nAgents,1);
    agents(:,9) = targetPosition*ones(nAgents,1);
  % - Desired time resolution [10]
    agents(:,10) = ones(nAgents,1);
  % - Repulsion coefficient [11]
    agents(:,11) = ones(nAgents,1);
  % - Repulsion exponent [12]
    agents(:,12) = ones(nAgents,1);
  % - Impatience [13]
    agents(:,11) = zeros(nAgents,1);
end
