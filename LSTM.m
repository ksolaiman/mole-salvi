function [net, accuracy] = LSTM(X, Y, XTest, YTest, ipSize, nClass, miniBatch)

% figure
% for i = 1:3
%    subplot(3,1,4-i)
%    plot(X{1}(i,:));
%    ylabel(i) 
%    xticklabels('')
%    yticklabels('')
%    box off
% end
% title("Training Observation 1")
% subplot(3,1,3)
% xticklabels('auto')
% xlabel("Time Step")


% Get the sequence lengths for each observation.
numObservations = numel(X);
for i=1:numObservations
    sequence = X{i};
    sequenceLengths(i) = size(sequence,2);
end

% Sort the data by sequence length.
[sequenceLengths,idx] = sort(sequenceLengths);
X = X(idx);
Y = Y(idx);

% View the sorted sequence lengths in a bar chart.
%  figure
%  bar(sequenceLengths)
%  ylim([0 100])
%  xlabel("Sequence")
%  ylabel("Length")
%  title("Sequence Lengths")

miniBatchSize = miniBatch;
miniBatchLocations = miniBatchSize+1:miniBatchSize:numObservations;
XLocations = repmat(miniBatchLocations,[2 1]);
YLocations = repmat([0;100],[1 3]);

% hold on
% line(XLocations,YLocations, ...
%         'Color','r', ...
%       'LineStyle','--')
    
    
% Define LSTM Network Architecture    
inputSize = ipSize;
outputSize = 100;
outputMode = 'last';
numClasses = nClass;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

% , 'BiasL2Factor', 2, 'InputWeightsL2Factor', 2, 'RecurrentWeightsL2Factor', 2

% specify the training options
maxEpochs = 150;
miniBatchSize = miniBatch;
shuffle = 'never';

options = trainingOptions('sgdm', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Plots','training-progress', ...
    'Shuffle', shuffle);

%     'L2Regularization',0.0005, ...
%     'OutputFcn',@(info)stopIfAccuracyNotImproving(info,3), ...

% Train LSTM Network
net = trainNetwork(X,Y,layers,options);




% Sort the test data by sequence length.
numObservationsTest = numel(XTest);
for i=1:numObservationsTest
    sequence = XTest{i};
    sequenceLengthsTest(i) = size(sequence,2);
end
[sequenceLengthsTest,idx] = sort(sequenceLengthsTest);
XTest = XTest(idx);
YTest = YTest(idx);

% Classify the test data
miniBatchSize = miniBatch;
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize);

% Calculate the classification accuracy of the predictions.
accuracy = sum(YPred == YTest)./numel(YTest)