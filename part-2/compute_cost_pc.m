function cost = compute_cost_pc(points, centroids)
% points = matricea de coordonate a punctelor
% centroids = centrele de masa ale centroizilor
% cost = costul clustering-ului

[NC ~] = size(centroids);
[m n] = size(points);

% Se stabileste costul initial

cost = 0;

% Se stabileste costul clustering-ului pentru fiecare punct folosind distanta 
% euclidiana

% Costul trebuie sa fie minim, deci este luat drept cost pentru un punct 
% distanta euclidiana pana la cel mai apropiat centroid

% Costul total minim se obtine prin insumarea costurilor minime pentru fiecare 
% punct

for i = 1 : m
    point = points(i, :);
    for j = 1 : NC
        centroid = centroids(j, :);
        dist(j) = norm(point - centroid);
    end
    cost += min(dist);
end

end
