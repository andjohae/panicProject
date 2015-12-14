function walls = WallGeneration(roomSize,doorWidth,openingLength)
  openingLower = (roomSize(2)-doorWidth)/2;
  openingUpper = roomSize(2)-openingLower;
  walls = [roomSize(1)+openingLength 0;roomSize(1)+openingLength openingLower;roomSize(1) openingLower;roomSize(1) 0;0 0; 0 roomSize(2);...
  roomSize(1) roomSize(2);roomSize(1) openingUpper;roomSize(1)+openingLength openingUpper;roomSize(1)+openingLength roomSize(2)];
  importantPoints = [0 0 1 1 1 1 1 1 0 0]';
  walls = [walls(:,1) walls(:,2) importantPoints];
end
