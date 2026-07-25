% =========================================================================
% Gráfico Analítico: Comparação entre Temperatura Real vs Estimada
% (VERSÃO COMPATÍVEL COM OCTAVE)
% =========================================================================
clear; clc; close all;

% 1. Cidades analisadas
cidades = {'Serrinha (Agreste)', 'Irece (Chapada)', 'V. da Conquista'};

% 2. Dados das Temperaturas (Baseado no Relatório - Ano 2011)
temp_real     = [24.25, 23.68, 19.91];
temp_estimada = [24.05, 21.98, 22.04];

% 3. Cálculo do erro absoluto
erro_absoluto = abs(temp_real - temp_estimada);

% 4. Configurando a janela da figura
figure('Name', 'Analise de Erro da Interpolacao');

% 5. Criando gráfico de barras agrupadas
dados_grafico = [temp_real', temp_estimada'];
b = bar(dados_grafico, 'grouped');

% Customizando as cores usando colormap (Compatível com Octave)
% Azul para Temperatura Real, Vermelho/Laranja para Estimada
colormap([0.15 0.35 0.55; 0.85 0.35 0.25]);

% 6. Customização estética do gráfico
set(gca, 'XTick', 1:3, 'XTickLabel', cidades, 'FontSize', 11);
title('Precisao: Temp. Real vs Modelo Interpolador (2011)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Temperatura Media (C)', 'FontSize', 11, 'FontWeight', 'bold');
legend('Temperatura Real', 'Temperatura Estimada', 'Location', 'northeast');
grid on;

% Definindo limite do Eixo Y para melhorar a visualização e dar espaço para os textos
ylim([15, 28]);

% 7. Adicionando os rótulos numéricos no topo de cada barra (Método Manual para Octave)
% Offset é o deslocamento no eixo X das barras agrupadas
offset = [-0.14, 0.14];
for grupo = 1:3
    for barra = 1:2
        x_pos = grupo + offset(barra);
        y_pos = dados_grafico(grupo, barra);
        texto_valor = sprintf('%.2f', y_pos);
        text(x_pos, y_pos + 0.3, texto_valor, 'HorizontalAlignment', 'center', ...
             'FontSize', 10, 'FontWeight', 'bold');
    end
end

% 8. Adicionando balões de texto com o "Tamanho do Erro" acima do grupo
for i = 1:3
    x_pos = i;
    y_pos = max(temp_real(i), temp_estimada(i)) + 1.2; % Posição logo acima das barras
    texto_erro = sprintf('Erro: %.2f C', erro_absoluto(i));
    text(x_pos, y_pos, texto_erro, 'HorizontalAlignment', 'center', ...
         'BackgroundColor', [0.95 0.95 0.95], 'EdgeColor', 'black', ...
         'FontSize', 11, 'FontWeight', 'bold');
end
