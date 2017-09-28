networks = [];
accuracies = [];
X_total = [];
XTest_total = [];

% Step 4:
% get the X & Y from each file
train_label_distribution = data_size(:,2);
test_label_distribution = data_size(:,1);
formatSpec = '%f %f %f';                    % change the format if you want to accomodate multiple sensors

% acc
[X, Y] = load_file('dataset_1/train_acc.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_acc.txt', formatSpec, category, test_label_distribution);
X_total = horzcat(X_total, X);
XTest_total = horzcat(XTest_total, XTest);

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

% gravity sensor
[X, Y] = load_file('dataset_1/train_gra.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_gra.txt', formatSpec, category, test_label_distribution);
X_total = horzcat(X_total, X);
XTest_total = horzcat(XTest_total, XTest);


[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

% gyrometer sensor
[X, Y] = load_file('dataset_1/train_gyro.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_gyro.txt', formatSpec, category, test_label_distribution);
X_total = horzcat(X_total, X);
XTest_total = horzcat(XTest_total, XTest);

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

% linear sensor
[X, Y] = load_file('dataset_1/train_lin.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_lin.txt', formatSpec, category, test_label_distribution);
X_total = horzcat(X_total, X);
XTest_total = horzcat(XTest_total, XTest);


[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

% magnetic sensor
[X, Y] = load_file('dataset_1/train_mag.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_mag.txt', formatSpec, category, test_label_distribution);
X_total = horzcat(X_total, X);
XTest_total = horzcat(XTest_total, XTest);

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);


% total
%[net, accuracy] = LSTM(X_total, Y, XTest_total, YTest, 15, 3, 10);
% networks = vertcat(networks, net);
% accuracies = vertcat(accuracies, accuracy);

save('dataset_1/result_1.mat', 'networks', 'accuracies');