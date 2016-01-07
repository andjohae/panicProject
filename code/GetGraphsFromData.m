function [] =  GetGraphsFromData(times,survivors,e)
%Assumes input in MATLAB format.
%load/save is good for that?

[nVel,leT] = size(times);

%Fix Data
for j = 1:nVel
  desiredVelocity = times(1,j);
  time = times(j,2:end);
  for i = 1:leT
    if time(i) == 0
      time(i) = [];
    end
  end
  
  %Total time plot
  figure(4)
  hold on
  if survivors(j) ==length(time)
    plot(desiredVelocity,time(end),'g*')
  else
    plot(desiredVelocity,time(end),'r*')
  end
  errorbar(time(end),e(j,end));
  %text(desiredVelocity,time(end),num2str(survivors(j)))
  
  %Mean time plot
  figure(5)
  hold on
  if survivors(j) ==length(time)
    plot(desiredVelocity,sum(time)/length(time),'g*')
  else
    plot(desiredVelocity,sum(time)/length(time),'r*')
  end
  errorbar(sum(time)/length(time),sum(e(j,2:end))/length(e(j,2:end)));
  %text(desiredVelocity,sum(time)/length(time),num2str(survivors(j)))
  
  %Label
  figure(4)
  xlabel('Desiered Velocity v_0 [m/s]');
  ylabel('Total Escape Time [t]');
  label('Number of Survivors');
  grid on;
  figure(5)
  xlabel('Desiered Velocity v_0 [m/s]');
  ylabel('Mean Escape Time [t]');
  label('Number of Survivors');
  grid on;
  hold off
end
