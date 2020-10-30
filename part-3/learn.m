function [w] = learn(X, y)
% X = matricea de caracteristici
% y = vectorul coloana de etichete

[m n] = size(X);

% Se bordeaza matricea de caracteristiic cu 1 pe ultima coloana

X(:, n + 1) = 1;

% Se factorizeaza Householder matricea de caracteristici

[Q R] = Householder(X);

% Se rezolva sistemul de ecuatii folosind metoda substitutiei pe un sistem
% superior triunghiular 

eq = Q' * y;
w = SST(R, eq);
w = w';

end