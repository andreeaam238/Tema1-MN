function [sol] = rgbHistogram(path_to_image, count_bins)
% path_to_image = calea catre imagine
% count_bins = numarul de valori pentru axa orizontala a histogramei
% sol = histograma imaginii in format rgb

% Se citeste matricea imaginii

im = imread(path_to_image);

% Se stabilesc intervalele in care vor fi incadrati pixelii

lim = [0 : 256 / count_bins : 256];

% Se realizeaza histograma imaginii pe cele trei componenete, respectiv r, g si 
% b si se elimina ultimul element din fiecare

r = histc(im(:, :, 1)(:), lim);
g = histc(im(:, :, 2)(:), lim);
b = histc(im(:, :, 3)(:), lim);

r = r(1 : size(r) - 1)';
g = g(1 : size(g) - 1)';
b = b(1 : size(b) - 1)';

% Concatenez cele trei componente pentru a obtine histograma imaginii

sol = [r g b];

end
