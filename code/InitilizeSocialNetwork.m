function correlationMatrix = InitilizeSocialNetwork(nAgents,correlationMatrix,...
  ratioBondsPerAgent)
  p = ratioBondsPerAgent;
%% CALCULATIONS
  d = round(p*nAgents);
  while sum(sum(correlationMatrix))/2 ~= d
   i = randi(nAgents,1,1);
   j = randi(nAgents,1,1);
    if i ~= j
      correlationMatrix(i,j) = 1;
      correlationMatrix(j,i) = 1;
    end
  end
end
