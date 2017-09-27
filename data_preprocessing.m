% DATA_PREPROCESSING 
% Step 1: Goes through the plugin data, separates each word
% with their start time and end time and saves them in words_by_time array.
% Step 2: 

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
words_by_category = categorical(words_by_time(:,1));
category = categories(words_by_category);
freq_by_cat = countcats(words_by_category);

save('dataset_1/data_1.mat', 'words_by_category', 'category', 'freq_by_cat', '-append');

% save('dataset_1/data_1.mat', 'plugin', '-append')
