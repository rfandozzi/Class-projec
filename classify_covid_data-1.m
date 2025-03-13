% Load data
load("COVIDbyCounty.mat");
load('competition.mat','centroids','centroid_labels');
load('extraForClassify.mat','divtoClusterReal','testingDivisions','divtoClusterRateReal')

%assigning testing data to clusters for regular covid data and covid rate
testingClusters = zeros(size(testingData, 1), 1);
testingClustersRate=zeros(size(testingData,1),1);
% assign it to the nearest centroid
for i = 1:size(testingData, 1)
    distances = pdist2(testingData(i, :), centroids,'cosine');
    [~, testingClusters(i)] = min(distances);
    distancesRate = pdist2(testingDataRate(i, :), cRate,'cosine');
    [~, testingClustersRate(i)] = min(distancesRate);
end
divNorm=cell(length(testingClusters),1);
divRate=cell(length(testingClusters),1);
for county=1:length(testingClusters)
    norm=divtoClusterReal{testingClusters(county)};
    rate=divtoClusterRateReal{testingClustersRate(county)};
    divNorm{county}=norm;
    divRate{county}=rate;
end


%sorting the divisions of the testing data
divisionSort=zeros(length(testingClusters),1);
for county=1:length(testingClusters)
    currRate=[];
    currNorm=[];
    if length(divtoClusterReal{testingClusters(county)}) == 1
    divisionSort(county) = divtoClusterReal{testingClusters(county)};
    elseif length(divtoClusterRateReal{testingClustersRate(county)})==1
        divisionSort(county)=divtoClusterRateReal{testingClustersRate(county)};
    else
   
    aNorm=divNorm{county};
    aRate=divRate{county};

    nNorm=length(aNorm);
    nRate=length(aRate);
pointsNorm=[];
pointsRate=[];
   if nNorm==1
    pointsNorm(1,1)=3;
   elseif nNorm==2
        pointsNorm(1,1)=3;
        pointsNorm(2,1)=2;
   elseif nNorm==3
       pointsNorm(1,1)=3;
        pointsNorm(2,1)=2;
        pointsNorm(3,1)=1;
   end

 if nRate==1
    pointsRate(1,1)=3;
   elseif nRate==2
        pointsRate(1,1)=3;
        pointsRate(2,1)=2;
   elseif nRate==3
       pointsRate(1,1)=3;
        pointsRate(2,1)=2;
        pointsRate(3,1)=1;
   end
   

    combine=[aNorm;aRate];

    pointsCombine=[pointsNorm;pointsRate];

    uniqueVal=unique(combine);

    totPoints=zeros(size(uniqueVal));
    for i=1:length(uniqueVal)
        indexUnique = find(ismember(uniqueVal(i),combine));
        totPoints(i)=sum(pointsCombine(indexUnique));

    end
    [maxPoints,pointIndex]=max(totPoints);
    
    mostFreqVal=uniqueVal(pointIndex);
    divisionSort(county)=mostFreqVal;
end
end



Jtest = testingDivisions == divisionSort; 
accuracyRateTesting = sum(Jtest) -0.5*size(centroids,1); 
disp(['Testing Accuracy Rate: ', num2str(accuracyRateTesting)]);
disp(sum(Jtest)/67)
