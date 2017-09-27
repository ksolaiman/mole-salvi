% get the sensor data from text file into variables
acc = importsensorfile('dataset_1/0_synced_10.186.6.43_2017-09-22_Sensor_acc.txt',';\t');
gra = importsensorfile('dataset_1/0_synced_10.186.6.43_2017-09-22_Sensor_gra.txt',';');
gyro = importsensorfile('dataset_1/0_synced_10.186.6.43_2017-09-22_Sensor_gyr.txt',';');
lin = importsensorfile('dataset_1/0_synced_10.186.6.43_2017-09-22_Sensor_lin.txt',';');
mag = importsensorfile('dataset_1/0_synced_10.186.6.43_2017-09-22_Sensor_mag.txt',';');

% For example, acc.X is a (n*1) array and others also

% get the plugin/label data from text file into variables
plugin = importlabelfile('dataset_1/0_synced_128.10.130.37_Plugin_2017-09-22-label.txt', [1,78,178], [70,172,356]);

% save sensor + plugin data
save('dataset_1/data_1.mat', 'acc','gra', 'gyro', 'lin', 'mag', 'plugin');