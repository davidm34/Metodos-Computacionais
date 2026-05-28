% =========================================================================
% SCRIPT PRINCIPAL: MENU DE MÉTODOS COMPUTACIONAIS
% Permite selecionar e executar os diferentes métodos implementados
% =========================================================================
clc; clear; close all;

opcao = -1;

while opcao ~= 0
    fprintf('\n=======================================================\n');
    fprintf('          MENU DE MÉTODOS COMPUTACIONAIS               \n');
    fprintf('=======================================================\n');
    fprintf('--- SISTEMAS LINEARES (MÉTODOS DIRETOS) ---\n');
    fprintf('  [1] Eliminação de Gauss Ingênua\n');
    fprintf('  [2] Eliminação de Gauss com Pivoteamento Parcial\n');
    fprintf('  [3] Eliminação de Gauss-Jordan\n');
    fprintf('  [4] Decomposição LU\n\n');
    fprintf('--- SISTEMAS LINEARES (MÉTODOS ITERATIVOS) ---\n');
    fprintf('  [5] Método de Gauss-Jacobi\n');
    fprintf('  [6] Método de Gauss-Seidel\n\n');
    fprintf('--- INTERPOLAÇÃO POLINOMIAL ---\n');
    fprintf('  [7] Interpolação pelo Método de Newton\n');
    fprintf('  [8] Interpolação pelo Método de Lagrange\n\n');
    fprintf('--- AJUSTE DE CURVAS E REGRESSÃO ---\n');
    fprintf('  [9] Regressão Linear e Modelos Linearizados (Geral)\n');
    fprintf('  [10] Regressão Polinomial (Vários Graus)\n');
    fprintf('  [11] Regressão Linear Múltipla (Ajuste de Plano)\n\n');
    fprintf('  [0] Sair\n');
    fprintf('=======================================================\n');
    
    opcao = input('Escolha o método que deseja utilizar: ');
    fprintf('\n');
    
    switch opcao
        case 1
            fprintf('>> Executando: Eliminação de Gauss Ingênua...\n');
            % Matriz e vetor padrão do seu arquivo gauss_ingenua.m
            A = [ 2, -6, -1; -3, -1,  7; -8,  1, -2];
            b = [-38; -34; -20];
            x = gauss_ingenua(A, b);
            
        case 2
            fprintf('>> Executando: Eliminação de Gauss com Pivoteamento...\n');
            % Matriz e vetor de teste para pivoteamento
            A = [ 2, -6, -1; -3, -1,  7; -8,  1, -2];
            b = [-38; -34; -20];
            x = gauss_pivoteamento(A, b);
            
        case 3
            fprintf('>> Executando: Eliminação de Gauss-Jordan...\n');
            A = [ 2, -6, -1; -3, -1,  7; -8,  1, -2];
            b = [-38; -34; -20];
            x = gauss_jordan(A, b);
            
        case 4
            fprintf('>> Executando: Decomposição LU...\n');
            A = [ 2, -6, -1; -3, -1,  7; -8,  1, -2];
            b = [-38; -34; -20];
            [L, U, y, x] = decomposicao_lu(A, b);
            
        case 5
            fprintf('>> Executando: Método de Gauss-Jacobi...\n');
            A = [10, 3, -2; 2, 8, -1; 1, 1, 5];
            b = [57; 20; -4];
            x0 = [0; 0; 0];
            tol = 0.05;
            max_iter = 2;
            [x, k] = gauss_jacobi(A, b, x0, tol, max_iter);
            
        case 6
            fprintf('>> Executando: Método de Gauss-Seidel...\n');
            A = [10, 3, -2; 2, 8, -1; 1, 1, 5];
            b = [57; 20; -4];
            x0 = [0; 0; 0];
            tol = 0.05;
            max_iter = 2;
            [x, k] = gauss_seidel(A, b, x0, tol, max_iter);
            
        case 7
            fprintf('>> Executando: Interpolação de Newton...\n');
            x_pontos = [-1, 0, 2];
            y_pontos = [4, 1, -1];
            x_val = 1;
            y_int = Interp_Newton(x_pontos, y_pontos, x_val);
            
        case 8
            fprintf('>> Executando: Interpolação de Lagrange...\n');
            x_pontos = [-1, 0, 2];
            y_pontos = [4, 1, -1];
            x_val = 1;
            y_int = Interp_Lagrange(x_pontos, y_pontos, x_val);
            
        case 9
            fprintf('>> Executando: Script Principal de Regressão Linear...\n');
            % Roda o script existente que analisa os 4 modelos lineares/linearizados
            main_regressao_linear;
            
        case 10
            fprintf('>> Executando: Regressão Polinomial...\n');
            % Roda o script de regressão polinomial por mínimos quadrados
            regressao_polinomial;
            
        case 11
            fprintf('>> Executando: Regressão Linear Múltipla...\n');
            % Roda o script de regressão múltipla (ajuste de plano)
            regressao_linear_multipla;
            
        case 0
            fprintf('Saindo do programa. Até logo!\n');
            
        otherwise
            fprintf('Opção inválida! Por favor, escolha um número do menu.\n');
    end
    
    if opcao ~= 0
        input('\nPressione ENTER para continuar...', 's');
        clc;
    end
end