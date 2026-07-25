clear; clc; close all;

% Parametros de entrada conforme especificado
a = 0;
b = 2;
h1 = 0.5;
h2 = 0.25;
y0 = 1;
f = @(t, y) y*t^3 - 1.5*y;


% Resolucao usando os metodos implementados
[x_eu1, y_eu1] = euler_method(f, a, b, h1, y0);
[x_eu2, y_eu2] = euler_method(f, a, b, h2, y0);
[x_pm, y_pm]   = ponto_medio_method(f, a, b, h1, y0);

disp('--- Evolucao da Solucao (h = 0.5) ---');
for i = 1:length(x_eu1)
    fprintf('x: %.2f | Eedoedouler: %.4f | PtMedio: %.4f\n', ...
        x_eu1(i), y_eu1(i), y_pm(i));
end

% Plotagem de todos os resultados no mesmo grafico
figure;
hold on;
plot(x_eu1, y_eu1, 'ro-', 'LineWidth', 1.5);
plot(x_eu2, y_eu2, 'bs--', 'LineWidth', 1.5);
plot(x_pm, y_pm, 'g^-', 'LineWidth', 1.5);
hold off;

legend('Euler (h=0.5)', 'Euler (h=0.25)', 'Ponto Médio (h=0.5)', 'Location', 'best');
xlabel('x');
ylabel('y');
title('Análise de EDO - Comparação de Métodos');
grid on;
