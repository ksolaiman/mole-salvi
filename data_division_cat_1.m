function data_division_cat_1(sensor, train_file, test_file, data_file)

load(data_file);
delete(train_file);
delete(test_file);

wbt_size = 1;               % to keep track of the word_by_time array
for i = 1:size(category,1)
    fprintf("%s \n", string(category(i,1)));
    train_size = data_size(i,2);
    test_size = data_size(i,1);
    
    j = 1;
    while j <= train_size
        train_arr = [];
        % words_by_time(wbt_size, 2) --> start time of each word / 2nd
        % column;
        % end time of each word is in third column
        startTimeWord = double(words_by_time(wbt_size, 2));
        endTimeWord = double(words_by_time(wbt_size, 3));
        % sensor.time(:, 1) --> sensorleration sensor time column;
        [startTime, startTimeIndex] = min(abs( startTimeWord - sensor.time(:, 1)));
        [endTime, endTimeIndex] = min(abs( endTimeWord - sensor.time(:, 1)));
        
        while(startTimeIndex <= endTimeIndex)
            train_arr = vertcat(train_arr, [sensor.X(startTimeIndex,1) sensor.Y(startTimeIndex,1) sensor.Z(startTimeIndex,1) ]);
            startTimeIndex = startTimeIndex + 1;
        end
        
        % write train_arr to the train file
        fileID = fopen(train_file,'a');
        fprintf(fileID, "%f %f %f\n", train_arr);
        % insert a gap in the train file after each word's one sensor data
        fprintf(fileID, "####\n");
        fclose(fileID);
        
        j = j + 1;              % increment to depict one train data read
        wbt_size = wbt_size + 1;% increment to advance word in the words_by_time file
    end
    
    k = 1;
    while k <= test_size
        test_arr = [];
        % words_by_time(wbt_size, 2) --> start time of each word / 2nd
        % column;
        % end time of each word is in third column
        startTimeWord = double(words_by_time(wbt_size, 2));
        endTimeWord = double(words_by_time(wbt_size, 3));
        % sensor.time(:, 1) --> sensorleration sensor time column;
        [startTime, startTimeIndex] = min(abs( startTimeWord - sensor.time(:, 1)));
        [endTime, endTimeIndex] = min(abs( endTimeWord - sensor.time(:, 1)));
        
        while(startTimeIndex <= endTimeIndex)
            test_arr = vertcat(test_arr, [sensor.X(startTimeIndex,1) sensor.Y(startTimeIndex,1) sensor.Z(startTimeIndex,1)]);
            startTimeIndex = startTimeIndex + 1;
        end
        
        % write train_arr to the train file
        fileID = fopen(test_file,'a');
        fprintf(fileID, "%f %f %f\n", test_arr);
        % insert a gap in the train file after each word's one sensor data
        fprintf(fileID, "####\n");
        fclose(fileID);
        
        k = k + 1;
        wbt_size = wbt_size + 1;
    end
end



