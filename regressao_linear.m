function [a1, a2, r2] = regressao_linear(x, y, nome_modelo)
    % Função para calcular e imprimir os parâmetros da regressão linear
    % x e y devem ser vetores de mesmo tamanho.

    n = length(x); % Número de pontos de dados

    % Passo 1: Cálculos dos somatórios necessários para as fórmulas
    sum_x = sum(x);
    sum_y = sum(y);
    sum_xy = sum(x .* y);
    sum_x2 = sum(x .^ 2);

    % Média dos valores
    media_x = sum_x / n;
    media_y = sum_y / n;

    % Passo 2: Cálculo dos Coeficientes da Reta (y = a1*x + a2)
    a1 = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x^2);
    a2 = media_y - a1 * media_x;

    % Passo 3: Cálculo dos Resíduos e Desvios
    % St: Soma dos quadrados dos resíduos em relação à média
    St = sum((y - media_y).^2);

    % Sr: Soma dos quadrados dos resíduos em relação ao ajuste linear
    Sr = sum((y - (a1 .* x + a2)).^2);

    % Sy: Desvio padrão em torno da média (Total)
    Sy = sqrt(St / (n - 1));

    % Sy_x: Erro-padrão da estimativa (Desvio em torno da reta)
    Sy_x = sqrt(Sr / (n - 2));

    % Passo 4: Coeficiente de Determinação (r2)
    r2 = (St - Sr) / St;

    % Passo 5: Impressão dos Resultados
    fprintf('\n--- Resultados para o Modelo: %s ---\n', nome_modelo);
    fprintf('Coeficiente Angular (a1): %.4f\n', a1);
    fprintf('Coeficiente Linear (a2): %.4f\n', a2);
    fprintf('Residuo em relacao a media (St): %.4f\n', St);
    fprintf('Residuo em relacao ao ajuste linear (Sr): %.4f\n', Sr);
    fprintf('Desvio Padrao Total (Sy): %.4f\n', Sy);
    fprintf('Erro-padrao da Estimativa (Sy/x): %.4f\n', Sy_x);
    fprintf('Coeficiente de Determinacao (r2): %.4f\n', r2);
end
