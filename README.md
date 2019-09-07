* Following commands should be run consecutively to execute the program - 

	- data_collection 
		* Go into the file and change the sensor & plugin file names
	- data_preprocessing_cat_1
	- Neural_net 
		* Few parameters will have to be changed in this file with the size of the data 
		or have to be tweaked for getting a better result, specifically in this line, 
		[net, accuracy] = LSTM(X, Y, XTest, YTest, 3, 3, 10)

* Output

	- Acclerometer 
	- Gravity 
	- Acclerometer + Gravity
	- Gyro
	- Linear
	- Magnetic
	- All together

* If you decide to use any one/two of the sensor only just comment that part in the code 
	they have header comments which one is which

* Must to maintain 

	- Your plugin data should start with a letter and end with a gap, 
		i.e., 'p', 'u', 'r', 'd', 'u', 'e', '','p', 'u', 'r', 'd', 'u', 'e', '', ........, 't','e','s','t', ''

	- Even if you have errors or typing mistakes in plugin data that is fine, 
		you can still fix them from the plugin variable which will be saved automatically
		as soon as you run data_collection.m

* Lackings

	- For some reason matlab does not have validation option for LSTM. Without validation
	data training data may overfit, so possible solution is to use many samples/ still looking.
