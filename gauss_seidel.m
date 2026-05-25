function [x, k] = gauss_seidel(A, b, x0, tol, max_iter)
    % GAUSS_SEIDEL Resolve um sistema linear Ax = b usando o método de Gauss-Seidel.
    %
    % Entradas:
    %   A        - Matriz dos coeficientes (n x n)
    %   b        - Vetor dos termos independentes (n x 1)
    %   x0       - Vetor de aproximação inicial (n x 1)
    %   tol      - Tolerância para o critério de parada (erro relativo)
    %   max_iter - Número máximo de iterações permitidas
    %
    % Saídas:
    %   x        - Vetor solução aproximada
    %   k        - Número de iterações realizadas
    A = [10  3  -2;
          2  8  -1;
          1  1 5];
    b = [57; 20; -4];

    % Aproximação inicial (x0), tolerância (epsilon) e iterações máximas
    x0 = [0; 0; 0]; % Chute inicial dado no documento [cite: 99]
    tol = 0.05;            % Precisão exigida [cite: 99]
    max_iter = 2;         % Limite de segurança

    % Saídas:
    %   x        - Vetor solução aproximada
    %   k        - Número de iterações realizadas

    n = length(b); % Obtém a dimensão do sistema
    x = x0;        % Inicializa o vetor solução com a aproximação inicial
    x_old = x0;    % Guarda a iteração anterior para calcular o erro no final

    fprintf('--- Iniciando Método de Gauss-Seidel ---\n');
    fprintf('Iteração 0:\n');
    disp(x');

    for k = 1:max_iter
        % Percorre cada linha do sistema
        for i = 1:n
            soma = 0;
            % Calcula a soma dos termos a_ij * x_j
            for j = 1:n
                if j ~= i
                    % Nota: O vetor 'x' é atualizado diretamente, então
                    % se j < i, ele já usa o valor novo calculado nesta iteração [cite: 252, 358]
                    soma = soma + A(i,j) * x(j);
                end
            end
            % Aplica a fórmula de iteração de Seidel [cite: 358]
            x(i) = (b(i) - soma) / A(i,i);
        end

        % Calcula o erro relativo usando a norma infinito [cite: 256, 258]
        erro_absoluto_max = max(abs(x - x_old));
        valor_max_x = max(abs(x));
        dr = erro_absoluto_max / valor_max_x;

        % Imprime o passo a passo da iteração atual
        fprintf('Iteração %d:\n', k);
        fprintf('  x = [ ');
        fprintf('%.6f ', x);
        fprintf(']\n');
        fprintf('  Erro dr = %.6f\n', dr);

        % Atualiza o x_old para a próxima verificação de erro
        x_old = x;

        % Verifica o critério de parada [cite: 257]
        if dr <= tol
            fprintf('Convergiu na iteração %d com erro %.6f <= %.6f.\n\n', k, dr, tol);
            return;
        end
    end

    % Se atingir o limite máximo de iterações [cite: 260]
    fprintf('Aviso: O método não convergiu após %d iterações.\n\n', max_iter);
end
