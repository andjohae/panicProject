%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saves matrix 'data' to a .txt file with csv format %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SaveDataToFile(data, filename, header, timeBoolean)

  % Assign default arguments
  if (nargin < 5)
    timeBoolean = false;
  end
  if (nargin < 4)  
    header = sprintf('');
  end
  if (nargin < 2)
    filename = 'panic_data';
  end

  % Clear filename from filetype
  strParts = strsplit(filename,'.');
  filename = strParts{1};
  
  % Add time stamp
  if (timeBoolean)
    filename = strcat(filename,'_',datestr(now,'yyyy-mm-dd_HH:MM'),'.txt');
  end
  
  % Open file
  fileID = fopen(filename, 'w');
  
  % Print header if passed to function
  if (~isempty(header))
    fprintf(fileID, '%s\n', header);
  end
  
  % Print data to file
  nDataRows = size(data,1);
  for iRow = 1:nDataRows
    fprintf(fileID,'%g,',data(iRow,:));
    fprintf(fileID,'\n');
  end
  fclose(fileID);
  
end