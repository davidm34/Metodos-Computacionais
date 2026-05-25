function x = gauss_jordan(A, b)
    % GAUSS_JORDAN Resolve sistema linear Ax = b usando Eliminação de Gauss-Jordan.
    % Exibe o passo a passo da matriz aumentada durante o processo.

    % Definimos a matriz de coeficientes 'A' do sistema linear (3x3)
    A_orig = [ 2, -6, -1;
              -3, -1,  7;
              -8,  1, -2];

    % Definimos o vetor de termos independentes 'b' (resultados)
    b_orig = [-38;
              -34;
              -20];

    % Criamos cópias de segurança para preservar os dados de entrada originais
    A = A_orig;
    b = b_orig;

    % 1. Verificações de integridade
    [n, m] = size(A);
    if n ~= m
        error('A matriz de coeficientes deve ser quadrada.');
    end
    if length(b) ~= n
        error('O vetor de termos independentes deve ter o mesmo número de linhas da matriz A.');
    end

    % Garante que 'b' seja um vetor coluna
    b = b(:);

    % 2. Cria a matriz aumentada [A | b]
    Ab = [A, b];

    fprintf('--- Matriz Aumentada Inicial ---\n');
    disp(Ab);

    % 3. Loop principal iterando sobre cada coluna (para definir os pivôs)
    for k = 1:n
        fprintf('\n======================================\n');
        fprintf('Analisando a coluna %d...\n', k);

        % --- PASSO A: PIVOTEAMENTO PARCIAL ---
        % Procura o maior valor em módulo na coluna atual (da diagonal para baixo)
        [~, max_idx] = max(abs(Ab(k:n, k)));
        max_idx = max_idx + k - 1; % Ajusta o índice relativo para o índice absoluto da matriz

        % Se o maior valor não estiver na linha atual (k), faz a troca de linhas
        if max_idx ~= k
            temp = Ab(k, :);
            Ab(k, :) = Ab(max_idx, :);
            Ab(max_idx, :) = temp;
            fprintf('-> Pivoteamento: Trocando a Linha %d com a Linha %d\n', k, max_idx);
            disp(Ab);
        else
            fprintf('-> Pivoteamento: Não foi necessário trocar linhas.\n');
        end

        % Pega o valor do pivô (que agora está na diagonal principal)
        pivo = Ab(k, k);
        if pivo == 0
            error('Sistema singular ou sem solução única (pivô igual a zero após pivoteamento).');
        end

        % --- PASSO B: NORMALIZAÇÃO ---
        % Divide toda a linha do pivô pelo próprio pivô, transformando-o em 1
        Ab(k, :) = Ab(k, :) / pivo;
        fprintf('-> Normalização: Linha %d dividida por %f\n', k, pivo);
        disp(Ab);

        % --- PASSO C: ELIMINAÇÃO ---
        % Zera todos os elementos da coluna atual que estão ACIMA e ABAIXO do pivô
        houve_eliminacao = false;
        for i = 1:n
            if i ~= k % Pula a linha do pivô (ela não deve ser subtraída dela mesma)
                fator_multiplicador = Ab(i, k);

                % Só realiza a conta se o elemento já não for zero
                if fator_multiplicador ~= 0
                    % Nova Linha = Linha Atual - (fator * Linha do Pivô)
                    Ab(i, :) = Ab(i, :) - fator_multiplicador * Ab(k, :);
                    houve_eliminacao = true;
                end
            end
        end

        % Imprime a matriz caso alguma linha tenha sido zerada nesta etapa
        if houve_eliminacao
            fprintf('-> Eliminação: Zerando os demais elementos da coluna %d\n', k);
            disp(Ab);
        end
    end

    % 4. Finalização e extração do resultado
    fprintf('\n======================================\n');
    fprintf('--- Matriz Diagonal Equivalente Final ---\n');
    disp(Ab);

    % A última coluna da matriz aumentada contém as respostas
    x = Ab(:, end);

    fprintf('--- Vetor Solução (x) ---\n');
    disp(x);
end
