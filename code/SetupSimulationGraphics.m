% Setup Simulation Graphics

hFig1 = figure(1);
clf(hFig1);

% agentArea = pi .* agents(:,PROPERTIES.Radius).^2;
%agentArea = (2 .* agents(:,PROPERTIES.Radius)).^2;

sizeAdjustment=agents(:,PROPERTIES.Radius).*1.28;


hold on;
hWallPlot = plot(walls(:,1),walls(:,2),'LineWidth',2,'Color','k');
hTargetPlot = plot(targetPosition(1),targetPosition(2),'rx','MarkerSize',10);
hSocialPlot = gplot(socialCorrelations ,agents(:,PROPERTIES.Position),'k-');
hAgentPlot = scatter(agents(:,PROPERTIES.Position(1)),agents(:,PROPERTIES.Position(2)),'filled');
%Oklar kod nedanför
currentunits = get(gca,'Units');
set(gca, 'Units', 'Points');
axpos = get(gca,'Position');
set(gca, 'Units', currentunits);
markerWidth = sizeAdjustment/diff(xlim)*axpos(3);
set(hAgentPlot, 'SizeData', markerWidth.^2)

hold off;

box on;
axis equal tight;
axis([-roomSize(1)*0.25 roomSize(1)*1.25 -roomSize(2)*0.25 roomSize(2)*1.25]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

hTimeStamp = text(-5, -7, sprintf('Time: %d',0));
set(hTimeStamp, 'Interpreter','Latex','FontSize',14);

drawnow;
