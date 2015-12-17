function socialForces = CalculateSocialForces(agents,PROPERTIES,socialForceCoeff,...
    socialCorrelations)

  % Read necessary properties
  position = agents(:,PROPERTIES.Position);
  
  % Initialization
  nAgents = size(agents,1);
  socialForces = zeros(nAgents,2);
  
  % Use social correltion matrix to find indices of partners
  partnerAgents = socialCorrelations*(1:nAgents)';
      
  for iAgent = 1:nAgents
    iPartner = partnerAgents(iAgent);
    if (iPartner ~= 0) % iPartner == 0 means no partner assigned
      direction = position(iAgent,:) - position(iPartner,:);
      distance = norm(direction);
      unitDirection = direction ./ distance;
      
      % Plug in desired force model here
      socialForceMagnitude = SocialForceLinear(distance,socialForceCoeff);
      
      socialForces(iAgent) = socialForceMagnitude .* unitDirection;
    end
  end

end