function correlationMatrix = InitilizeSocialNetwork(agents,PROPERTIES,correlationMatrix,...
bondProbabilityPerAgent)
nAgents = length(agents);
p = bondProbabilityPerAgent/2;
r = rand(nAgents,nAgents);
%% CALCULATIONS
for i = 2:nAgents
  for j = 1:i-1
    if r(i,j) < p %&& i ~= j
      correlationMatrix(i,j) = 1;
      correlationMatrix(j,i) = 1;
    end
  end
end
%% PLOTTING TO BE DELETED
% figure
% hold on
% gplot(correlationMatrix,agents(:,PROPERTIES.Position),'k-');
% plot(agents(:,PROPERTIES.Position(:,1)),agents(:,PROPERTIES.Position(:,2)),'k.','MarkerSize',30);
% hold off
end
