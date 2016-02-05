load('data_batch_1.mat');
X=[];
X=[data];
Y=[labels];

load('data_batch_2.mat');
X=[X;data];
Y=[Y;labels];

load('data_batch_3.mat');
X=[X;data];
Y=[Y;labels];

load('data_batch_4.mat');
X=[X;data];
Y=[Y;labels];

load('data_batch_5.mat');
X=[X;data];
Y=[Y;labels];

load('test_batch.mat');
X_Testing = data;
Y_Testing =labels;

X=double(X);
X=X';

X_Testing = double(X_Testing);
X_Testing = X_Testing';

[X,W]=FDA(X,Y);

X_Testing = W'*X_Testing;
Y = double(Y);
Y = Y';
[xTraining, yTraining] = size(X);
[xTesting, yTesting] = size(X_Testing);


totalAccuracy1 = [];
totalAccuracy2 = [];
totalAccuracy3 = [];
totalAccuracy4 = [];
totalCorrectlyClassified1 = [];
totalCorrectlyClassified2 = [];
totalCorrectlyClassified3 = [];

for class1 = 0:8
    for class2 = (class1+1):9
        newSet=[];
        newLableSet =[];
        
        for i = 1:yTraining
            if(Y(i) == class1 || Y(i) == class2)
                temp = X(:, i);
                temp = temp';
                newSet=[newSet;temp];
                newLableSet = [newLableSet;Y(i)];
            end
        end
        testSet = [];
        testLableSet = [];
        for j = 1:yTesting
            if(Y_Testing(j) == class1 || Y_Testing(j) == class2)
                temp1 = X_Testing(:, j);
                temp1 = temp1';
                testSet = [testSet;temp1];
                testLableSet = [testLableSet; Y_Testing(j)];
            end
        end
        [accuracy1, NumberOfNearestNeighbours1, correctlyClassified1] = DeltaN(testSet, testLableSet, newSet, newLableSet, class1, class2);
        totalAccuracy1 = [totalAccuracy1;accuracy1];
        totalCorrectlyClassified1 = [totalCorrectlyClassified1;correctlyClassified1];
        [accuracy2, accuracy3, numberOfNeignbours2, correctlyClassified2, correctlyClassified3] = CriteriaTwoAndThree(testSet, testLableSet, newSet, newLableSet, 0, 1);
        totalAccuracy2 = [totalAccuracy2;accuracy2];
        totalAccuracy3 = [totalAccuracy3;accuracy3];
        totalCorrectlyClassified2 = [totalCorrectlyClassified2;correctlyClassified2];
        totalCorrectlyClassified3 = [totalCorrectlyClassified3;correctlyClassified3];
        [accuracy5, numberOfNeighbours5] = criteria5(testSet, testLableSet, newSet, newLableSet, class1, class2);
        totalAccuracy5 = [totalAccuracy5;accuracy5];
    end
end