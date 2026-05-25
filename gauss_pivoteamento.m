% =========================================================================
% ELIMINAÇÃO DE GAUSS COM PIVOTAMENTO PARCIAL E RETROSUBSTITUIÇÃO
% =========================================================================

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
a = A_orig;
b = b_orig;

% Descobre o tamanho do sistema (neste caso, n = 3)
n = length(b);

% Inicializa o contador de trocas de linhas (útil para cálculo de determinantes)
num_trocas = 0;

% Exibe as matrizes originais no console
fprintf('===================================================\n');
fprintf('          SISTEMA ORIGINAL E CONFIGURAÇÃO\n');
fprintf('===================================================\n');
disp('Matriz A original:'); disp(a);
disp('Vetor b original:'); disp(b);


% =========================================================================
% 2. PROCESSO DE ELIMINAÇÃO COM PIVOTAMENTO PARCIAL
% =========================================================================

% O laço percorre as colunas, da primeira até a penúltima
for k = 1:n-1

    fprintf('\n---------------------------------------------------\n');
    fprintf('PASSO DE ELIMINAÇÃO k = %d\n', k);
    fprintf('---------------------------------------------------\n');

    % --- 2.1. Bloco de Pivotamento ---

    % Supõe que o melhor pivô está na diagonal da coluna atual
    p = k;
    Max = abs(a(k,k));

    % Busca pelo maior número (em módulo) abaixo da diagonal
    for ii = k+1:n
        teste = abs(a(ii,k));
        if teste > Max
            Max = teste;
            p = ii;
        end
    end

    % Se o maior número estiver em outra linha, faz a troca (swap)
    if p ~= k
        fprintf('>> PIVOTAMENTO: Trocando linha %d pela linha %d\n', k, p);
        num_trocas = num_trocas + 1;

        % Troca as linhas na matriz 'a'
        for jj = k:n
            teste = a(p,jj);
            a(p,jj) = a(k,jj);
            a(k,jj) = teste;
        end

        % Troca as linhas correspondentes no vetor 'b'
        teste_b = b(p);
        b(p) = b(k);
        b(k) = teste_b;

        disp('Matriz a (após a troca de linhas):'); disp(a);
    else
        fprintf('>> PIVOTAMENTO: Elemento da diagonal já é o maior. Nenhuma troca necessária.\n');
    end

    % --- 2.2. Bloco de Eliminação ---
    fprintf('>> ELIMINAÇÃO:\n');

    % Percorre as linhas abaixo do pivô para transformá-las em zero
    for i = k+1:n

        % Calcula o multiplicador
        fator = a(i,k) / a(k,k);
        fprintf('   Fator multiplicador para zerar a(%d,%d): %f\n', i, k, fator);

        % Atualiza os valores da matriz 'a' (Linha = Linha - Fator * Linha do Pivô)
        for j = k:n
            a(i,j) = a(i,j) - fator * a(k,j);
        end

        % Atualiza o valor correspondente no vetor 'b'
        b(i) = b(i) - fator * b(k);
    end

    % Mostra o resultado parcial após zerar a coluna
    disp('Matriz a resultante deste passo:'); disp(a);

end


% =========================================================================
% 3. RETROSUBSTITUIÇÃO (Encontrando x1, x2 e x3)
% =========================================================================
fprintf('\n===================================================\n');
fprintf('          RETROSUBSTITUIÇÃO (Solução do Sistema)\n');
fprintf('===================================================\n');

% Cria o vetor solução 'x' preenchido com zeros inicialmente
x = zeros(n, 1);

% Resolve a última equação diretamente (a base do triângulo)
x(n) = b(n) / a(n,n);

% Resolve as equações restantes de baixo para cima
for i = n-1:-1:1
    soma = 0;

    % Substitui os valores de x que já descobrimos nos passos anteriores
    for j = i+1:n
        soma = soma + a(i,j) * x(j);
    end

    % Isola a variável atual para encontrar seu valor
    x(i) = (b(i) - soma) / a(i,i);
end


% =========================================================================
% 4. EXIBIÇÃO DOS RESULTADOS FINAIS
% =========================================================================
fprintf('\n>> Sistema resolvido com sucesso!\n\n');
disp('Vetor Solução x:');

for i = 1:n
    fprintf('   x%d = %f\n', i, x(i));
end
