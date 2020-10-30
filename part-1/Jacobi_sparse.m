function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
% G_values = vector cu valorile nenule ale matricei de iteratie Jacobi
% G_colind = vector cu indicii de coloana ai elementelor nenule ale matricei de 
%            iteratie Jacobi
% G_rowptr = vector cu indicii de coloana ai primelor elemente nenule de pe 
%            fiecare linie a matricei de iteratie Jacobi
% c = vectorul de iteratie Jacobi
% tol = toleranta acceptata
  
[n] = length(G_rowptr);

% Se stabileste aproximatia initiala

prev_x = zeros(n - 1, 1);

% Cat timp eroarea este mai mare decat toleranta se repeta procedeul

while 1
    x = csr_multiplication(G_values, G_colind, G_rowptr, prev_x) + c;
    
    % Se calculeaza eroarea ca norma a diferentei dintre valoarea veche a 
    % vectorului solutie si cea noua 
    
    err = norm(x - prev_x);
    if err < tol
        return;
    end
    
    prev_x = x;
end

end