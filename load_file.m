function [X, Y] = load_file(filename, fm, category, labelDistribution)

% labelDistribution is an array which contains which word is in the file
% for how many time
% category - ['purdue', 'test', 'result'] & labelDistribution - [3,5,6] 
% means 'purdue' 3 times, 'test' 5 times and so on.


fileID = fopen(filename);
formatSpec = fm;
BiggerC = {};
BigC = [];

while ~feof(fileID)
    str = fgetl(fileID);                
    BigC = [];
    while strcmp(str,"####") ~= 1
        N = 1;          % read 1 line in each loop
        C = textscan(str,formatSpec,N,'Delimiter','');
        BigC = vertcat(BigC, cell2mat(C));      % changing cell array C to double array
        str = fgetl(fileID);                    % fgetl is very imp, reads line with new line
                                                % if using fgets (read line without new line), program
                                                % gives wrong output
    end
    BiggerC = vertcat(BiggerC, BigC.');
end

fclose(fileID);

X = BiggerC;
Y = [];

% disp(labelDistribution)
% disp(category)

i = 1;
while i <= size(labelDistribution,1)
    for j = 1:labelDistribution(i)
        Y = vertcat(Y, category(i));
    end
    i = i + 1;
end

Y = categorical(Y);