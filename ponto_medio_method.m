function [x, y] = ponto_medio_method(f, a, b, h, y0)
    x = a:h:b;
    n = length(x);
    y = zeros(1, n);
    y(1) = y0;
    for i = 1:(n-1)
        K1 = f(x(i), y(i));
        K2 = f(x(i) + h/2, y(i) + K1 * (h/2));
        y(i+1) = y(i) + K2 * h;
    end
end