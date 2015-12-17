function wallForces =  CalculateWallForces_2(agents,PROPERTIES,walls,...
    bodyForceCoeff,frictionForceCoeff)

  % This version of the code only allows for agent-wall interaction if the
  % agent (mass centre) is in front of the wall.
  
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
      if ( logical(walls(iCorner,3)) && logical(walls((iCorner+1),3)) )
        
        radiiSum = radius(iAgent); % Walls don't have thickness
        
        % Compute wall from corners
        wallVector = walls( iCorner+1, 1:2 ) - walls( iCorner, 1:2 );
        wallLength = norm(wallVector);
        wallTangent = wallVector./wallLength; % Normalize
        wallNormal = [wallTangent(2), -wallTangent(1)];
        
        % Calculate distance from first corner to projection of agent on wall
        % :NOTE: Must use scalar product with wall tangent!
        projectionPosition = wallTangent * (position(iAgent,:)-walls(iCorner,1:2))'; 
        
        % Only interact with wall if projection of agent is ON the wall segment
        if ( (projectionPosition > (0-radius(iAgent))) && (projectionPosition < (wallLength+radius(iAgent))) ) 
          distance = ( position(iAgent,:) - walls(iCorner,1:2) ) * wallNormal';
          
          % Calculate repulsion force
          repulsionForce(iCorner,:) = repulsionCoeff(iAgent) * exp((radiiSum-distance)/...
              repulsionExp(iAgent)) .* wallNormal;

          if (distance <= radiiSum) % Check for collision
            % Calculate body force
            bodyForce(iCorner,:) = bodyForceCoeff * (radiiSum - distance) .* ...
                wallNormal;

            % Calculate friction force
            relativeTangentialVelocity = (-velocity(iAgent,:)) * wallTangent';
            frictionForce(iCorner,:) = frictionForceCoeff * (radiiSum - distance)...
                * relativeTangentialVelocity * wallTangent;
          end
        end
        
      end % End of interaction check
      
    end % End of wall loop
    
    wallForces(iAgent,:) = sum(repulsionForce,1) + sum(bodyForce,1) + ...
        sum(frictionForce,1);
    
  end
end