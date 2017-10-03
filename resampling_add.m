
% resampling
tempX = cell(size(X_total,1), 1);
for j = 1:size(X,1)
    temp = [];
    for i = 1:3
        temp = vertcat(temp, resample(X{j,1}(i,:), size(X_total{j,1}(i,:),2), size(X{j,1}(i,:),2) ));
    end
    tempX{j,1} = temp;
end

for i = 1: size(X_total,1)
    X_total{i,1} = vertcat(X_total{i,1}, tempX{i,1});
end


tempX = cell(size(XTest_total,1), 1);
for j = 1:size(XTest,1)
    temp = [];
    for i = 1:3
        temp = vertcat(temp, resample(XTest{j,1}(i,:), size(XTest_total{j,1}(i,:),2), size(XTest{j,1}(i,:),2) ));
    end
    tempX{j,1} = temp;
end

for i = 1: size(XTest_total,1)
    XTest_total{i,1} = vertcat(XTest_total{i,1}, tempX{i,1});
end
