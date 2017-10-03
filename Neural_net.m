networks = [];
accuracies = [];

% Step 4:
% get the X & Y from each file
train_label_distribution = data_size(:,2);
test_label_distribution = data_size(:,1);
formatSpec = '%f %f %f';                    % change the format if you want to accomodate multiple sensors

% acc
[X, Y] = load_file('dataset_1/train_acc.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_acc.txt', formatSpec, category, test_label_distribution);

X_total = X;
XTest_total = XTest;


for i = 1: size(X_total,1)
   X_total{i,1} = X{i,1};
end

for i = 1: size(XTest_total,1)
   XTest_total{i,1} =  XTest{i,1};
end

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 5);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);


% gravity sensor
[X, Y] = load_file('dataset_1/train_gra.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_gra.txt', formatSpec, category, test_label_distribution);

for i = 1: size(X_total,1)
    X_total{i,1} = vertcat(X_total{i,1}, X{i,1});
end

for i = 1: size(XTest_total,1)
    XTest_total{i,1} = vertcat(XTest_total{i,1}, XTest{i,1});
end

X_total_interim = X_total;
XTest_total_interim = XTest_total;

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 5);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

%acclerometer + gravity
[net, accuracy] = LSTM(X_total, Y, XTest_total, YTest, 6, 3, 5);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

% gyrometer sensor
[X, Y] = load_file('dataset_1/train_gyro.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_gyro.txt', formatSpec, category, test_label_distribution);

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 5);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

resampling_add

% linear sensor
[X, Y] = load_file('dataset_1/train_lin.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_lin.txt', formatSpec, category, test_label_distribution);

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

resampling_add

% magnetic sensor
[X, Y] = load_file('dataset_1/train_mag.txt', formatSpec, category, train_label_distribution);
[XTest, YTest] = load_file('dataset_1/test_mag.txt', formatSpec, category, test_label_distribution);

[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

resampling_add


% total
[net, accuracy] = LSTM(X_total, Y, XTest_total, YTest, 15, 3, 10);
networks = vertcat(networks, net);
accuracies = vertcat(accuracies, accuracy);

save('dataset_1/result_1.mat', 'networks', 'accuracies', 'X_total', 'XTest_total');