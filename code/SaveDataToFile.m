%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saves matrix 'data' to a .txt file with chosen format (tsv default) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SaveDataToFile(data, filename, header, delimiter, timeBoolean)

  % Assign default arguments
  if (nargin < 5)
    timeBoolean = false;
  end
  if (nargin < 4)
    delimiter = '\t';
  end
  if (nargin < 3)  
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
  
  % Print header if passed to function
  fileID = fopen(filename, 'w');
  if (~isempty(header))
    fprintf(fileID, '%s\n', sprintf(header));
  end
  fclose(fileID);
  
  % Write data to file
  dlmwrite(filename,data,'-append','delimiter',delimiter);

  fprintf('Successfully saved data to ''%s''\n',filename);
  
end