

% Load the data
load('COVID_STL.mat');

% initial guess of A (based on part 1)
A = [0.9979 0    0.0005    0; 
     0.0021 0.989 0.8428   0; 
     0     0.01   0.1567   0; 
     0     0.001    0      1];

x0 = [(POP_STL - cases_STL(68) - deaths_STL(68))/POP_STL;
           cases_STL(68)/POP_STL;
          (cases_STL(68) - deaths_STL(68))/POP_STL;
          deaths_STL(68)/POP_STL];


deltapropCases = cases_STL(1,68:84) / POP_STL;
deltapropDeaths = deaths_STL(1,68:84) / POP_STL;

% want to keep some values of A matrix 0 always
nonzero = A ~= 0;
params0 = A(nonzero);

% setting bounds between 0 and 1 for elements in A
lb = zeros(length(params0), 1);
ub = ones(length(params0), 1);

% makes sure columns sum to 1
Aeq_full = [
    1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1
];
Aeq = Aeq_full(:, nonzero(:) == 1); %only the nonzero values in A
beq = ones(4, 1); 

%autonomous for optimizaiton
objective = @(params) calculateErrorNonZero(params, nonzero, x0, deltapropCases, deltapropDeaths);


[params_opt, fval] = fmincon(objective, params0, [], [], Aeq, beq, lb, ub);

% reconstruct optimized A 
A_opt = A;  
A_opt(nonzero) = params_opt;


xopt = zeros(4, 16);
xopt(:, 1) = x0;
for i = 2:16
    xopt(:, i) = A_opt * xopt(:, i-1);
end


figure;
hold on;
plot(xopt(2,:));
plot(xopt(4,:));
plot(deltapropCases);
plot(deltapropDeaths);
legend('I','D','real cases','real deaths');
xlabel('time');
ylabel('percentage of population');
title('delta optimized model vs. real data');
hold off;



% uatonomous fxn to minimize square of the error in A
function error = calculateErrorNonZero(params, nonzero, x0, deltapropCases, deltapropDeaths)
    % reconstruct A
    A = zeros(4, 4);
    A(nonzero) = params;

   
    xfunction = zeros(4, 16);
    xfunction(:, 1) = x0;
    for i = 2:17
        xfunction(:, i) = A * xfunction(:, i-1);
    end

    model_cases = xfunction(2, :);
    model_deaths = xfunction(4, :);

    % sum of square errors
    error = sum((model_cases - deltapropCases).^2) + sum((model_deaths - deltapropDeaths).^2);
end




% initial guess of A (based on delta)
A = [0.9796 0    0.0473    0; 
     0.0204 0.7253 0.0937   0; 
     0     0.2745   0.8590   0; 
     0     0.0002    0      1];

x0 = [(POP_STL - cases_STL(85) - deaths_STL(85))/POP_STL;
           cases_STL(85)/POP_STL;
          (cases_STL(85) - deaths_STL(85))/POP_STL;
          deaths_STL(85)/POP_STL];


omipropCases = cases_STL(1,85:105) / POP_STL;
omiapropDeaths = deaths_STL(1,85:105) / POP_STL;

% want to keep some values of A matrix 0 always
nonzero = A ~= 0;
params0 = A(nonzero);

% setting bounds between 0 and 1 for elements in A
lb = zeros(length(params0), 1);
ub = ones(length(params0), 1);

% makes sure columns sum to 1
Aeq_full = [
    1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1
];
Aeq = Aeq_full(:, nonzero(:) == 1); %only the nonzero values in A
beq = ones(4, 1); 

%autonomous for optimizaiton
objective = @(params) calculateErrorNonZero1(params, nonzero, x0, omipropCases, omiapropDeaths);


[params_opt, fval] = fmincon(objective, params0, [], [], Aeq, beq, lb, ub);

% reconstruct optimized A 
A_opt = A;  
A_opt(nonzero) = params_opt;


xopt = zeros(4, 20);
xopt(:, 1) = x0;
for i = 2:20
    xopt(:, i) = A_opt * xopt(:, i-1);
end

figure;
hold on;
plot(xopt(2,:));
plot(xopt(4,:));
plot(omipropCases);
plot(omiapropDeaths);
legend('I','D','real cases','real deaths');
xlabel('time');
ylabel('percentage of population');
title('omicron optimized model vs. real data');
hold off;

% uatonomous fxn to minimize square of the error in A
function error = calculateErrorNonZero1(params, nonzero, x0, deltapropCases, deltapropDeaths)
    % reconstruct A
    A = zeros(4, 4);
    A(nonzero) = params;

   
    xfunction = zeros(4, 20);
    xfunction(:, 1) = x0;
    for i = 2:21
        xfunction(:, i) = A * xfunction(:, i-1);
    end

    model_cases = xfunction(2, :);
    model_deaths = xfunction(4, :);

    % sum of square errors
    error = sum((model_cases - deltapropCases).^2) + sum((model_deaths - deltapropDeaths).^2);
end
