function agentForces = CalculateAgentForces(agents, PROPERTIES, bodyForceCoeff,...
    frictionForceCoeff)

  % NOTE: Vector or scalar multiplication of tangential forces?
  %   More precisely, is the relative tangential velocity as vector or
  %   scalar? If it's a vector, how do we multiplicate?
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
  repulsionForce = zeros(nAgents,2);
  bodyForce = zeros(nAgents,2);
  frictionForce = zeros(nAgents,2);
  
  % Loop over all agents
  for i = 1:nAgents
    for j = 1:nAgents
      
      if (i ~= j) % Can't interact with oneself  
        direction = position(i,:)-position(j,:);
        distance = norm(direction);
        unitDirection = direction./distance;
        radiiSum = radius(i)+radius(j);
        
        repulsionForce(i,:) = repulsionCoeff(i) * exp((radiiSum-distance)/...
            repulsionExp(i)) .* unitDirection;
        
        if (distance <= radiiSum) % Check for collosion
          % Calculate body force
          bodyForce(i,:) = bodyForceCoeff * (radiiSum - distance) .* unitDirection;
          
          % Calculate friction force
          tangent = [-unitDirection(2), unitDirection(1)];
          relativeTangentialVelocity = (velocity(j,:)-velocity(i,:)) .* tangent;
          frictionForce(i,:) = frictionForceCoeff * (radiiSum - distance) * ...
              relativeTangentialVelocity * tangent; % <--- SEE NOTE!
        end
      else
        agentForces(i,:) = [0,0];
      end
      
    end
  end
  
end