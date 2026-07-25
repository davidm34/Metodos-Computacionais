clear; clc; close all;

% ===============================
% DADOS DO RELATÓRIO
% ===============================

regioes = {
  'Litoral-Agreste';
  'Piemonte/Chapada';
  'Sudoeste/Serra Geral';
  'Inter-regional'
};

erros = [0.2, 2.13, 1.7, 2.14];

cidades = {
  'Feira de Santana';
  'Lençois';
  'Vitória da Conquista'
};

medias = [24.22, 23.85, 19.90];
r2 = [0.6907, 0.5717, 0.6515];
cv = [7.15, 6.23, 7.90];

desvio_media = [1.73, 1.48, 1.57];
desvio_regressao = [1.06, 1.07, 1.02];

% ===============================
% GRÁFICO 1 - ERRO DA INTERPOLAÇÃO
% ===============================

figure(1);
bar(erros);
set(gca, 'XTick', 1:length(regioes));
set(gca, 'XTickLabel', regioes);
ylabel('Erro absoluto (°C)');
title('Erro Absoluto da Interpolação');
grid on;
print('01_erro_interpolacao.png', '-dpng', '-r300');

% ===============================
% GRÁFICO 2 - TEMPERATURA MÉDIA ANUAL
% ===============================

figure(2);
bar(medias);
set(gca, 'XTick', 1:length(cidades));
set(gca, 'XTickLabel', cidades);
ylabel('Temperatura média anual (°C)');
title('Temperatura Média Anual por Cidade');
grid on;
print('02_temperatura_media_anual.png', '-dpng', '-r300');

% ===============================
% GRÁFICO 3 - COEFICIENTE R²
% ===============================

figure(3);
bar(r2);
set(gca, 'XTick', 1:length(cidades));
set(gca, 'XTickLabel', cidades);
ylabel('Coeficiente de determinação (R²)');
title('Qualidade do Ajuste Polinomial');
ylim([0 1]);
grid on;
print('03_coeficiente_determinacao_r2.png', '-dpng', '-r300');

% ===============================
% GRÁFICO 4 - COEFICIENTE DE VARIAÇÃO
% ===============================

figure(4);
bar(cv);
set(gca, 'XTick', 1:length(cidades));
set(gca, 'XTickLabel', cidades);
ylabel('Coeficiente de variação (%)');
title('Variação Relativa das Temperaturas');
grid on;
print('04_coeficiente_variacao_cv.png', '-dpng', '-r300');

% ===============================
% GRÁFICO 5 - COMPARAÇÃO DOS DESVIOS
% ===============================

figure(5);
dados_desvios = [desvio_media; desvio_regressao]';
bar(dados_desvios);
set(gca, 'XTick', 1:length(cidades));
set(gca, 'XTickLabel', cidades);
ylabel('Desvio padrão (°C)');
title('Comparação dos Desvios');
legend('Desvio em torno da média', 'Desvio em torno da regressão');
grid on;
print('05_comparacao_desvios.png', '-dpng', '-r300');
