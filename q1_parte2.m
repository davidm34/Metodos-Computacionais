% =========================================================================
% Parte 2 - Problema 1: Momento Fletor
% =========================================================================
clear; clc; format shortG;

% Dados do problema
V = @(x) 5 + 0.24 * x.^2;
a = 0;
b = 11;
h = 1;       % Incrementos de 1 m
x = a:h:b;   % Vetor de distâncias: [0, 1, 2, ..., 11]

fprintf('================= PARTE 2 - PROBLEMA 1 =================\n');

% -------------------------------------------------------------------------
% (a) Integração Analítica
% Integral de V(x) = 5 + 0.24*x^2 é M(x) = 5*x + 0.24*(x^3)/3 = 5*x + 0.08*x^3
% -------------------------------------------------------------------------
M_analitico = (5*b + 0.08*b^3) - (5*a + 0.08*a^3);
fprintf('(a) Integracao Analitica:\n');
fprintf('    M = %.4f N.m (ou unidade respectiva)\n\n', M_analitico);

% -------------------------------------------------------------------------
% (b) Aplicação múltipla da Regra do Trapézio
% -------------------------------------------------------------------------
soma_interna_trap = sum(V(x(2:end-1)));
M_trapezio = (h/2) * (V(x(1)) + 2*soma_interna_trap + V(x(end)));

erro_trap = abs((M_analitico - M_trapezio)/M_analitico)*100;
fprintf('(b) Regra do Trapezio Multipla (h = 1):\n');
fprintf('    M = %.4f\n', M_trapezio);
fprintf('    Erro Relativo: %.4f%%\n\n', erro_trap);

% -------------------------------------------------------------------------
% (c) Aplicação múltipla das Regras de Simpson
% Como n=11 (ímpar), dividimos em:
% -> Simpson 1/3 para n=8 segmentos (x = 0 até 8)
% -> Simpson 3/8 para n=3 segmentos (x = 8 até 11)
% -------------------------------------------------------------------------

% Parte 1: Simpson 1/3 (x do índice 1 ao 9 -> x=0 até x=8)
x_s13 = x(1:9);
soma_impar = sum(V(x_s13(2:2:end-1)));
soma_par = sum(V(x_s13(3:2:end-2)));
I_simp13 = (h/3) * (V(x_s13(1)) + 4*soma_impar + 2*soma_par + V(x_s13(end)));

% Parte 2: Simpson 3/8 (x do índice 9 ao 12 -> x=8 até x=11)
x_s38 = x(9:12);
I_simp38 = (3*h/8) * (V(x_s38(1)) + 3*V(x_s38(2)) + 3*V(x_s38(3)) + V(x_s38(end)));

% Soma total
M_simpson = I_simp13 + I_simp38;

erro_simp = abs((M_analitico - M_simpson)/M_analitico)*100;
fprintf('(c) Regras de Simpson Multiplas Combinadas (h = 1):\n');
fprintf('    [Simpson 1/3 (n=8) + Simpson 3/8 (n=3)]\n');
fprintf('    M = %.4f\n', M_simpson);
fprintf('    Erro Relativo: %.4f%%\n\n', erro_simp);
