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

% Se initializeaza numarul de imagini clasificate corect cu 0, si a cata coloana
% trebuie bordata cu 1

count = 0;
max_col = 3 * count_bins + 1;

% Se calculeaza histogramele imaginilor, iar matricea rezultata se bodeaza cu 1
% pe a max_col coloana

% Se verifica daca imaginea a fost clasificata corect, respectiv produsul dintre
% w si matricea bordata este 1 pentru imagini cu pisici si -1 pentru imagini 
% fara pisici

if strcmp(histogram, 'RGB') == 1
    for i = 1 : m_c
        X = rgbHistogram(cats(i, :), count_bins);
        X(1, max_col) = 1;
        if w * X' > 0
            count++;
        end
    end
    for i = 1 : m_nc
        X = rgbHistogram(not_cats(i, :), count_bins);
        X(1, max_col) = 1;
        if w * X' < 0
            count++;
        end
    end
else
    for i = 1 : m_c
        X = hsvHistogram(cats(i, :), count_bins);
        X(1, max_col) = 1;
        
        if w * X' > 0
            count++;
        end
    end
    for i = 1 : m_nc
        X = hsvHistogram(not_cats(i, :), count_bins);
        X(1, max_col) = 1;
        
        if w * X' < 0
            count++;
        end
    end
end

% Se calculeaza procentajul de imagini clasificate corect

percentage = count / (m_c + m_nc);

end