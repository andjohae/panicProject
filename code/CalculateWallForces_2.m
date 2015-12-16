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
        
        radiiSum = radius(iAgent); % Walls don't have thickness
        
        % Compute wall from corners
        wallVector = walls( iCorner+1, 1:2 ) - walls( iCorner, 1:2 );
        wallLength = norm(wallVector);
        wallTangent = wallVector./wallLength; % Normalize
        wallNormal = [wallTangent(2), -wallTangent(1)];
        
        % Calculate distance from wall to agent:
        % - Calculate distance from first corner to projection on wall
        alpha = (wallVector) * (position(iAgent,:)-walls(iCorner,1:2))';
        % - Determine which distance to use (where the projection of the
        %   agent positon on the wall segment is)
        if (alpha < 0) % outside wall (on first corner side)
          distance = norm( position(iAgent,:) - walls(iCorner,1:2) );
          normalDirection = (position(iAgent,:) - walls(iCorner,1:2))./distance;
        elseif (alpha > wallLength) % outside wall (on second corner side)
          distance = norm( position(iAgent,:) - walls(iCorner+1,1:2) );
          normalDirection = (position(iAgent,:) - walls(iCorner+1,1:2))./distance;
        else % projection is ON the wall segment
          distance = ( position(iAgent,:) - walls(iCorner,1:2) ) * wallNormal';
          normalDirection = wallNormal;
        end
        
        tangentDirection = [-normalDirection(2), normalDirection(1)];
        
        % Calculate repulsion force
        repulsionForce(iCorner,:) = repulsionCoeff(iAgent) * exp((radiiSum-distance)/...
            repulsionExp(iAgent)) .* normalDirection;

        if (distance <= radiiSum) % Check for collision
          % Calculate body force
          bodyForce(iCorner,:) = bodyForceCoeff * (radiiSum - distance) .* ...
              normalDirection;

          % Calculate friction force
          relativeTangentialVelocity = (-velocity(iAgent,:)) * tangentDirection';
          frictionForce(iCorner,:) = frictionForceCoeff * (radiiSum - distance)...
              * relativeTangentialVelocity * tangentDirection;
        end
        
      end % End of interaction check
      
    end % End of wall loop
    
    wallForces(iAgent,:) = sum(repulsionForce,1) + sum(bodyForce,1) + ...
        sum(frictionForce,1);
    
  end
end