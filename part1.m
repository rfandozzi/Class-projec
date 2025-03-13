%part i, graphing digits
for i=0:9
num=testLabels==i;
images=testImages(:,:,num);
figure;
    for j = 1:9
        subplot(3, 3, j);
        imagesc(images(:, :, j));
        colormap gray;
        axis off;
    end
    sgtitle(['Digit ', num2str(i)]);
end

%part ii reshaping images from matrix to vector

reshaped=zeros(784,8000);
for n=1:8000
    image=trainImages(:,:,n);
    reshaped(:,n)=reshape(image,[784,1]);
end

%part iii least sqaures with N=1000
N=1000;

indices = randperm(size(reshaped, 2), N);
X = reshaped(:, indices);      
Y = trainLabels(indices);
w=pinv(X')*Y;

prediction=X'*w;

predictedLabels=round(prediction);

predictedLabels(predictedLabels < 0) = 0;
predictedLabels(predictedLabels > 9) = 9;

confusion_matrix = confusionmat(trainLabels(1:N,1), predictedLabels);

disp('Confusion Matrix:');
disp(confusion_matrix);

accuracy = sum(predictedLabels == trainLabels(1:N,1)) / length(trainLabels);
disp(['Accuracy: ', num2str(accuracy * 100), '%']);

%as we increased N, the overall accuracy rate increased and the opposite
%happened when we decreased N. On the confusion matrix, we saw lots of
%error between 7 and 2, 8 and 4, and 3 and 2
