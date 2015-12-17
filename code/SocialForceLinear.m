function socialForceMagnitude = SocialForceLinear(pairDistance)
  
  % Parameters
  linearSocialForceCoeff = 0.5;
  
  % Calculate magnitude of social force
  socialForceMagnitude = linearSocialForceCoeff ./ pairDistance;

end