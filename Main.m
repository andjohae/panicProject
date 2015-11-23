%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %Panic Project Main.m  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 

 %%%%%%%%%%%%%%%%%%%%%%%Initilize%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %CONSTANTS 
 nIndividuals = 10;
 maxVelocity = 1;%Remove??
 nTimeSteps = 10;
 roomSize = [10,10];
 %VECTORS 
 targetPositionVector = [1.5*roomSize(1),0.5*roomSize(2)];
  massVector = rand(1,nIndividuals);

 velocityVector = maxVelocity*rand(1,nIndividuals)
 %MATRICES  
 masterMatrix(1,:) = velocityVector;%
 masterMatrix(2,:) = massVector;%
 
 structor  = struct('rowIndexMass',2,...
     'rowIndexVelocity',1);
 %%%%%%%%%%%%%%%%%%%%%%%TimeLoop%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 for allTime = 1:nTimesteps
 
 end 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
