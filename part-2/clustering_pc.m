function centroids = clustering_pc(points, NC)
% points = matricea de coordonate a punctelor
% NC = numarul de clustere dorite
% centroids = centrele de masa ale clusterelor

[m n] = size(points);

% Se creeaza NC clustere conform regulei din cerinta

for i = 1 : NC
    col = 1;
    for j = i : NC : m
        clusters(i, col) = j;
        col++;
    end
    len(i) = col - 1;
end

% Se creeaza NC centroizi conform regulei din cerinta

centroids = zeros(1, n);

for i = 1 : NC
    indx = clusters(i, 1 : len(i));
    sum1 = sum(points(indx(1 : len(i)), 1 : n)) / len(i);
    centroids(i, 1 : n) = sum1;
end

% Stabilesc o toleranta

tol = 0.00001;

% Se repeta procedeul pana cand centrele de masa ale centroizilor nu se mai 
% modifica aproape deloc

while 1
    % Se initializeaza o lista cu NC puncte, goala
    % Astfel: point_list(i) corespunde lui points(i) si va pastra ulterior 
    % indexul centroidului in care va fi clasat
    point_list = zeros(1 : NC, 1 : n);
    
    % Se atribuie fiecarui punct din points cel mai aproapiat centroid folosind 
    % distanta euclidiana
    
    for i = 1 : m
        point = points(i, :);
        
        for j = 1 : NC
            centroid = centroids(j, :);
            dist(j) = norm(point - centroid);
        end
        
        [min_dist min_indx] = min(dist);
        point_list(i) = min_indx;
    end
    
    group_count = zeros(1, NC);
    
    prev_centroids = centroids;
    centroids = zeros(NC, n);
    
    % Se recalculeaza centrele de masa ale centroizilor 
    
    for i = 1 : m
        point = points(i, :);
        group = point_list(i);
        group_count(group) += 1;
        centroids(group, 1 : n) += point(1 : n);
    end
    
    for i = 1 : NC
        centroids(i, :) = centroids(i, :) / group_count(i);
    end
    
    % Se calculeaza eroarea
    
    err = norm(prev_centroids - centroids);
    if err < tol
        return;
    end
    
end


end