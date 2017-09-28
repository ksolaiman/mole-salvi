fileID = fopen('dataset_1/train.txt');
X = textscan(fileID,'%s', 'delimiter', ';','EndOfLine', '\r\n', 'CollectOutput', false);
fclose(fileID);

% load train.txt