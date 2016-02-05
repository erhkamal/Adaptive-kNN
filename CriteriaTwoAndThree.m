function [accuracy1, accuracy2, numberOfNeignbours, correctlyClassified2, correctlyClassified3] = CriteriaTwoAndThree(testSet, testLableSet, newSet, newLableSet, class1, class2)
correctClassification2 = 0;
wrongClassification2 = 0;
correctClassification3 = 0;
wrongClassification3 = 0;
[xTestSet, yTestSet] = size(testSet);
[xNewSet, yNewSet] = size(newSet);
accuracy1 = [];
accuracy2 = [];
volume = .2;
numberOfNeighbours =[];
correctlyClassified2 = [];
correctlyClassified3 = [];
while (volume < .6)
    correctClassification2 = 0;
    wrongClassification2 = 0;
    correctClassification3 = 0;
    wrongClassification3 = 0;
    for i = 1:xTestSet
        flag = 1;
        n = 1;
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
        while(flag ~= 0)
            difference = abs(sortedDistanceClass1(n) - sortedDistanceClass2(n));
            if(difference > volume)
                flag = 0;
            else
                n = n+1;
            end
            if n > 5000
                n=n-2;
                flag = 0;
            end
        end
        consevativeClass1 = 0;
        coservativeClass2 = 0;
        numberOfNeighbours = [numberOfNeighbours;n];
        if (sortedDistanceClass1(n) < sortedDistanceClass2(n))
            conservativeClass1 = sortedDistanceClass1(n+1);
            conservativeClass2 = sortedDistanceClass2(n);
            if testLableSet(i) == class1
                correctClassification2 = correctClassification2 + 1;
                correctlyClassified2 = [correctlyClassified2;n];
            else
                wrongClassification2 = wrongClassification2 + 1;
            end
        else
            conservativeClass1 = sortedDistanceClass1(n);
            conservativeClass2 = sortedDistanceClass2(n+1);
            if testLableSet(i) == class2
                correctClassification2 = correctClassification2 + 1;
                correctlyClassified2 = [correctlyClassified2;n];
            else
                wrongClassification2 = wrongClassification2 + 1;
            end
        end
        
        if(conservativeClass1 < conservativeClass2)
            if testLableSet(i) == class1
                correctClassification3 = correctClassification3 + 1;
                correctlyClassified3 = [correctlyClassified3;n];
            else
                wrongClassification3 = wrongClassification3 + 1;
                correctlyClassified3 = [correctlyClassified3;n];
            end
        else
            if testLableSet(i) == class2
                correctClassification3 = correctClassification3 + 1;
            else
                wrongClassification3 = wrongClassification3 + 1;
            end
        end
    end
    acc = correctClassification2/xTestSet;
    acc2 = correctClassification3/xTestSet;
    accuracy1 = [accuracy1;acc];
    accuracy2 = [accuracy2;acc2];
    volume = volume + 0.1;
end
end