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
      if ( logical(walls(iCorner,3)) && logical(walls((iCorner+1),3)) )
        
        % Compute wall from corners
        wallVector = walls( iCorner+1, 1:2 ) - walls( iCorner, 1:2 );
        wallLength = norm(wallVector);
        wallTangent = wallVector./wallLength; % Normalize
        wallNormal = [wallTangent(2), -wallTangent(1)];
        
        radiiSum = radius(iAgent); % Walls don't have thickness
        
        distance = ...
        abs((walls(iCorner+1,2)-walls(iCorner,2))*position(iAgent,1)...
          -(walls(iCorner+1,1)-walls(iCorner,1))*position(iAgent,2)...
          +walls(iCorner+1,1)*walls(iCorner,2)-walls(iCorner+1,2)*walls(iCorner,1))/...
          ((walls(iCorner+1,2)-walls(iCorner,2))^2 ...
          +(walls(iCorner+1,1)-walls(iCorner,1))^2)^0.5;
        
        perpPoint = position(iAgent,:) + distance*wallNormal;
        if norm(perpPoint-walls( iCorner+1, 1:2 )) + norm(perpPoint-walls( iCorner, 1:2 )) > wallLength
          a = (position(iAgent,:) - walls(iCorner,1:2));
          b = (position(iAgent,:) - walls(iCorner+1,1:2));
          if norm(a) < norm(b)
            distance = norm(a);
            normalDirection = (a)./distance;
          else 
            distance = norm(b);
            normalDirection = (b)./distance;
          end
        else 
          normalDirection = wallNormal;
        end
      
        
        tangentDirection = [-normalDirection(2), normalDirection(1)];
        
        % Calculate repulsion force
        repulsionForce(iCorner,:) = repulsionCoeff(iAgent) * exp((radiiSum-distance)/...
            repulsionExp(iAgent)) .* normalDirection;

%         if (distance <= radiiSum) % Check for collision
%           % Calculate body force
%           bodyForce(iCorner,:) = bodyForceCoeff * (radiiSum - distance) .* ...
%               normalDirection;
% 
%           % Calculate friction force
%           relativeTangentialVelocity = (-velocity(iAgent,:)) * tangentDirection';
%           frictionForce(iCorner,:) = frictionForceCoeff * (radiiSum - distance)...
%               * relativeTangentialVelocity * tangentDirection;
%         end
%         
      end % End of interaction check
      
    end % End of wall loop
    
    wallForces(iAgent,:) = sum(repulsionForce,1) + sum(bodyForce,1) + ...
        +sum(frictionForce,1);
    
  end
end
