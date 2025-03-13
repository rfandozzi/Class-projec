load('mnistmodel.mat','means','std_dev','w');


function k = digitClassifierFxn(z, w, means, std_dev)

%preprocessing

%normalization using training mean and stdev
normalized = (z - means) / std_dev;

%winsorising values so no outliers exist (below -3 or above 3)
normalized(normalized > 3) = 3;
normalized(normalized < -3) = -3;



%used convolution to determine the edge boundaries both horizontally and
%vertically:

%these edge matricies were found online: Sobel operator
edgesX = [-1 0 1; -2 0 2; -1 0 1];
edgesY= [-1 -2 -1; 0 0 0; 1 2 1];



%combining the horixontal and vertical edges but squaring them and
%adding them so the values arent weird
edge_x = conv2(normalized, edgesX, 'same');
edge_y = conv2(normalized, edgesY, 'same');
edges = sqrt(edge_x.^2 + edge_y.^2);


%reshape and flatten images to vectors
flatRaw = reshape(normalized, 1, []); 
flatEdges = reshape(edges, 1, []);




%2 more features: pixel intensity and pixel requency over the whole image
intensity = mean(normalized, 'all');
frequency = sum(normalized(:) > 0);


%concatenating features vector
features = [flatRaw, flatEdges, intensity, frequency];



scores = features * w;
[~, k] = max(scores);  
k=k-1;

end
