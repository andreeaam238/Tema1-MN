function [w] = learn(X, y, lr, epochs)
% X = matricea de caracteristici
% y = vectorul coloana de etichete
% lr = rata de invatare
% epochs = numarul de epoci
% w = vectorul de parametri ai modelului
 
[m n] = size(X);

% Se scaleaza matricea de caracteristici conform formulei din cerinta

mean_vals = mean(X);
std_err = std(X);
std_err = ones(m, 1) * std_err;
X(1:m, :) -= mean_vals;
X = X ./ std_err;

% Se bordeaza matricea de caracteristici cu 1 pe a n + 1 coloana

X(:, n + 1) = 1;

% Se stabileste batch_size

batch_size = 64;

% Se initializeaza vectorul de parametri ai modelului cu valori random

w = zeros(n + 1, 1);
w = -0.1 + 0.2 * rand(n + 1, 1);

% Se repeta procedeul de epochs ori

for epoch = 1 : epochs
    
    % X_b si y_b sunt intializati cu batch_size linii random din X, respectiv y
    % Acestea sunt perechi 
    
    aux = randperm(m, batch_size);
    X_b = X(aux, :);
    y_b = y(aux);
     
    % Se calculeaza vectorul de parametri ai modelului 
    
    for i = 1 : n + 1
        aux_sum = X_b(1 : batch_size, :) * w;
        aux_sum = aux_sum - y_b(1 : batch_size);
        aux_sum = aux_sum .* X_b(1 : batch_size, i);
        aux_sum = sum(aux_sum);
        w(i) -= (lr / m) * aux_sum;
    end
end

end
