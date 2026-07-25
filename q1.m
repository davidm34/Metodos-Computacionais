% =========================================================================
% RESOLUÇÃO DA QUESTÃO 1: Regressão Polinomial (1ª a 3ª ordem)
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais da Tabela 1 (Altitude vs Gravidade)
x = [0; 30000; 60000; 90000; 120000];
y = [9.8100; 9.7487; 9.6879; 9.6278; 9.5682];
n = length(x);

% Altitude onde queremos estimar a gravidade
x_est = 55000;

% Graus exigidos: polinómios de 1ª a 3ª ordem
graus = [1, 2, 3];
cores = ['r', 'g', 'm'];

figure('Name', 'Q1 - Ajuste Polinomial da Gravidade', 'Position', [100, 100, 800, 600]);
scatter(x, y, 50, 'b', 'filled');
hold on; grid on;
legend_labels = {'Dados Originais (Tabela 1)'};

fprintf('--- Resolução da Questão 1 ---\n');

% 2. Loop principal para testar os graus 1, 2 e 3
for grau_idx = 1:length(graus)
    g = graus(grau_idx);
    m = g + 1; % Número de coeficientes do polinómio

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

        % Vetor de termos independentes
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
    % Solução do sistema linear usando a sua função Gauss com Pivoteamento
    % =====================================================================
    coeficientes = gauss_pivoteamento(A, b);

    % --- CÁLCULO DA ESTIMATIVA EM y = 55.000 m ---
    y_estimado = 0;
    for c = 1:m
        y_estimado = y_estimado + coeficientes(c) * (x_est^(c-1));
    end

    fprintf('Grau %d | Gravidade estimada em 55.000m = %.5f m/s^2\n', g, y_estimado);

    % Cálculo dos valores preditos para traçar a linha no gráfico
    x_plot = linspace(0, 120000, 100)';
    y_ajuste = zeros(100, 1);
    for k = 1:100
        y_calc = 0;
        for c = 1:m
            y_calc = y_calc + coeficientes(c) * x_plot(k)^(c-1);
        end
        y_ajuste(k) = y_calc;
    end

    plot(x_plot, y_ajuste, 'Color', cores(grau_idx), 'LineWidth', 1.5);
    legend_labels{end+1} = sprintf('Ajuste Grau %d', g);

    % Marca o ponto da estimativa no gráfico (uma estrela)
    scatter(x_est, y_estimado, 100, cores(grau_idx), 'p', 'filled');
    legend_labels{end+1} = sprintf('Estimativa Grau %d', g);
end

title('Regressão Polinomial: Gravidade vs Altitude');
xlabel('Altitude y (m)'); ylabel('Aceleração g (m/s^2)');
legend(legend_labels, 'Location', 'northeast');
hold off;
