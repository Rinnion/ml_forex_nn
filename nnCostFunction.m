function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% Part1: cost function
yy = y == repmat( 1:num_labels, m, 1);

Xb = [ones(size(X,1),1),X];
A1 = sigmoid(Xb*Theta1');
A1b = [ones(size(A1,1),1),A1];
A2 = sigmoid(A1b*Theta2');

%J w/o regularezation
Jwr=(1/m)*sum(sum(-yy.*log(A2)-(1-yy).*log(1-A2)));

RL = sum(sum(Theta1(:,2:(input_layer_size+1)).^2));
RR = sum(sum(Theta2(:,2:(hidden_layer_size+1)).^2));
R=(lambda/(2*m))*(RL+RR);

J=Jwr+R;

% Part2: backpropagation

Delta1 = zeros(1,size(Theta1,2));
Delta2 = zeros(1,size(Theta2,2));
for i=1:m
  % Step 1: forward propagation
  A1=X(i,:);
  Z2=[1,A1]*Theta1';
  A2=sigmoid(Z2);
  Z3=[1,A2]*Theta2';
  A3=sigmoid(Z3);
  
  % Step 2: delta calculation for output layer
  logical = (1:num_labels)==y(i);  
  delta3 = A3-logical;
  
  % Step 3: delta calculation for hidden layer
  % Note: Excluding the first column of Theta2 is because the hidden layer bias unit 
  % has no connection to the input layer - so we do not use backpropagation for it. 
  % See Figure 3 in ex4.pdf for a diagram showing this.
  % https://www.coursera.org/learn/machine-learning/discussions/all/threads/a8Kce_WxEeS16yIACyoj1Q
  delta2 = delta3*(Theta2(:,2:end)).*sigmoidGradient(Z2);
    
  % Step 4: Accumulate gradient
  Delta1 = Delta1 + delta2'*[1,A1];
  Delta2 = Delta2 + delta3'*[1,A2];   
endfor

Theta1_grad = Delta1/m;
Theta2_grad = Delta2/m;

Theta1_grad(:,2:end)=Theta1_grad(:,2:end) + (lambda/m)*Theta1(:,2:end);
Theta2_grad(:,2:end)=Theta2_grad(:,2:end) + (lambda/m)*Theta2(:,2:end);

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
