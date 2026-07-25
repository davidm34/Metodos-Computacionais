% =========================================================================
% Parte 2 - Problema 2: Horário do Rush
% =========================================================================
clear; clc; format shortG;

% Dados do problema
% Convertendo os horários para minutos a partir das 7:30
% 7:30 = 0 | 7:45 = 15 | 8:00 = 30 | 8:15 = 45 | 8:45 = 75 | 9:15 = 105
t_min = [0, 15, 30, 45, 75, 105];

% Taxa observada na tabela (carros a cada 4 min)
taxa_4min = [18, 23, 14, 24, 20, 9];

% Convertendo a taxa para a unidade base de carros por minuto (carros/min)
% Sabemos que V(t) = Taxa / 4
v_min = taxa_4min / 4;

fprintf('================= PARTE 2 - PROBLEMA 2 =================\n');

% -------------------------------------------------------------------------
% (a) O número total de carros que passa entre 7:30 e 9:15
% -------------------------------------------------------------------------
% Como o enunciado pede "o melhor método numérico" e os espaçamentos em x (t)
% variam, vamos identificar blocos com espaçamentos constantes (h):
%
% Bloco 1: Tempos [0, 15, 30, 45] -> h1 = 15 min (3 segmentos).
%          O melhor método exato aqui é a Regra de Simpson 3/8.
%
% Bloco 2: Tempos [45, 75, 105] -> h2 = 30 min (2 segmentos).
%          O melhor método exato aqui é a Regra de Simpson 1/3.

% Calculando Bloco 1 (Simpson 3/8)
h1 = 15;
I_simp38 = (3*h1/8) * (v_min(1) + 3*v_min(2) + 3*v_min(3) + v_min(4));

% Calculando Bloco 2 (Simpson 1/3)
h2 = 30;
I_simp13 = (h2/3) * (v_min(4) + 4*v_min(5) + v_min(6));

% Total de carros será a soma das duas áreas sob a curva
total_carros = I_simp38 + I_simp13;

fprintf('(a) Numero total de carros (das 7:30 as 9:15):\n');
fprintf('    Estrategia: Simpson 3/8 (primeira hora) + Simpson 1/3 (resto)\n');
fprintf('    Total = %.2f carros\n\n', total_carros);

% -------------------------------------------------------------------------
% (b) A taxa de carros passando pela interseção por minuto
% -------------------------------------------------------------------------
% A taxa média global é simplesmente a integral (número total de carros)
% dividida pelo intervalo de tempo total de observação.
tempo_total = t_min(end) - t_min(1); % 105 - 0 = 105 minutos
taxa_media = total_carros / tempo_total;

fprintf('(b) Taxa media de carros ao longo de todo o periodo:\n');
fprintf('    Taxa = %.4f carros/minuto\n', taxa_media);
