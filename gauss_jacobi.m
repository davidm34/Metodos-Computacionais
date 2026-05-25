function [x, k] = gauss_jacobi(A, b, x0, tol, max_iter)
   % GAUSS_JACOBI Resolve um sistema linear Ax = b usando o método de Gauss-Jacobi.
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

    n = length(b); % Obtém a dimensão do sistema
    x = x0;        % Inicializa o vetor solução com a aproximação inicial
    x_new = zeros(n, 1); % Vetor auxiliar para guardar a nova iteração

    fprintf('--- Iniciando Método de Gauss-Jacobi ---\n');
    fprintf('Iteração 0:\n');
    disp(x');

    for k = 1:max_iter
        % Percorre cada linha do sistema para calcular o novo x_i
        for i = 1:n
            soma = 0;
            % Calcula a soma dos termos a_ij * x_j para j diferente de i
            for j = 1:n
                if j ~= i
                    soma = soma + A(i,j) * x(j); % Usa apenas os valores da iteração anterior
                end
            end
            % Aplica a fórmula de iteração de Jacobi [cite: 210]
            x_new(i) = (b(i) - soma) / A(i,i);
        end

        % Calcula o erro relativo usando a norma infinito [cite: 46, 50]
        % dr = max(|x_new - x|) / max(|x_new|)
        erro_absoluto_max = max(abs(x_new - x));
        valor_max_x = max(abs(x_new));
        dr = erro_absoluto_max / valor_max_x;

        % Imprime o passo a passo da iteração atual
        fprintf('Iteração %d:\n', k);
        fprintf('  x = [ ');
        fprintf('%.6f ', x_new);
        fprintf(']\n');
        fprintf('  Erro dr = %.6f\n', dr);

        % Atualiza o vetor x para a próxima iteração
        x = x_new;

        % Verifica o critério de parada: se o erro for menor ou igual à tolerância [cite: 52]
        if dr <= tol
            fprintf('Convergiu na iteração %d com erro %.6f <= %.6f.\n\n', k, dr, tol);
            return;
        end
    end

    % Se sair do loop sem retornar, atingiu o limite de iterações [cite: 53]
    fprintf('Aviso: O método não convergiu após %d iterações.\n\n', max_iter);
end
