% =========================================================================
% ATIVIDADE 1: Regressão Polinomial (Algoritmo de Mínimos Quadrados)
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais
x = linspace(0, 15, 100)';
e = 0.7 * rand(100, 1);
y = sin(x/1.5) + 0.1*x + e;
n = length(x);

graus = [1, 2, 4, 10];
cores = ['r', 'g', 'm', 'k'];

figure('Name', 'Ajuste Polinomial (Somatórios)', 'Position', [100, 100, 800, 600]);
scatter(x, y, 20, 'b', 'filled');
hold on; grid on;
legend_labels = {'Dados Originais'};

fprintf('--- Resultados da Atividade 1 (Sem metodos nativos) ---\n');

% 2. Loop principal para testar os diferentes graus de polinômio
for grau_idx = 1:length(graus)
    g = graus(grau_idx);
    m = g + 1;

    A = zeros(m, m);
    b = zeros(m, 1);

    % Montagem da matriz de somatórios (passo a passo)
    for i = 1:m
        k1 = i - 1;
        for j = 1:m
            potencia = (i - 1) + (j - 1);

            if i == 1 && j == 1
                A(i, j) = n;
            else
                s = 0;
                for k = 1:n
                    s = s + x(k)^potencia;
                end
                A(i, j) = s;
                A(j, i) = s;
            end
        end

        s = 0;
        if i == 1
            for k = 1:n
                s = s + y(k);
            end
        else
            for k = 1:n
                s = s + y(k) * (x(k)^k1);
            end
        end
        b(i) = s;
    end

    % =====================================================================
    % Solução do sistema linear usando a função Gauss com Pivoteamento
    % =====================================================================
    coeficientes = gauss_pivoteamento(A, b);

    % Cálculo dos valores preditos para traçar o gráfico
    y_ajuste = zeros(n, 1);
    for k = 1:n
        y_calc = 0;
        for c = 1:m
            y_calc = y_calc + coeficientes(c) * x(k)^(c-1);
        end
        y_ajuste(k) = y_calc;
    end

    % Cálculo do Coeficiente de Determinação (r^2)
    y_medio = mean(y);
    St = sum((y - y_medio).^2);
    Sr = sum((y - y_ajuste).^2);
    r2 = (St - Sr) / St;

    fprintf('Grau %d | r^2 = %.4f\n', g, r2);

    plot(x, y_ajuste, 'Color', cores(grau_idx), 'LineWidth', 2);
    legend_labels{end+1} = sprintf('Grau %d (r^2 = %.2f)', g, r2);
end

title('Regressão Polinomial (Algoritmo Explícito + Gauss Pivoteamento)');
xlabel('x'); ylabel('y');
legend(legend_labels, 'Location', 'northwest');
hold off;
