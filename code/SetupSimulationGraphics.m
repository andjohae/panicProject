% Setup Simulation Graphics

hFig1 = figure(1);
clf(hFig1);
set(hFig1,'Position',[800 400 500 500]);

hold on;
hWallPlot = plot(walls(:,1),walls(:,2),'LineWidth',2,'Color','k');
hTargetPlot = plot(targetPosition(1),targetPosition(2),'rx','MarkerSize',10);
hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
hAgentPlot = scatter(agents(:,PROPERTIES.Position(1)),agents(:,PROPERTIES.Position(2)),'filled');
hold off;

% Set agent colors
agentColors = ones(nAgents,1)*[0 0.4 1]; % Light blue
set(hAgentPlot,'CData',agentColors);

box on;
axis equal tight;
axis([-roomSize(1)*0.25 roomSize(1)*1.25 -roomSize(2)*0.25 roomSize(2)*1.25]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

% --- Adjust marker size for agents ---
% Get size of figure in 'Point' units
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);

radius = agents(:,PROPERTIES.Radius);
markerWidth = (2*radius)./diff(xlim).*axpos(3);
markerHeight = (2*radius)./diff(ylim).*axpos(4);
set(hAgentPlot, 'SizeData', markerWidth.*markerHeight);
% --- End of marker size adjustment ---

% Create time stamp for simulation
hTimeStamp = text(-0.25*roomSize(1), -0.35*roomSize(2), sprintf('Time: %d',0));
set(hTimeStamp, 'Interpreter','Latex','FontSize',14);

drawnow;