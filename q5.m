% =========================================================================
% RESOLUÇÃO DA QUESTÃO 5: Ajuste de Modelo de Potência
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais da Tabela 5 (Velocidade vs Força)
v = [10, 20, 30, 40, 50, 60, 70, 80];
F = [25, 70, 380, 550, 610, 1220, 830, 1450];
n = length(v);

fprintf('--- RESOLUÇÃO DA QUESTÃO 5 ---\n\n');

% =========================================================================
% 2. Transformação Logarítmica (Logaritmo Natural)
% Em MATLAB, a função 'log' calcula o logaritmo natural (base e)
% =========================================================================
X = log(v);
Y = log(F);

% =========================================================================
% 3. Regressão Linear nos Dados Transformados (Y = a1*X + a0)
% =========================================================================
sum_X = sum(X); sum_Y = sum(Y); sum_XY = sum(X .* Y); sum_X2 = sum(X .^ 2);
media_X = sum_X / n; media_Y = sum_Y / n;

% Coeficientes da reta linearizada
a1 = (n * sum_XY - sum_X * sum_Y) / (n * sum_X2 - sum_X^2); % Corresponde a beta
a0 = media_Y - a1 * media_X;                                % Corresponde a ln(alpha)

% =========================================================================
% 4. Retornar aos Parâmetros Originais do Modelo (F = alpha * v^beta)
% =========================================================================
beta = a1;
alpha = exp(a0);

fprintf('Modelo Linearizado: ln(F) = %.4f * ln(v) + %.4f\n', a1, a0);
fprintf('Parâmetros do Modelo de Potência:\n');
fprintf('  alpha = %.4f\n', alpha);
fprintf('  beta  = %.4f\n', beta);
fprintf('Equação Final: F = %.4f * v^(%.4f)\n\n', alpha, beta);

% =========================================================================
% 5. PLOTAGEM GRÁFICA
% =========================================================================
figure('Name', 'Q5 - Ajuste de Modelo de Potência', 'Position', [100, 100, 900, 400]);

% Gráfico 1: Dados Transformados (Reta)
subplot(1, 2, 1);
scatter(X, Y, 50, 'b', 'filled'); hold on; grid on;
X_plot = linspace(min(X)-0.2, max(X)+0.2, 100);
Y_plot = a1 * X_plot + a0;
plot(X_plot, Y_plot, 'r-', 'LineWidth', 2);
title('Dados Transformados (Linearização)');
xlabel('ln(v)'); ylabel('ln(F)');
legend('Dados Transformados', 'Ajuste Linear', 'Location', 'northwest');

% Gráfico 2: Dados Originais (Curva de Potência)
subplot(1, 2, 2);
scatter(v, F, 50, 'k', 'filled'); hold on; grid on;
v_plot = linspace(min(v)-5, max(v)+5, 100);
F_plot = alpha * (v_plot .^ beta);
plot(v_plot, F_plot, 'm-', 'LineWidth', 2);
title('Ajuste do Modelo de Potência (F vs v)');
xlabel('Velocidade v (m/s)'); ylabel('Força F (N)');
legend('Dados Originais', sprintf('F = %.2f v^{%.2f}', alpha, beta), 'Location', 'northwest');
