%% Initialization
clear ; close all; clc


filename='eurusd60.csv';

[dow, tm, open, high, low, close]=load_ohlc_data_from_csv(filename);

actions = calculate_actions(close);

[mvg, mvgup, mvgdown] = bolling(close, 20)

figure(1);
plot(close);
hold on;
plot_action(close, actions(:,1), 'og')
plot_action(close, actions(:,3), 'or')

plot(mvg)
plot(mvgup)
plot(mvgdown)

hold off;



return
#������ ��������� �����

%% ��������� ������� ������
input_layer_size  = size(features_list, 2);   % ����������� ������� ���
hidden_layer_size = 25;                       % 25 ���������� ��������
num_labels = size (actions, 2);               % ���������� ��������� ��������

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

fprintf('\nTraining Neural Network... \n')

% ������������� ��������� �����������. ��������� ���������� ������� ������� 
% ����� �����
options = optimset('MaxIter', 200);

% ����������� ������ ��������
lambda = 0.5;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);