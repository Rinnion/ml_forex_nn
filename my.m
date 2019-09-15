clear ; close all; clc

load ('ex5data1.mat');

% m = Number of examples
m = size(X, 1);

p = 8;

% Map X onto Polynomial Features and Normalize
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
X_poly = [ones(m, 1), X_poly];                   % Add Ones

% Map X_poly_test and normalize (using mu and sigma)
X_poly_test = polyFeatures(Xtest, p);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
X_poly_val = polyFeatures(Xval, p);
X_poly_val = bsxfun(@minus, X_poly_val, mu);
X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones


[lambda_vec, error_train, error_val] = ...
    validationCurve(X_poly, y, X_poly_val, yval)

close all;
plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');


[lambda_vec, error_train, error_val, error_test] = ...
    testCurve(X_poly_val, yval, X_poly, y, X_poly_test, ytest);

figure;
plot(lambda_vec, error_train, lambda_vec, error_val, lambda_vec, error_test);
legend('Train', 'Cross Validation', 'Test');
xlabel('lambda');
ylabel('Error');


