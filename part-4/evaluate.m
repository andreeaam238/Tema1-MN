function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
% path_to_testset = calea catre folderul care contine testele
% w = vectorul de parametri ai modelului
% histogram = tipul de histograma
% count_bins = numarul de valori pentru axa orizontala a histogramei
% percentage = procentajul de imagini clasificate corect

% Se stabilesc caile catre cele doua directoare cu imagini: cats, respectiv 
% not_cats

files = dir(path_to_testset);
names = {files.name};

dirFlags = [files.isdir] & ~strcmp(names, '.') & ~strcmp(names, '..');

subDirsNames = names(dirFlags);
subDirsNames = char(subDirsNames);

folders = strcat(path_to_testset, subDirsNames);
folders = strcat(folders, "/");

cats_folder = folders(1, :);
not_cats_folder = folders(2, :);

% Se salveaza calea catre imaginile din cele doua foldere in doua matrice: cats,
% respectiv not_cats

cats = getImgNames(cats_folder);
not_cats = getImgNames(not_cats_folder);
cats = strcat(cats_folder, cats);
not_cats = strcat(not_cats_folder, not_cats);

[m_c n_c] = size(cats);
[m_nc n_nc] = size(not_cats);

% Se calculeaza histogramele imaginilor si acestea sunt salvate intr-o matrice

if strcmp(histogram, 'RGB') == 1
    for i = 1 : m_c
        X(i, :) = rgbHistogram(cats(i, :), count_bins);
    end
    for i = 1 : m_nc
        X(m_c + i, :) = rgbHistogram(not_cats(i, :), count_bins);
    end
else
    for i = 1 : m_c
        X(i, :) = hsvHistogram(cats(i, :), count_bins);
    end
    for i = 1 : m_nc
        X(m_c + i, :) = hsvHistogram(not_cats(i, :), count_bins);
    end
end

[m n] = size(X);

% Se scaleaza matricea de caracteristici conform formulei din cerinta

mean_vals = mean(X);
std_err = std(X);
std_err = ones(m, 1) * std_err;
X(1:m, :) -= mean_vals;
X = X ./ std_err;

% Se bordeaza matricea de caracteristici cu 1 pe a n + 1 coloana

X(:, n + 1) = 1;

% Se initializeaza vectorul coloana de etichete cu 1 pentru imaginile cu pisici,
% respectiv -1 pentru cele fara pisici

y = zeros(m_c + m_nc, 1);
y(1 : m_c) = 1;
y((1 : m_nc) + m_c) = -1;

% Se initializeaza numarul de imagini clasificate corect cu 0

count = 0;

% Se verifica daca imaginea a fost clasificata corect, respectiv y(i) are
% acelasi semn cu produsul dintre linia i din X si vectorul de parametrii ai
% modelului

for i = 1 : m
    if y(i) == 1 && X(i, :) * w > 0
        count++;
    elseif y(i) == -1 && X(i, :) * w < 0
        count++;
    end
end

% Se calculeaza procentajul de imagini clasificate corect

percentage = count / (m_c + m_nc);

end