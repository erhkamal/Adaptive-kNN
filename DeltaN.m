function [Accuracy, NumberOfNearestNeighbours, CorrectlyClassified] = DeltaN(testSet, testLableSet, newSet, newLableSet, class1, class2)
Accuracy =[];
[xTestSet, yTestSet] = size(testSet);
[xNewSet, yNewSet] = size(newSet);
n1 = 0;
n2 = 0;
NumberOfNearestNeighbours = [];
CorrectlyClassified = [];
for k = 1:3
    confidence = 1;
    correctClassification = 0;
    for i = 1:xTestSet
        flag = 1;
        distance = 1;
        while (flag ~= 0)
            n1 = 0;
            n2 = 0;
            test = testSet(i,:);
            for j = 1:xNewSet
                distanceset = [test; newSet(j, :)];
                dist = pdist(distanceset, 'euclidean');
                if(dist < distance)
                    if(newLableSet(j) == class1)
                        n1 = n1 + 1;
                    end
                    if(newLableSet(j) == class2)
                        n2 = n2 + 1;
                    end
                end
            end
            if(abs(n1 - n2) > confidence)
                flag = 0;
            else
                distance = distance +1;
            end
            if distance == 30
                flag =0;
            end
        end
        NumberOfNearestNeighbours = [NumberOfNearestNeighbours;(n1 + n2)];
        if(n1 > n2)            
            if testLableSet(i) == class1
                correctClassification = correctClassification + 1;
                CorrectlyClassified = [CorrectlyClassified;(n1 + n2)];
            end
        else
            
            if testLableSet(i) == class2
                correctClassification = correctClassification + 1;
                CorrectlyClassified = [CorrectlyClassified;(n1 + n2)];
            end
        end
    end
    acu = correctClassification/xTestSet;
    accuracy = [accuracy;acu];
end
end