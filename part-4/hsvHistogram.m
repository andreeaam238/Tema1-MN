function [sol] = hsvHistogram(path_to_image, count_bins)
% path_to_image = calea catre imagine
% count_bins = numarul de valori pentru axa orizontala a histogramei
% sol = histograma imaginii in format hsv

% Se citeste matricea imaginii

im = imread(path_to_image);

% Se face conversia imaginii din format rgb in format hsv

hsv = convert(im);

% Se stabilesc intervalele in care vor fi incadrati pixelii

lim = [0 : 1.01 / count_bins : 1.01];

% Se realizeaza histograma imaginii pe cele trei componenete, respectiv h, s si 
% v si se elimina ultimul element din fiecare

h = histc(hsv(:, :, 1)(:), lim);
s = histc(hsv(:, :, 2)(:), lim);
v = histc(hsv(:, :, 3)(:), lim);

h = h(1 : size(h) - 1)';
s = s(1 : size(s) - 1)';
v = v(1 : size(v) - 1)';

% Se concateneaza cele trei componente pentru a obtine histograma imaginii

sol = [h s v];

end