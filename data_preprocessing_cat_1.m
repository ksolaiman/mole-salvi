% DATA_PREPROCESSING 
% Step 1: Goes through the plugin data, separates each word
% with their start time and end time and saves them in words_by_time array.
% Step 2: Finds the categories and freq. of words
% Step 3: Separate train and test sensor data by the start and end time of
% a word

words_by_time=[];    % [word startTime endTime]   

% Step 1
i = 1;
while i <= size(plugin,1)
    word = "";
    startTime = plugin.time(i,1);
    while plugin.label(i,1) ~= ''     % when no letters are found by plugin
        word = strcat(word, plugin.label(i, 1));
        i= i+1;
    end
    
    % already read the gap, so the last letter of word was in index (i-1)
    endTime = plugin.time(i-1, 1);
    words_by_time = vertcat(words_by_time, [word startTime endTime]);
    
    % increase i to go to next letter, so the next word
    i = i+1;
end

save('dataset_1/data_1.mat', 'words_by_time', '-append');

% Getting the frequencies of each word in freq_by_cat, so we can divide the
% train, validation and test data
words_by_category = categorical(words_by_time(:,1), {'purdue', 'test', 'result'});
category = categories(words_by_category);
freq_by_cat = countcats(words_by_category);

% Step 2:
% data_size(:, 1) test data size and data_size(:, 2) is train data size
% row i depicts word i in category 
data_size = [ceil(freq_by_cat*0.25) (freq_by_cat-ceil(freq_by_cat*0.25)) ];

save('dataset_1/data_1.mat', 'words_by_category', 'category', 'freq_by_cat', 'data_size', '-append');

% Step 3:
% dividing respective sensor data to two files - train and test
% This is process 1 - look for the time closest to start time of word
% (i.e., purdue's p) and time closest to end time of word
% (i.e., purdue's e) and ignore the blank after that and use those sensor
% data as one input for 'purdue'
data_division_cat_1(acc, 'dataset_1/train_acc.txt', 'dataset_1/test_acc.txt', 'dataset_1/data_1.mat');
data_division_cat_1(gra, 'dataset_1/train_gra.txt', 'dataset_1/test_gra.txt', 'dataset_1/data_1.mat');
data_division_cat_1(gyro, 'dataset_1/train_gyro.txt', 'dataset_1/test_gyro.txt', 'dataset_1/data_1.mat');
data_division_cat_1(lin, 'dataset_1/train_lin.txt', 'dataset_1/test_lin.txt', 'dataset_1/data_1.mat');
data_division_cat_1(mag, 'dataset_1/train_mag.txt', 'dataset_1/test_mag.txt', 'dataset_1/data_1.mat');

