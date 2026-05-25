function y_int = Interp_Lagrange(x, y, x_val)
    % INTERP_LAGRANGE Calcula a interpolação polinomial pelo método de Lagrange.
    % x     : vetor com os valores da variável independente
    % y     : vetor com os valores da variável dependente
    % x_val : valor de x onde desejamos calcular a interpolação

    x = [-1, 0, 2];
    y = [4, 1, -1];
    x_val = 1;

    n = length(x); % Descobre o número de pontos fornecidos
    y_int = 0;     % Inicializa a variável que vai acumular a soma final

    fprintf('--- Avaliação dos Polinômios de Lagrange (L_k) Passo a Passo ---\n');

    % Loop externo 'i' percorre cada ponto para calcular seu respectivo termo na soma
    for i = 1:n
        Prod = 1; % Inicializa o Produtório (L_i) com 1 para não zerar a multiplicação

        % Loop interno 'j' calcula o produtório de (x - xj) / (xi - xj)
        for j = 1:n
            % A condição 'i ~= j' garante que o denominador não seja zero (xi - xi)
            if i ~= j
                numerador = x_val - x(j);
                denominador = x(i) - x(j);
                Prod = Prod * (numerador / denominador);
            end
        end

        % Após calcular L_i (que está em 'Prod'), multiplicamos por y(i)
        termo_atual = y(i) * Prod;

        % Soma o termo atual ao valor final
        y_int = y_int + termo_atual;

        fprintf('Para o nó i = %d (x = %f, y = %f):\n', i, x(i), y(i));
        fprintf('   Coeficiente L_%d(x_val) = %f\n', i, Prod);
        fprintf('   Parcela somada (y * L) = %f\n', termo_atual);
        fprintf('   Valor acumulado parcial = %f\n\n', y_int);
    end

    fprintf('--> Valor final interpolado pelo Método de Lagrange: %f\n', y_int);
end
