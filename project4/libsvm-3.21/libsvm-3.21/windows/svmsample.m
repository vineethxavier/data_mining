load fisheriris
[~,~,labels] = unique(species);   %# labels: 1/2/3
data = zscore(meas);              %# scale features
numInst = size(data,1);
numLabels = max(labels);

%# split training/testing
idx = randperm(numInst);
numTrain = 100; numTest = numInst - numTrain;
trainData = data(idx(1:numTrain),:);  testData = data(idx(numTrain+1:end),:);
trainLabel = labels(idx(1:numTrain)); testLabel = labels(idx(numTrain+1:end));
%Here is my implementation for the one-against-all approach for multi-class SVM:

%# train one-against-all models
model = cell(numLabels,1);
for k=1:numLabels
    model{k} = svmtrain(double(trainLabel==k), trainData, '-c 1 -g 0.2 -b 1');
end