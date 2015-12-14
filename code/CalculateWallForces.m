function wallForces =  CalculateWallForces(agents,PROPERTIES,walls,...
    bodyForceCoeff,frictionForceCoeff)

  % Read necessary properties
  position = agents(:,PROPERTIES.Position);
  velocity = agents(:,PROPERTIES.Velocity);
  radius = agents(:,PROPERTIES.Radius);
  repulsionCoeff = agents(:,PROPERTIES.RepulsionCoeff);
  repulsionExp = agents(:,PROPERTIES.RepulsionExp);
  
  % Initialization
  nAgents = size(agents,1);
  nWalls = size(walls,1)-1;
  wallForces = zeros(nAgents,2);
  
  for iAgent = 1:nAgents % Loop over all agents
    repulsionForce = zeros(nWalls,2);
    bodyForce = zeros(nWalls,2);
    frictionForce = zeros(nWalls,2);
    
    for iCorner = 1:nWalls % Loop over all corners in wall matrix
      
      % Check if current wall is to be interacted with
      if ( logical(walls(iCorner,3)) || logical(walls((iCorner+1),3)) )
        
        % Compute wall from corners
        wallTangent = walls( iCorner+1, 1:2 ) - walls( iCorner, 1:2 );
        wallTangent = wallTangent./norm(wallTangent); % Normalize
  
        wallNormal = [wallTangent(2), -wallTangent(1)];
        distance = position(iAgent,:)*wallNormal';
        radiiSum = radius(iAgent);
        
        % Calculate repulsion force
        repulsionForce(iCorner,:) = repulsionCoeff(iAgent) * exp((radiiSum-distance)/...
            repulsionExp(iAgent)) .* wallNormal;

        if (distance <= radiiSum) % Check for collision
          % Calculate body force
          bodyForce(iCorner,:) = bodyForceCoeff * (radiiSum - distance) .* wallNormal;

          % Calculate friction force
          relativeTangentialVelocity = (-velocity(iAgent,:)) * wallTangent';
          frictionForce(iCorner,:) = frictionForceCoeff * (radiiSum - distance) * ...
              relativeTangentialVelocity * wallTangent;
        end
      end
      
    end % End of wall loop
    
    wallForces(iAgent,:) = sum(repulsionForce,1) + sum(bodyForce,1) + ...
        sum(frictionForce,1);
    
  end
end