function [x] = SST(A, b)
% A = matricea sistemului superior triunghiular
% b = vectorul de termeni liberi al sistemului
% x = vectorul de solutii

% Algoritmul este cel din curs/laborator/disponibil pe site-ul de curs

n = size(A, 2);

% Se initializeaza vectorul de solutii cu 0

x = zeros(n, 1);

% Se obtine solutia sistemului prin substitutie inapoi

for i = n : -1 : 1
    x(i) = (b(i) - A(i,i + 1 : n) * x(i + 1 : n)) / A(i, i);
end

end