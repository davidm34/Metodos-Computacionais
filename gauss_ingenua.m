function x = gauss_ingenua(A, b)
    % =========================================================================
    % ELIMINAÇÃO DE GAUSS INGÊNUA (Sem Pivoteamento)
    % =========================================================================

    % 1. DEFINIÇÃO DO SISTEMA ORIGINAL E CONFIGURAÇÃO
    % =========================================================================

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

    % Descobre a dimensão do sistema com base no tamanho do vetor b
    n = length(b);

    % --- IMPRESSÃO INICIAL ---
    fprintf('===================================================\n');
    fprintf('                 SISTEMA INICIAL\n');
    fprintf('===================================================\n');
    disp('Matriz A original:'); disp(A);
    disp('Vetor b original:'); disp(b);

    % =========================================================================
    % 1. ETAPA DE TRIANGULARIZAÇÃO (Eliminação Progressiva)
    % Objetivo: Zerar todos os elementos abaixo da diagonal principal de A.
    % =========================================================================

    % O laço 'k' percorre as colunas, atuando como o índice do pivô atual.
    % Vai de 1 até n-1 porque não precisamos eliminar nada na última coluna.
    for k = 1:n-1

        % --- IMPRESSÃO DO PASSO ---
        fprintf('\n---------------------------------------------------\n');
        fprintf('PASSO DE ELIMINAÇÃO k = %d\n', k);
        fprintf('---------------------------------------------------\n');

        % O laço 'i' percorre as linhas que estão estritamente ABAIXO do pivô 'k'.
        for i = k+1:n

            % Calcula o fator multiplicador (m_ik).
            % É a razão entre o elemento que queremos zerar e o elemento pivô.
            % ATENÇÃO: Se A(k,k) for zero, o algoritmo ingênuo falha aqui!
            fator = A(i,k) / A(k,k);

            % --- IMPRESSÃO DO FATOR ---
            fprintf('   Fator multiplicador para zerar A(%d,%d): %f\n', i, k, fator);

            % Atualiza a linha 'i' da matriz A.
            % Percorremos as colunas 'j' a partir de 'k' até o final 'n'.
            % A operação é: Linha Atual = Linha Atual - (fator * Linha do Pivô)
            for j = k:n
                A(i,j) = A(i,j) - fator * A(k,j);
            end

            % Aplica a mesma operação no vetor de resultados 'b' para
            % manter a equivalência do sistema linear.
            b(i) = b(i) - fator * b(k);

        end

        % --- IMPRESSÃO DO ESTADO PARCIAL ---
        disp('Matriz A resultante deste passo:'); disp(A);
        disp('Vetor b resultante deste passo:'); disp(b);
    end

    % =========================================================================
    % 2. ETAPA DE RETROSUBSTITUIÇÃO
    % Objetivo: Resolver o sistema triangular de baixo para cima.
    % =========================================================================

    % --- IMPRESSÃO DA RETROSUBSTITUIÇÃO ---
    fprintf('\n===================================================\n');
    fprintf('          RETROSUBSTITUIÇÃO (Solução)\n');
    fprintf('===================================================\n');

    % Inicializa o vetor solução 'x' com zeros
    x = zeros(n, 1);

    % Resolve a última equação diretamente.
    % A última linha da matriz triangular só possui uma incógnita.
    x(n) = b(n) / A(n,n);
    fprintf('   Calculando x(%d) = %f\n', n, x(n));

    % O laço 'i' sobe da penúltima linha (n-1) até a primeira (1),
    % decrementando de 1 em 1 (-1).
    for i = n-1:-1:1

        % Inicializa a variável para acumular a soma das substituições
        soma = 0;

        % O laço 'j' percorre as variáveis à direita da diagonal que
        % JÁ foram calculadas nos passos anteriores.
        for j = i+1:n
            soma = soma + A(i,j) * x(j);
        end

        % Isola o x(i) atual: pega o valor de b(i), subtrai a 'soma'
        % (que são os termos já conhecidos passados para o outro lado)
        % e divide pelo coeficiente da diagonal A(i,i).
        x(i) = (b(i) - soma) / A(i,i);
        fprintf('   Calculando x(%d) = %f\n', i, x(i));
    end

    % --- IMPRESSÃO FINAL ---
    fprintf('\n>> Sistema resolvido com sucesso!\n\n');
    disp('Vetor Solução x final:');
    for i = 1:n
        fprintf('   x%d = %f\n', i, x(i));
    end
end
