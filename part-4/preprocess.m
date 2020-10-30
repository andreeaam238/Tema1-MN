function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
% path_to_dataset = calea catre folderul care contine datele
% histogram = tipul de histograma
% count_bins = numarul de valori pentru axa orizontala a histogramei
% X = matricea de caracteristici
% y = vectorul coloana de etichete

% Se stabilesc caile catre cele doua directoare cu imagini: cats, respectiv 
% not_cats

files = dir(path_to_dataset);
names = {files.name};

dirFlags = [files.isdir] & ~strcmp(names, '.') & ~strcmp(names, '..');

subDirsNames = names(dirFlags);
subDirsNames = char(subDirsNames);

folders = strcat(path_to_dataset, subDirsNames);
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
        X(i + m_c, :) = rgbHistogram(not_cats(i, :), count_bins);
    end
else
    for i = 1 : m_c
        X(i, :) = hsvHistogram(cats(i, :), count_bins);
    end
    for i = 1 : m_nc
        X(i + m_c, :) = hsvHistogram(not_cats(i, :), count_bins);
    end
end

% Se initializeaza vectorul coloana de etichete cu 1 pentru imaginile cu pisici,
% respectiv -1 pentru cele fara pisici

y = zeros(m_c + m_nc, 1);
y(1 : m_c) = 1;
y((1 : m_nc) + m_c) = -1;

end
