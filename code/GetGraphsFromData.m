function [] =  GetGraphsFromData(times,e)
%Assumes input in MATLAB format.
%load/save is good for that?

[nVel,leT] = size(times);

%Fix Data
for j = 1:nVel
  desiredVelocity = times(j,1);
  time = times(j,2:end);
  for i = 1:length(time)
    if time(i) == 0
      time(i) = [];
      i = i - 1;
    end
  end
  
  %Total time plot
  figure(4)
  hold on
  if 1==1;%survivors(j) ==length(time)
    plot(desiredVelocity,time(end),'kx')
  else
    plot(desiredVelocity,time(end),'r*')
  end
  errorbar(desiredVelocity,time(end),e(j,end),'k');
  %text(desiredVelocity,time(end),num2str(survivors(j)))
  
  %Mean time plot
  figure(5)
  hold on
  if 1==1;%survivors(j) ==length(time)
    plot(desiredVelocity,sum(time)/length(time),'kx')
  else
    plot(desiredVelocity,sum(time)/length(time),'r*')
  end
  errorbar(desiredVelocity,sum(time)/length(time),sum(e(j,2:end))/length(e(j,2:end)),'k');
  %text(desiredVelocity,sum(time)/length(time),num2str(survivors(j)))
  
  %Label
  figure(4)
  xlabel('Desiered Velocity $v_0$ [m/s]','Interpreter','Latex','FontSize',14);
  ylabel('Total Escape Time [s]','Interpreter','Latex','FontSize',14);
  title('Total Escape Time for 51 Agents with fixed Desired Speed','Interpreter',...
    'Latex','FontSize',14);
  %label('Number of Survivors');
  grid on;
  figure(5)
  xlabel('Desiered Velocity $v_0$ [m/s]','Interpreter','Latex','FontSize',14);
  ylabel('Mean Escape Time [s]','Interpreter','Latex','FontSize',14);
  title('Mean Escape Time for 51 Agents with fixed Desired Speed','Interpreter',...
    'Latex','FontSize',14);

  %label('Number of Survivors');
  grid on;
  hold off
end
