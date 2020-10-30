function [values, colind, rowptr] = matrix_to_csr(A)
% A = matricea ce urmeaza a fi transformata
% values = vector cu valorile nenule din matricea A
% colind = vector cu indicii de coloana ale elementelor nenule din matrice
% rowptr = vector cu indicii de coloana ale primelor elementele nenule de pe 
%          fiecare linie a matricei

poz = 0;

% Numarul de valori nenule din matrice

nz = 0;

[n n] = size(A);

% Se parcurg elementele matricei A

for i = 1 : n
    is_first = 0;
    for j = 1 : n
        % Daca elementul este nenul atunci este adaugat in vectorul values, 
        % iar indicele de coloana al acestuia in vectorul colind
        if A(i, j) != 0
            nz++;
            values(nz) = A(i, j);
            colind(nz) = j;
            % Daca este primul element nenul de pe o linie atunci i se pastreaza 
            % indicele de coloana in vectorul rowptr
            if is_first == 0
                poz++;
                rowptr(poz) = nz;
                is_first = 1;
            end
        end
    end
end

% Se adauga pe ultima pozitie a vectorului rowptr nz(numarul de elemente nenule 
% din matrice) + 1

rowptr(poz + 1) = nz + 1;

end