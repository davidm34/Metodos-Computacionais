t = [1, 2, 3.25, 4.5, 6, 7, 8, 8.5, 9, 10];
v = [5, 6, 5.5, 7, 8.5, 8, 6, 7, 7, 5];

% a) Trapezio para espacamento desigual (Distancia)
I3_trap = 0;
for i = 1:length(t)-1
    h_i = t(i+1) - t(i);
    I3_trap = I3_trap + h_i * (v(i) + v(i+1)) / 2;
end
v_media = I3_trap / (10 - 1);
fprintf('a) Distancia (Trapezio): %.4f m\n', I3_trap);
fprintf('   Velocidade media: %.4f m/s\n', v_media);

% b) Ajuste cubico
p = polyfit(t, v, 3);
P_int = polyint(p); % Integral do polinomio
I3_poly = polyval(P_int, 10) - polyval(P_int, 1);
fprintf('b) Distancia (Ajuste Cubico): %.4f m\n\n', I3_poly);
