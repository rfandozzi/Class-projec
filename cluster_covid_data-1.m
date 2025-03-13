% Load data
load("COVIDbyCounty.mat");

% Preprocessing: Linear transformation of data and z-score normalization.
% We were not able to turn this into a linear transformation matrix for the
% competition, so we didn't
smoothedCovid=movmean(CNTY_COVID,5);
trimmedCovid=zeros(225,156);

for column=1:156
    rowMean=mean(smoothedCovid(:,column));
    rowStDev=std(smoothedCovid(:,column));
    for row=1:225
        normalizedRow=(smoothedCovid(row,column)-rowMean)/rowStDev;
        trimmedCovid(row,column)=normalizedRow;
    end
end

%Creating COVID rate data
covidRate=zeros(225,155);
for col=1:155
    rate=smoothedCovid(:,col+1)-smoothedCovid(:,col);
    covidRate(:,col)=rate;
end

%Separating data into training and testing (COVID data already sorted into
%states)

states=unique(CNTY_CENSUS.STNAME);
testingData=[];
testingDataRate=[];
testingFIPS=[];
trainingData = [];
trainingDataRate=[];
trainingFIPS=[];

for i=1:length(states)
index = find(ismember(CNTY_CENSUS.STNAME,string(states(i))));
indexrand = index(randperm(length(index))); 
indexforstate=indexrand(1:ceil(0.2*length(indexrand)));

curr = trimmedCovid(indexforstate,:);
currRate=covidRate(indexforstate,:);
currFIPS = CNTY_CENSUS.fips(indexforstate);

testingData=cat(1,testingData,curr);
testingDataRate=cat(1,testingDataRate,currRate);
testingFIPS=cat(1,testingFIPS,currFIPS);

notcurrindicies = setdiff(indexrand, indexforstate);

notcurr = trimmedCovid(notcurrindicies,:);
notcurrRate=covidRate(notcurrindicies,:);
notcurrFIPS=CNTY_CENSUS.fips((notcurrindicies));

trainingData=cat(1,trainingData,notcurr);
trainingDataRate=cat(1,trainingDataRate,notcurrRate);
trainingFIPS=cat(1,trainingFIPS,notcurrFIPS);

end
%FIPS for regular covid data and rate of covid are the same

%Sorting training/testing data into divisions
trainingDivisions=[];


for i=1:length(trainingFIPS)
findRow = find(ismember(CNTY_CENSUS.fips,trainingFIPS(i)));
trainingDivisions=cat(1,trainingDivisions,CNTY_CENSUS.DIVISION(findRow));

end


testingDivisions=[];

for i=1:length(testingFIPS)
findRow = find(ismember(CNTY_CENSUS.fips,testingFIPS(i)));
testingDivisions=cat(1,testingDivisions,CNTY_CENSUS.DIVISION(findRow));

end


%kmeans 

[index,centroids]=kmeans(trainingData,22,'Replicates',10);
[indexRate,cRate]=kmeans(trainingDataRate,22,'Replicates',10);

%Sorting clusters to divisions
divisiontoCluster=cell(size(centroids,1),1);
divisiontoClusterRate=cell(size(centroids,1),1);

for clust = 1:size(centroids,1)
    clusterIndices=find(index == clust);  
    clusterIndicesRate=find(indexRate == clust);
    divisionforCluster = trainingDivisions(clusterIndices); 
    divisionforClusterRate = trainingDivisions(clusterIndicesRate);

    divisiontoCluster{clust} = divisionforCluster;
    divisiontoClusterRate{clust} = divisionforClusterRate;

end
%Sorting the normal covid data
divtoClusterReal=cell(size(centroids,1),1);


for clust=1:size(centroids,1)
    uniqueValues = unique(divisiontoCluster{clust});
    counts = histcounts(categorical(divisiontoCluster{clust}));
    [sortedCounts, sortedIndex] = sort(counts, 'descend');

    if isscalar(unique(divisiontoCluster{clust}))
        divtoClusterReal{clust}=uniqueValues;


    elseif length(uniqueValues) == 2
    divtoClusterReal{clust}=uniqueValues(sortedIndex(1:2));

    elseif length(uniqueValues)>=3

        divtoClusterReal{clust}=uniqueValues(sortedIndex(1:3));

    end
end

%Sorting the covid rate data
divtoClusterRateReal=cell(size(centroids,1),1);

for clust=1:size(centroids,1)
    uniqueValuesRate = unique(divisiontoClusterRate{clust});
    countsRate = histcounts(categorical(divisiontoClusterRate{clust}));
    [sortedCountsRate, sortedIndexRate] = sort(countsRate, 'descend');

    if isscalar(unique(divisiontoClusterRate{clust}))
        divtoClusterRateReal{clust}=uniqueValuesRate;


    elseif length(uniqueValuesRate) == 2

    divtoClusterRateReal{clust}=uniqueValuesRate(sortedIndexRate(1:2));

    elseif length(uniqueValuesRate)>=3
        divtoClusterRateReal{clust}=uniqueValuesRate(sortedIndexRate(1:3));

    end
end

%Even though this is not actually how we determined division for each
%county, this is a list of divisions associated with each cluster. In
%classify you will see the methods we discussed in the report and what we
%did to determine the division of each county

centroid_labels=zeros(size(centroids,1),1);

for clust=1:size(centroids,1)
    uniq=divtoClusterReal{clust};
    centroid_labels(clust,1)=uniq(1);
end

%The competition.mat file contains the 2 required files. The extra file
%contains the extra data we need for the classify file to run properly
save('competition.mat','centroids','centroid_labels');
save('extraForClassify.mat','divtoClusterReal','testingDivisions','divtoClusterRateReal')
