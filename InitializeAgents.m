function agents = InitializeAgents(nAgents,PROPERTIES,roomSize)

  agents = zeros(nAgents,nProperties);
  % Properties:
  % - Position [1,2]
    agents(1,:) = 1:nAgents^-1:roomSize;
    agents(2,:) = 1:nAgents^-1:roomSize;
  % - Velocity [3,4]
    agents(3,:) = zeros(1,nAgents);
    agents(4,:) = zeros(1,nAgents);
  % - Mass [5]
    agents(5,:) = meanMass*ones(1,nAgents);
  % - Radius [6]
    agents(6,:) = meanRadius*ones(1,nAgents);
  % - Desired speed [7]
    agents(7,:) = ones(1,nAgents);%Completely arbitrary
  % - Desired direction [8,9]
    agents(8,:) = targetPosition*ones(1,nAgents);
    agents(9,:) = targetPosition*ones(1,nAgents);
  % - Desired time resolution [10]
    agents(10,:) = ones(1,nAgents);
  % - Repulsion coefficient [11]
    agents(11,:) = ones(1,nAgents);
  % - Repulsion exponent [12]
    agents(12,:) = ones(1,nAgents);
  % - Impatience [13]
    agents(11,:) = zeros(1,nAgents);
end
