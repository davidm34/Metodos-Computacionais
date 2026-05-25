function y_int = Interp_Newton(x, y, x_val)
    % INTERP_NEWTON Calcula a interpolação polinomial pelo método de Newton.
    % x     : vetor com os valores da variável independente (pontos conhecidos)
    % y     : vetor com os valores da variável dependente (f(x) conhecidos)
    % x_val : valor de x onde desejamos calcular a interpolação

    x = [-1, 0, 2];
    y = [4, 1, -1];
    x_val = 1;

    n = length(x); % Descobre o número de pontos fornecidos

    % PASSO 1: Construção da Tabela de Diferenças Divididas
    b = zeros(n, n); % Inicializa uma matriz nxn com zeros
    b(:, 1) = y(:);  % A primeira coluna recebe os valores de y (ordem 0)

    fprintf('--- Construindo a Tabela de Diferenças Divididas ---\n');
    % O loop externo 'j' avança nas colunas (ordens das diferenças: 1, 2, ..., n-1)
    for j = 2:n
        % O loop interno 'i' desce nas linhas para calcular a diferença
        for i = 1:(n - j + 1)
            % Fórmula da diferença dividida
            numerador = b(i + 1, j - 1) - b(i, j - 1);
            denominador = x(i + j - 1) - x(i);
            b(i, j) = numerador / denominador;
        end
    end

    % Imprime a matriz de diferenças divididas resultante
    disp('Matriz b (Diferenças Divididas):');
    disp(b);

    % PASSO 2: Cálculo do polinômio no ponto x_val
    fprintf('\n--- Calculando o valor interpolado Passo a Passo ---\n');
    y_int = b(1, 1); % O primeiro termo é apenas f(x0) = b(1,1)
    xt = 1;          % Variável acumuladora para o produtório (x - x0)(x - x1)...

    fprintf('Termo inicial (b0) = %f\n', y_int);

    % Loop para iterar sobre os coeficientes da matriz (primeira linha)
    for j = 1:(n - 1)
        % Atualiza o produtório multiplicando pelo termo atual (x - x_{j})
        xt = xt * (x_val - x(j));

        % Calcula o incremento a ser somado ao valor final
        incremento = b(1, j + 1) * xt;

        % Acumula o valor em y_int
        y_int = y_int + incremento;

        fprintf('Somando termo %d: coef(%f) * produtório(%f) = %f\n', j, b(1, j+1), xt, incremento);
        fprintf('Valor parcial = %f\n', y_int);
    end

    fprintf('\n--> Valor final interpolado pelo Método de Newton: %f\n', y_int);
end
