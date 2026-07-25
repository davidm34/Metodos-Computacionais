clear; clc; close all;

% Dados do relatório
cidades = {'Feira de Santana', 'Lençois', 'Vitória da Conquista'};
altitude = [229.52, 438.09, 879.47];
temperatura = [24.22, 23.85, 19.90];
desvio = [1.73, 1.48, 1.57];

% Regressão linear
p = polyfit(altitude, temperatura, 1);

xfit = linspace(min(altitude)-30, max(altitude)+30, 200);
yfit = polyval(p, xfit);

figure(1);
errorbar(altitude, temperatura, desvio, 'o');
hold on;
plot(xfit, yfit, '-');
grid on;
xlabel('Altitude (m)');
ylabel('Temperatura média anual (°C)');
title('Regressão: Altitude x Temperatura Média com variância');
legend('Cidades (média \pm desvio)', 'Linha de regressão', 'location', 'best');

% Rótulos dos pontos
for i = 1:length(cidades)
  text(altitude(i)+10, temperatura(i), cidades{i});
end

print('grafico_regressao_variancia.png', '-dpng', '-r300');
