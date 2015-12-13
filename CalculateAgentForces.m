function agentForces = CalculateAgentForces(agents, PROPERTIES, bodyForceCoeff,...
    frictionForceCoeff)
  
  % Idea: Can we shorten evaluation time if we calculate forces pairwise?
  
  % Read necessary properties
  position = agents(:,PROPERTIES.Position);
  velocity = agents(:,PROPERTIES.Velocity);
  radius = agents(:,PROPERTIES.Radius);
  repulsionCoeff = agents(:,PROPERTIES.RepulsionCoeff);
  repulsionExp = agents(:,PROPERTIES.RepulsionExp);
  
  % Initialization
  nAgents = size(agents,1);
  agentForces = zeros(nAgents,2);
  
  % Loop over all agents
  for i = 1:nAgents
    repulsionForce = zeros(nAgents,2);
    bodyForce = zeros(nAgents,2);
    frictionForce = zeros(nAgents,2);
    
    for j = 1:nAgents
      if (i ~= j) % Can't interact with oneself  
        direction = position(i,:)-position(j,:);
        distance = norm(direction);
        unitDirection = direction./distance;
        radiiSum = radius(i)+radius(j);
        
        % Calculate repulsion force
        repulsionForce(j,:) = repulsionCoeff(i) * exp((radiiSum-distance)/...
            repulsionExp(i)) .* unitDirection;
        
        if (distance <= radiiSum) % Check for collision
          % Calculate body force
          bodyForce(j,:) = bodyForceCoeff * (radiiSum - distance) .* unitDirection;
          
          % Calculate friction force
          tangent = [-unitDirection(2), unitDirection(1)];
          relativeTangentialVelocity = (velocity(j,:)-velocity(i,:)) * tangent'; % Equivalent to scalar product?
          frictionForce(j,:) = frictionForceCoeff * (radiiSum - distance) * ...
              relativeTangentialVelocity * tangent;
        end
      end
    end
    
    % Expansion: check if body forces exceed injury tolerence
    
    % Calculate sum of interaction forces
    agentForces(i,:) = sum(repulsionForce,1) + sum(bodyForce,1) + sum(frictionForce,1);
    
  end
  
end