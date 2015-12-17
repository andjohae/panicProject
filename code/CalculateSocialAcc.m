function socialForces = CalculateSocialAcc(agents,PROPERTIES,socialCorrelations)

  % Read necessary properties
  position = agents(:,PROPERTIES.Position);
  
  % Initialization
  nAgents = size(agents,1);
  socialForces = zeros(nAgents,2);
      
  for iAgent = 1:nAgents
    % Use social correltion matrix to find indices of partners
    partners = socialCorrelations(iAgent,:).*(1:nAgents);
    partners(partners==0) = [];
    
    if ( ~isempty(partners) )
      nPartners = size(partners,2);
      
      for iPartner = 1:nPartners
        direction = position(iPartner,:) - position(iAgent,:);
        distance = norm(direction);
        unitDirection = direction ./ distance;

        % Plug in desired force model here
        socialForceMagnitude = SocialAccLinear(distance);

        socialForces(iAgent,:) = socialForces(iAgent,:) + ...
            socialForceMagnitude .* unitDirection;
      end
    end 
    
  end % End of agent loop

end