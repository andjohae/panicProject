function walls=WallGeneration(roomSize,doorWidth,openingLength)
openingLower=(roomSize(2)-doorWidth)/2;
openingUpper=roomSize(2)-openingLower;
walls=[roomSize(1)+openingLength 0;roomSize(1)+openingLength openingLower;roomSize(1) openingLower;roomSize(1) 0;0 0; 0 roomSize(2);...
  roomSize(1) roomSize(2);roomSize(1) openingUpper;roomSize(1)+openingLength openingUpper;roomSize(1)+openingLength 1];
importantPoints=[0 1 1 1 1 1 1 1 1 0]';
walls=[walls(:,1) walls(:,2) importantPoints]
plot(walls(1:2,1),walls(1:2,2),'LineWidth',2);
axis([-roomSize(1)*0.25 roomSize(1)*1.25 -roomSize(2)*0.25 roomSize(2)*1.25])
end
