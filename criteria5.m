function [accuracy5, numberOfNeighbours5, CorrectlyClassified] = criteria5(testSet, testLableSet, newSet, newLableSet, class1, class2)
accuracy5 = [];
numberOfNeighbours5 = [];
CorrectlyClassified = []
[xTestSet, yTestSet] = size(testSet);
[xNewSet, yNewSet] = size(newSet);
for l = 4:7
    distanceForCriteria5 = l;
    correctClassification5 = 0;
    wrongClassification5 = 0;
    for i = 1:xTestSet
        distClass1 = [];
        distClass2 = [];
        test = testSet(i, :);
        for j = 1:xNewSet
            distanceset = [test; newSet(j, :)];
            distance = pdist(distanceset, 'euclidean');
            if newLableSet(j) == class1
                distClass1 = [distClass1;distance];
            else
                distClass2 = [distClass2;distance];
            end
        end
        sortedDistanceClass1 = sort(distClass1);
        sortedDistanceClass2 = sort(distClass2);
        n1 =1;
        n2 =1;
        while (sortedDistanceClass1(n1) <= distanceForCriteria5)
            n1 = n1 + 1;
        end
        while (sortedDistanceClass2(n2) <= distanceForCriteria5)
            n2 = n2 + 1;
        end
        
        sum = 0;
        numberOfNeighbours = n1 + n2 + 1;
        for m = 0:n1
            sum = sum + nchoosek(numberOfNeighbours, m);
        end
        
        probability = sum/(2^(numberOfNeighbours));
        
        if(probability >= 0.5)
            if testLableSet(i) == class1
                correctClassification5 = correctClassification5 + 1;
                CorrectlyClassified = [CorrectlyClassified;(n1+n2)];
            else
                wrongClassification5 = wrongClassification5 + 1;
            end
        else
            if testLableSet(i) == class2
                correctClassification5 = correctClassification5 + 1;
                CorrectlyClassified = [CorrectlyClassified;(n1+n2)];
            else
                wrongClassification5 = wrongClassification5 + 1;
            end
        end
        numberOfNeighbours5 = [numberOfNeighbours5; (n1 +n2)];
    end
    accuracy5 = [accuracy5; correctClassification5/2000];
end
end