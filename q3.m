% =========================================================================
% RESOLUÇÃO DA QUESTÃO 3: Interpolação Inversa (Polinómio + Raiz)
% =========================================================================
clear; clc; close all;

% --- (a) Solução Analítica ---
fprintf('--- (a) Solução Analítica ---\n');
x_analitico = sqrt(0.85 / 0.15);
fprintf('Valor analítico exato: x = %.6f\n\n', x_analitico);

% --- (b) Polinómio Interpolador Cúbico ---
fprintf('--- (b) Polinómio Interpolador Cúbico (Método de Newton) ---\n');
% Seleção de 4 pontos ao redor de f(x) = 0.85 (x=1, 2, 3, 4)
x = [1; 2; 3; 4];
y = [0.5; 0.8; 0.9; 0.941176];
n = length(x);

% Construção da Tabela de Diferenças Divididas
b = zeros(n, n);
b(:, 1) = y(:);

for j = 2:n
    for i = 1:(n - j + 1)
        numerador = b(i + 1, j - 1) - b(i, j - 1);
        denominador = x(i + j - 1) - x(i);
        b(i, j) = numerador / denominador;
    end
end

disp('Matriz de Diferenças Divididas:');
disp(b);

% Os coeficientes (b0, b1, b2, b3) estão na primeira linha da matriz
b0 = b(1,1); b1 = b(1,2); b2 = b(1,3); b3 = b(1,4);
fprintf('Coeficientes: b0 = %.6f | b1 = %.6f | b2 = %.6f | b3 = %.6f\n\n', b0, b1, b2, b3);

% --- (c) Encontrar a raiz do polinómio correspondente ---
fprintf('--- (c) Encontrar a raiz de P_3(x) = 0.85 ---\n');

% Definimos a função anónima correspondente a: P_3(x) - 0.85 = 0
% P_3(x) = b0 + b1(x-x1) + b2(x-x1)(x-x2) + b3(x-x1)(x-x2)(x-x3)
P3_menos_085 = @(val) b0 + ...
                      b1 * (val - x(1)) + ...
                      b2 * (val - x(1)) * (val - x(2)) + ...
                      b3 * (val - x(1)) * (val - x(2)) * (val - x(3)) ...
                      - 0.85;

% Como sabemos que o valor está entre x=2 e x=3, usamos 2.5 como estimativa inicial
x_numerico = fzero(P3_menos_085, 2.5);

fprintf('Valor numérico encontrado (raiz): x = %.6f\n', x_numerico);
fprintf('Erro absoluto em relação ao valor analítico: %e\n', abs(x_analitico - x_numerico));
