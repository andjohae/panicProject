function socialAccMagnitude = SocialAccLinear(pairDistance)
  
  % Parameters
  linearSocialAccCoeff = 0.5;
  
  % Calculate magnitude of social force
  socialAccMagnitude = linearSocialAccCoeff ./ pairDistance;

end