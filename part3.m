%load data
 load('mockdata.mat')

 deaths = zeros(1, 400);

% Compute daily deaths from cumulative deaths
for i = 2:400
    deaths(i) = cumulativeDeaths(i) - cumulativeDeaths(i - 1);
end


%pre vaccine rollout (assuming vaccines rolled out at 125 weeks)
A1 = [0.998  0    0.39    0 0 0; 
     0.002  0.6   0.06   0 0 0; 
     0     0.3998  0.55   0 0 0; 
     0     0.0002   0      1 0 0;
     0 0 0 0 0 0
     0 0 0 0 0 0
     ];

x01 = [1;0;0;0;0;0];

model = zeros(6, 400);
model(:, 1) = x01;
for i = 2:125
    model(:, i) = A1 * model(:, i-1);
end

%post vaccine rollout (assuming vaccines rolled out at 125 weeks)

A2 = [0.9454    0      0.001    0    0         0; 
     0.0041  0.99499  0.8423    0    0         0; 
       0       0.005   0.1567   0    0         0; 
       0     0.00001    0       1    0      0.000001;
     0.0505     0       0       0   0.999     0.8;
       0        0       0       0   0.001   0.199999];


for i = 126:400
    model(:, i) = A2* model(:, i-1);
end


 newcases = model(1, :) .* model(2, :) + model(3, :) .* model(2, :) + model(5, :) .* model(6, :);
vaxrate=A2(5,1)*100;
breakthrough=A2(6,5)*100;
disp(['Vaccination rate is ' num2str(vaxrate) '%']);
disp(['Breakthrough rate is ' num2str(breakthrough) '%']);
figure;
hold on;
plot(model(4,:));
plot(newInfections);
plot(deaths);
plot(newcases);
legend('model deaths','real cases','real deaths','model newcases');
xlabel('time');
ylabel('percentage of population');
title('optimized model vs. real data');
hold off;