function [A, b] = generate_probabilities_system(rows)
% rows = numarul de linii al diagramei
% A = matricea sistemului
% b = vectorul de termen liberi al sistemului

% sum_el = numarul de elemente din diagrama

x = 1 : rows;
x = x';
sum_el = sum(x);

% Se initializeaza matricea sistemului cu o matrice diagonala, avand valoarea 
% 6 pe aceasta

dia = ones(sum_el, 1) + 5;
A = diag(dia);

% Se initializeaza vectorul de termeni liberi cu 0

b = zeros(sum_el, 1);

% Se adauga in matricea sistemului valorile corespunzatoare varfurilor diagramei

vf = 1;
vf_s = sum_el - rows + 1;
vf_d = sum_el;

A(vf, vf + 1) = -1;
A(vf, vf + 2) = -1;

A(vf_s, vf_s + 1) = -1;
A(vf_s, vf_s - (vf_d - vf_s)) = -1;

A(vf_d, vf_d - 1) = -1;
A(vf_d, vf_d - rows) = -1;

A(vf_d - rows, vf_d) = -1;
A(vf_s - (vf_d - vf_s), vf_s) = -1;

A(vf, vf) = 4;
A(vf_s, vf_s) = 4;
A(vf_d, vf_d) = 4;

% Se adauga in vectorul de termeni liberi valorile corespunzatoare varfurilor
% inferioare ale diagramei

b(vf_d) = 1;
b(vf_s) = 1;

% Se adauga in matricea sistemului valorile corespunzatoare elementelor aflate
% intre varfurile inferioare ale diagramei = marginea inferioara

% Se adauga in vectorul de termeni liberi 1 pentru toate elementele aflate pe 
% marginea inferioara

for i = vf_s+1 : vf_d-1
    A(i, i) = 5;
    b(i) = 1;
    
    A(i, i-1) = -1;
    A(i, i + 1) = -1;
    
    A(i-1, i) = -1;
    A(i + 1, i) = -1;
    
    A(i, i - rows) = -1;
    A(i, i - rows +1) = -1;
    
    A(i - rows, i) = -1;
    A(i - rows +1, i) = -1; 
end

% Se adauga in matricea sistemului valorile corespunzatoare elementelor aflate
% pe marginile diagramei, intre varful superior si cele inferioare

step_s = 1;
step_d = 2;
s = 2;
d = 3;
while s < vf_s && d < vf_d
    A(s, s) = 5;
    A(d, d) = 5;
    
    A(s, s - step_s) = -1;
    A(d, d - step_d) = -1;
    
    A(s - step_s, s) = -1;
    A(d - step_d, d) = -1;
    
    A(s, s + 1) = -1;
    A(d, d - 1) = -1;
    
    step_s++;
    step_d++;
    s += step_s;
    d += step_d;
end

% Se adauga in matricea sistemului valorile corespunzatoare elementelor aflate
% in interiorul diagramei: marginite de varfuri, marginile laterale ale 
% diagramei si marginea inferioara

if rows > 2
    level = 3;
    i = 1;
    while i < vf_s - 1
        level_up = 0;
        while A(i, i) == 6
            A( i, i + 1) = -1;
            A( i, i - 1) = -1;
            
            A( i - 1, i) = -1;
            A( i + 1, i) = -1;
            
            A( i, i - level) = -1;
            A( i, i - level + 1) = -1;
            
            A(i - level, i) = -1;
            A(i - level + 1, i) = -1;
            
            A(i + level, i) = -1;
            A(i + level + 1, i) = -1;
            
            A( i, i + level) = -1;
            A( i, i + level + 1) = -1;
            
            i++;
            level_up = 1;
        end
        if level_up == 1
            level++;
        else
            i++;
        end
    end
end

end