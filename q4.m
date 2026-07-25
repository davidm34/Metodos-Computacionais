% =========================================================================
% RESOLUÇÃO DA QUESTÃO 4: Regressão Linear (y vs x) e (x vs y)
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais da Tabela 4
x = [0, 2, 4, 6, 9, 11, 12, 15, 17, 19];
y = [5, 6, 7, 6, 9,  8,  8, 10, 12, 12];
n = length(x);

fprintf('--- RESOLUÇÃO DA QUESTÃO 4 ---\n\n');

% =========================================================================
% PARTE A: Regressão de Y em função de X (y = a1*x + a2)
% =========================================================================
fprintf('--- 1) Regressão de Y versus X (Modelo: y = a1*x + a2) ---\n');

sum_x = sum(x); sum_y = sum(y); sum_xy = sum(x .* y); sum_x2 = sum(x .^ 2);
media_x = sum_x / n; media_y = sum_y / n;

% Coeficientes
a1_yx = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x^2); % Inclinação
a2_yx = media_y - a1_yx * media_x;                             % Interseção

% Resíduos e Erros
St_yx = sum((y - media_y).^2);
Sr_yx = sum((y - (a1_yx .* x + a2_yx)).^2);
Syx_yx = sqrt(Sr_yx / (n - 2)); % Erro-padrão da estimativa
r2_yx = (St_yx - Sr_yx) / St_yx; % Coeficiente de determinação
r_yx = sign(a1_yx) * sqrt(r2_yx); % Coeficiente de correlação

fprintf('Inclinação (a1): %.4f\n', a1_yx);
fprintf('Interseção com o eixo y (a2): %.4f\n', a2_yx);
fprintf('Erro-padrão da estimativa (Sy/x): %.4f\n', Syx_yx);
fprintf('Coeficiente de correlação (r): %.4f\n', r_yx);
fprintf('Equação: y = %.4f*x + %.4f\n\n', a1_yx, a2_yx);


% =========================================================================
% PARTE B: Regressão de X em função de Y (x = b1*y + b2)
% =========================================================================
fprintf('--- 2) Regressão de X versus Y (Modelo: x = b1*y + b2) ---\n');

% Trocamos as variáveis nas fórmulas
sum_y2 = sum(y .^ 2);

% Coeficientes (agora Y é a variável independente)
b1_xy = (n * sum_xy - sum_x * sum_y) / (n * sum_y2 - sum_y^2); % Inclinação
b2_xy = media_x - b1_xy * media_y;                             % Interseção

% Resíduos e Erros (agora em relação a X)
St_xy = sum((x - media_x).^2);
Sr_xy = sum((x - (b1_xy .* y + b2_xy)).^2);
Syx_xy = sqrt(Sr_xy / (n - 2));
r2_xy = (St_xy - Sr_xy) / St_xy;
r_xy = sign(b1_xy) * sqrt(r2_xy);

fprintf('Inclinação (b1): %.4f\n', b1_xy);
fprintf('Interseção com o eixo x (b2): %.4f\n', b2_xy);
fprintf('Erro-padrão da estimativa (Sx/y): %.4f\n', Syx_xy);
fprintf('Coeficiente de correlação (r): %.4f\n', r_xy);
fprintf('Equação: x = %.4f*y + %.4f\n\n', b1_xy, b2_xy);


% =========================================================================
% 3. PLOTAGEM DOS GRÁFICOS
% =========================================================================
figure('Name', 'Q4 - Ajuste Linear', 'Position', [100, 100, 1000, 450]);

% Gráfico 1: Y vs X
subplot(1, 2, 1);
scatter(x, y, 50, 'b', 'filled'); hold on; grid on;
x_plot = linspace(min(x)-1, max(x)+1, 100);
y_plot = a1_yx * x_plot + a2_yx;
plot(x_plot, y_plot, 'r-', 'LineWidth', 2);
title('Regressão de y versus x');
xlabel('Variável Independente (x)'); ylabel('Variável Dependente (y)');
legend('Dados', sprintf('y = %.2fx + %.2f', a1_yx, a2_yx), 'Location', 'northwest');

% Gráfico 2: X vs Y
subplot(1, 2, 2);
scatter(y, x, 50, 'g', 'filled'); hold on; grid on;
y_plot2 = linspace(min(y)-1, max(y)+1, 100);
x_plot2 = b1_xy * y_plot2 + b2_xy;
plot(y_plot2, x_plot2, 'k-', 'LineWidth', 2);
title('Regressão de x versus y');
xlabel('Variável Independente (y)'); ylabel('Variável Dependente (x)');
legend('Dados', sprintf('x = %.2fy + %.2f', b1_xy, b2_xy), 'Location', 'northwest');
