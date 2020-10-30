function [G_J, c_J] = Jacobi_factorization(A, b)
% A = matricea sistemului
% b = vectorul de termeni liberi ai sistemului
% G_J = matricea de iteratie Jacobi
% c_J = vectorul de iteratie Jacobi

[n n] = size(A);

% Se separa matricea A in alte trei matrice:
% D = matrice diagonala
% L = matrice strict inferior triunghiulara
% U = matrice strict superior triunghiulara

x = diag(A);
D = diag(x);
L = tril(A,-1);
U = triu(A,1);

% Se calculeaza matricele N si P conform formulelor din curs/laborator/
% disponibile pe site-ul de curs

N = D;
P = - L - U;

% Se calculeaza matricea de iteratia Jacobi si vectorul de iteratie Jacobi 
% conform formulelor din curs/laborator/disponibile pe site-ul de curs

G_J = inv(N)*P;
c_J = inv(N) * b;

end
