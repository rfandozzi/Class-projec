%will begin to classify digit zero


num0=trainLabels==0;

reshaped2=zeros(784,24000);

%z scoring data to normalize which is a way that we decided to preprocess
%data that increased the accuratcy rate
means = mean(trainImages(:));  
std_dev = std(trainImages(:));


normalized = (trainImages - means) ./ std_dev;

images0=normalized(:,:,num0);
%reshape to a vector for normal image
reshaped=zeros(784,2393);
for n=1:2393
    image=images0(:,:,n);
    reshaped(:,n)=reshape(image,[784,1]);
   
end

for n=1:24000
    image2=normalized(:,:,n);
    reshaped2(:,n)=reshape(image2,[784,1]);
end



%will select features by using frequency to create a sim[ple binary weight
%matrix:
averagefreq0=zeros(784,1);

for row=1:784
    for column=1:2393
        if reshaped(row,column)~=0
            averagefreq0(row)=averagefreq0(row)+1;
        end
    end
    

end
binary=averagefreq0>=24;




fk=binary'*reshaped2;

%used the median of the values as my threshold for a fit
threshold = median(fk(num0));
classified0 = fk>threshold;



test=sum(classified0);
 
disp(test/24000*100);


%used these values to find the optimal weight to omptimize the
%classification accuracy rate
truepositives = sum(classified0(num0));
falsenegatives = sum(~classified0(num0));
falsepositives = sum(classified0(~num0));
truenegatives = sum(~classified0(~num0));

confusion_matrix = [truepositives, falsenegatives; falsepositives, truenegatives];
disp('conf matrix:');
disp(confusion_matrix);
disp('false negative %:');
disp(falsenegatives/24000*100);
disp('false positive %:');
disp(falsepositives/24000*100);
 