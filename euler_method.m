function [x, y] = euler_method(f, a, b, h, y0)
    x = a:h:b;
    n = length(x);
    y = zeros(1, n);
    y(1) = y0;
    for i = 1:(n-1)
        K1 = f(x(i), y(i));
        y(i+1) = y(i) + K1 * h;
    end
end
