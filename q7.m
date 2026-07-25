% =========================================================================
% RESOLUÇÃO DA QUESTÃO 7: Regressão Linear Múltipla
% Modelo: y = a0 + a1*x1 + a2*x2
% =========================================================================
clear; clc; close all;

% 1. Dados Iniciais da Tabela 7
x1 = [0; 1; 1; 2; 2; 3; 3; 4; 4];
x2 = [0; 1; 2; 1; 2; 1; 2; 1; 2];
y  = [15.1; 17.9; 12.7; 25.6; 20.5; 35.1; 29.7; 45.4; 40.2];
n  = length(y); % Quantidade de pontos (9)

fprintf('--- RESOLUÇÃO DA QUESTÃO 7 ---\n\n');

% =========================================================================
% 2. Montagem do Sistema de Equações Normais (A*coef = b)
% Utilizando as funções nativas do MATLAB (sum) para otimizar o código original
% =========================================================================
A = zeros(3, 3);
A(1,1) = n;          A(1,2) = sum(x1);      A(1,3) = sum(x2);
A(2,1) = sum(x1);    A(2,2) = sum(x1.^2);   A(2,3) = sum(x1.*x2);
A(3,1) = sum(x2);    A(3,2) = sum(x1.*x2);  A(3,3) = sum(x2.^2);

b = zeros(3, 1);
b(1) = sum(y);
b(2) = sum(x1.*y);
b(3) = sum(x2.*y);

% =========================================================================
% 3. Solução do sistema linear usando a sua função Gauss com Pivoteamento
% =========================================================================
coef = gauss_pivoteamento(A, b);

a0 = coef(1);
a1 = coef(2);
a2 = coef(3);

fprintf('Coeficientes da Regressão:\n');
fprintf(' a0 (Interseção) = %.4f\n', a0);
fprintf(' a1 (Inclinação x1) = %.4f\n', a1);
fprintf(' a2 (Inclinação x2) = %.4f\n\n', a2);
fprintf('Equação do Plano: y = %.4f + (%.4f)*x1 + (%.4f)*x2\n\n', a0, a1, a2);

% =========================================================================
% 4. Análise de Erros (Sy/x e R)
% =========================================================================
y_medio = mean(y);
St = 0; % Soma total dos quadrados
Sr = 0; % Soma dos quadrados dos resíduos

for k = 1:n
    % Calcula o y previsto pelo modelo para cada ponto
    y_previsto = a0 + a1*x1(k) + a2*x2(k);

    % Acumula os resíduos
    St = St + (y(k) - y_medio)^2;
    Sr = Sr + (y(k) - y_previsto)^2;
end

% Coeficiente de Determinação (r^2) e Coeficiente de Correlação (R)
r2 = (St - Sr) / St;
R = sqrt(r2);

% Erro-padrão da estimativa (Sy/x)
% Graus de liberdade = n - 3 (porque temos 3 parâmetros: a0, a1, a2)
Sy_x = sqrt(Sr / (n - 3));

fprintf('Análise de Qualidade do Ajuste:\n');
fprintf(' Erro-padrão da estimativa (Sy/x) = %.4f\n', Sy_x);
fprintf(' Coeficiente de Determinação (R^2) = %.4f\n', r2);
fprintf(' Coeficiente de Correlação Múltipla (R) = %.4f\n', R);

% =========================================================================
% 5. Plotagem Gráfica
% =========================================================================
figure('Name', 'Q7 - Regressão Múltipla', 'Position', [100, 100, 700, 500]);

% Plota os pontos reais (em vermelho)
scatter3(x1, x2, y, 80, 'r', 'filled');
hold on; grid on;

% Criação de uma malha para desenhar o plano
[X1_grid, X2_grid] = meshgrid(min(x1):0.5:max(x1), min(x2):0.5:max(x2));
Y_plano = a0 + a1*X1_grid + a2*X2_grid;

% Plota o plano ajustado de forma translúcida (em azul)
surf(X1_grid, X2_grid, Y_plano, 'FaceAlpha', 0.4, 'EdgeColor', 'none', 'FaceColor', 'b');

title(sprintf('Ajuste de Regressão Múltipla (R = %.4f | Sy/x = %.4f)', R, Sy_x));
xlabel('Variável x_1'); ylabel('Variável x_2'); zlabel('Variável y');
legend('Dados Experimentais', 'Plano Ajustado', 'Location', 'northeast');
view(-35, 25); % Ajusta o ângulo de visão do gráfico 3D
hold off;
