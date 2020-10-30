function [hsv] = convert(im)
% im = matricea imaginii in format rgb
% hsv = matricea imaginii in format hsv

[m n p] = size(im);

% Sunt aduse valorile componentelor r, g si b in intervalul [0, 1]
    
r = double(im(:, :, 1)) / 255;
g = double(im(:, :, 2)) / 255;
b = double(im(:, :, 3)) / 255;

% Se concateneaza componentele r, g si b modificate
      
rgb = cat(p, r, g, b);

% Se determina valorile maxime, respectiv minime ale imaginii formate din
% componentele modificate

Cmin = min(rgb, [], p);
Cmax = max(rgb, [], p);
delta = Cmax - Cmin;

% Se calculeaza componentele h, s si v ale imaginii in format hsv
    
h = zeros(m, n);
            
indx = r == Cmax & delta != 0;
h(indx) = mod(((g - b)(indx) ./ delta(indx)), 6) / 6;
      
indx = g == Cmax & delta != 0;
h(indx) = ((b - r)(indx) ./ delta(indx) + 2) / 6;
    
indx = b == Cmax & delta != 0;                            
h(indx) = ((r - g)(indx) ./ delta(indx) + 4) / 6;
    
s = delta ./ Cmax;
v = Cmax;

% Se concateneaza elementele h, s si v pentru a obtine imaaginea in format hsv
    
hsv = cat(p, h, s, v);

end