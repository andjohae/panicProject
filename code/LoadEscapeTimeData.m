function [desiredSpeeds, escapeTimes] = LoadEscapeTimeData(nHeaderRows, delimiter)
  % Set default argument values
  if (nargin < 2)
    delimiter = '\t';
  end
  if (nargin < 1)
    nHeaderRows = 0;
  end

  % Get data folder
  dataDir = uigetdir('../data');
  if ~isdir(dataDir)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', dataDir);
    uiwait(warndlg(errorMessage));
    return;
  end
  
  % Read data files in folder
  files = dir(fullfile(dataDir,'*.txt'));
  nFiles = length(files);
  
  % Initialize matrices from first file
  % NOTE: Assumes that all files have same number of rows and columns
  firstFile = fullfile(dataDir, files(1).name);
  data = dlmread(firstFile,delimiter,nHeaderRows,0);
  
  nRows = size(data,1);
  nCols = size(data,2);
  
  desiredSpeeds = zeros(nRows,1,nFiles);
  escapeTimes = zeros(nRows,nCols-1,nFiles);
  
  desiredSpeeds(:,:,1) = data(:,1);
  escapeTimes(:,:,1) = data(:,2:end);
  
  % Parse rest of data files
  if (nFiles > 1)
    for iFile = 2:nFiles
      baseFileName = files(iFile).name;
      fullFileName = fullfile(dataDir, baseFileName);
      data = dlmread(fullFileName, delimiter, nHeaderRows, 0);
      
      desiredSpeeds(:,:,iFile) = data(:,1);
      escapeTimes(:,:,iFile) = data(:,2:end);
    end
  end
  
end