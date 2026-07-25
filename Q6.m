% =========================================================================
% RESOLUÇÃO DA QUESTÃO 6: Ajuste de Polinómio Cúbico (Grau 3)
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais da Tabela 6
x = [3, 4, 5, 7, 8, 9, 11, 12]';
y = [1.6, 3.6, 4.4, 3.4, 2.2, 2.8, 3.8, 4.6]';
n = length(x);

fprintf('--- RESOLUÇÃO DA QUESTÃO 6 ---\n\n');

% Configuração para polinómio de 3º grau
g = 3;
m = g + 1; % Número de coeficientes (a0, a1, a2, a3) -> m = 4

A = zeros(m, m);
b = zeros(m, 1);

% 2. Montagem da matriz de somatórios (Sistema de Equações Normais)
for i = 1:m
    k1 = i - 1;
    for j = 1:m
        potencia = (i - 1) + (j - 1);

        if i == 1 && j == 1
            A(i, j) = n;
        else
            % Utilizamos sum() do MATLAB para simplificar o cálculo do somatório
            A(i, j) = sum(x.^potencia);
        end
    end

    % Montagem do vetor de termos independentes
    if i == 1
        b(i) = sum(y);
    else
        b(i) = sum(y .* (x.^k1));
    end
end

% 3. Solução do sistema linear usando Gauss com Pivoteamento
coeficientes = gauss_pivoteamento(A, b);

fprintf('Coeficientes do Polinómio Cúbico:\n');
fprintf('  a0 = %.4f\n', coeficientes(1));
fprintf('  a1 = %.4f\n', coeficientes(2));
fprintf('  a2 = %.4f\n', coeficientes(3));
fprintf('  a3 = %.4f\n', coeficientes(4));
fprintf('\nEquação: y = %.4f + (%.4f)*x + (%.4f)*x^2 + (%.4f)*x^3\n\n', ...
        coeficientes(1), coeficientes(2), coeficientes(3), coeficientes(4));

% =========================================================================
% 4. Análise de Erros (r^2 e Sy/x)
% =========================================================================
y_ajuste = zeros(n, 1);
for k = 1:n
    y_calc = 0;
    for c = 1:m
        y_calc = y_calc + coeficientes(c) * x(k)^(c-1);
    end
    y_ajuste(k) = y_calc; % Valor previsto pelo modelo para cada ponto
end

y_medio = mean(y);

% St: Soma total dos quadrados (resíduos em relação à média)
St = sum((y - y_medio).^2);

% Sr: Soma dos quadrados dos resíduos (em relação ao ajuste)
Sr = sum((y - y_ajuste).^2);

% Coeficiente de Determinação (r^2)
r2 = (St - Sr) / St;

% Erro-padrão da estimativa (Sy/x)
% Graus de liberdade = n - (número de parâmetros), ou seja, n - m
Sy_x = sqrt(Sr / (n - m));

fprintf('Análise do Erro:\n');
fprintf('  Soma dos quadrados dos resíduos (Sr): %.4f\n', Sr);
fprintf('  Soma total dos quadrados (St): %.4f\n', St);
fprintf('  Coeficiente de Determinação (r^2): %.4f\n', r2);
fprintf('  Erro-padrão da estimativa (Sy/x): %.4f\n\n', Sy_x);

% =========================================================================
% 5. PLOTAGEM GRÁFICA
% =========================================================================
figure('Name', 'Q6 - Ajuste de Polinómio Cúbico', 'Position', [100, 100, 700, 500]);
scatter(x, y, 60, 'k', 'filled'); hold on; grid on;

% Criar pontos contínuos para desenhar a curva suavemente
x_plot = linspace(min(x)-1, max(x)+1, 100)';
y_plot = zeros(100, 1);
for k = 1:100
    y_calc = 0;
    for c = 1:m
        y_calc = y_calc + coeficientes(c) * x_plot(k)^(c-1);
    end
    y_plot(k) = y_calc;
end

plot(x_plot, y_plot, 'r-', 'LineWidth', 2);
title(sprintf('Ajuste Polinomial Cúbico (r^2 = %.4f | Sy/x = %.4f)', r2, Sy_x));
xlabel('Variável x'); ylabel('Variável y');
legend('Dados Experimentais', 'Ajuste Cúbico', 'Location', 'northeast');
hold off;
