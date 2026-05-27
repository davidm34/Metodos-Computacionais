% =========================================================================
% ATIVIDADE 2: Regressão Linear Múltipla (Algoritmo de Somatórios)
% Modelo: y = a0 + a1*x1 + a2*x2
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais
x1 = [0; 2; 2.5; 1; 4; 7];
x2 = [0; 1; 2; 3; 6; 2];
y  = [5; 10; 9; 0; 3; 27];
n  = length(y); % Quantidade de pontos da amostra

% 2. Inicialização dos acumuladores (Somatórios)
soma_x1 = 0; soma_x2 = 0; soma_y = 0;
soma_x1_quad = 0; soma_x2_quad = 0;
soma_x1_x2 = 0;
soma_x1_y = 0; soma_x2_y = 0;

% 3. Cálculo de todos os somatórios iterativamente (Passo a passo)
for k = 1:n
    soma_x1 = soma_x1 + x1(k);
    soma_x2 = soma_x2 + x2(k);
    soma_y  = soma_y  + y(k);

    soma_x1_quad = soma_x1_quad + x1(k)^2;
    soma_x2_quad = soma_x2_quad + x2(k)^2;

    soma_x1_x2 = soma_x1_x2 + (x1(k) * x2(k));

    soma_x1_y = soma_x1_y + (x1(k) * y(k));
    soma_x2_y = soma_x2_y + (x2(k) * y(k));
end

% 4. Formação do sistema de equações (Matriz A e vetor B)
% Seguindo a estrutura genérica da matriz para regressão múltipla
A = zeros(3, 3);
A(1,1) = n;          A(1,2) = soma_x1;      A(1,3) = soma_x2;
A(2,1) = soma_x1;    A(2,2) = soma_x1_quad; A(2,3) = soma_x1_x2;
A(3,1) = soma_x2;    A(3,2) = soma_x1_x2;   A(3,3) = soma_x2_quad;

b = zeros(3, 1);
b(1) = soma_y;
b(2) = soma_x1_y;
b(3) = soma_x2_y;

% Exibindo os valores para conferência com o PDF
fprintf('Matriz de Somatórios (A):\n'); disp(A);
fprintf('Vetor de Produtos (b):\n'); disp(b);

% 5. Solução do sistema linear
coef = gauss_pivoteamento(A, b);
a0 = coef(1); a1 = coef(2); a2 = coef(3);

fprintf('Equação do Plano:\n y = %.4f + (%.4f)*x1 + (%.4f)*x2\n\n', a0, a1, a2);

% Análise de Erro (Coeficiente de Determinação R^2)
y_medio = soma_y / n;
St = 0; % Soma total dos quadrados
Sr = 0; % Soma dos quadrados dos resíduos

for k = 1:n
    % Calcula o y previsto pelo modelo para cada ponto
    y_previsto = a0 + a1*x1(k) + a2*x2(k);

    % Acumula os erros
    St = St + (y(k) - y_medio)^2;
    Sr = Sr + (y(k) - y_previsto)^2;
end

r2 = (St - Sr) / St;
fprintf('Analise de Qualidade do Ajuste:\n');
fprintf('Soma dos quadrados dos residuos (Sr) = %.4f\n', Sr);
fprintf('Coeficiente de Determinacao (r^2) = %.4f\n', r2);

% =========================================================================
% 6. Plotagem Gráfica
% =========================================================================
figure('Name', 'Regressão Múltipla - Mínimos Quadrados', 'Position', [100, 100, 700, 500]);
scatter3(x1, x2, y, 80, 'r', 'filled'); % Plota os pontos reais
hold on; grid on;

% Criação de uma malha para desenhar o plano
[X1_grid, X2_grid] = meshgrid(min(x1):0.5:max(x1), min(x2):0.5:max(x2));
Y_plano = a0 + a1*X1_grid + a2*X2_grid;

% Plota o plano translúcido
surf(X1_grid, X2_grid, Y_plano, 'FaceAlpha', 0.4, 'EdgeColor', 'none', 'FaceColor', 'b');

title(sprintf('Ajuste de Plano (r^2 = %.2f)', r2));
xlabel('Variavel x_1'); ylabel('Variavel x_2'); zlabel('Variavel y');
legend('Dados de Amostra', 'Plano Ajustado', 'Location', 'northeast');
view(-35, 25);
hold off;
