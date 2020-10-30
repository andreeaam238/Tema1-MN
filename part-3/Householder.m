function [Q, R] = Householder(A)
% A = matricea sistemului
% Q = matricea ortogonala
% R = matricea superior triunghiulara

% Algoritmul este cel din curs/laborator/disponibil pe site-ul de curs

[m n] = size(A);
Q = eye(m);

for p = 1 : min(m - 1, n)
    sigma = -norm(A(p : m, p));
    if A(p, p) < 0
        sigma = -sigma;
    end
    
    % Calculare reflector Householder
    vp(1 : m, 1) = 0;
    vp(p) = A(p, p) + sigma;
    vp(p + 1 : m) = A(p + 1 : m, p);
    
    beta = sigma * vp(p);
    
    if beta ~= 0
        % Transformare coloana p din Ap
        A(p, p) = -sigma;
        A(p + 1 : m, p) = 0;
        
        % Transformare coloanele p + 1 : n din Ap
        for j = p + 1 : n
            t = vp(p : m)' * A(p : m, j) / beta;
            A(p : m, j) = A(p : m, j) - t * vp(p : m);
        end
        
        % Transformare coloanele 1 : n din H
        for j = 1 : m
            t = vp(p : m)' * Q(p : m, j) / beta;
            Q(p : m, j) = Q(p : m, j) - t * vp(p : m);
        end
    end
end

R = A;
Q = Q';

endfunction