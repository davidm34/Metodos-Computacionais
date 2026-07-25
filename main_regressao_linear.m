% =========================================================================
% Script Principal: Ajuste de Curvas a Dados Medidos
% Modelos: Linear, Exponencial, Potência, Crescimento de Saturação
% =========================================================================
clc; clear; close all;

disp('DADOS REAIS: BAHIA - ANO 2000');
x = [6.05, 128.78, 143.53, 197.88, 219.69, 229.52, 250.1, 255.04, 362.39, 397.39, 407.5, 438.09, 447.51, 447.75, 450.01, 455.25, 465.84, 486.37, 532.09, 551.69, 747.22, 757.53, 876.29, 879.47, 1001.66];
y = [24.35, 24.04, 25.21, 23.52, 23.78, 23.98, 24.67, 25.92, 23.82, 26.53, 26.13, 23.5, 24.57, 25.72, 24.6, 25.18, 24.02, 23.68, 23.7, 24.07, 23.05, 20.41, 21.87, 20.3, 20.29];

disp('INICIANDO ANÁLISE DE AJUSTE DE CURVAS...');

%% 1. MODELO LINEAR DIRETO
% Equação: y = a1*x + a2
[a1_lin, a2_lin, r2_lin] = regressao_linear(x, y, 'Linear Simples');

%% 2. MODELO EXPONENCIAL
% Equação original: y = alfa * exp(beta * x)
% Forma Linearizada: ln(y) = ln(alfa) + beta * x
% Transformação: X = x | Y = ln(y)
X_exp = x;
Y_exp = log(y); % No MATLAB, log() é o logaritmo natural (ln)

% Chama a regressão para os dados linearizados
[a1_exp, a2_exp, r2_exp] = regressao_linear(X_exp, Y_exp, 'Exponencial Linearizado');

% Retornando aos parâmetros originais do modelo não-linear
beta_exp = a1_exp;
alfa_exp = exp(a2_exp);
fprintf('-> Parametros Originais (Exponencial): alfa = %.4f, beta = %.4f\n', alfa_exp, beta_exp);

%% 3. MODELO DE POTÊNCIA
% Equação original: y = alfa * x^beta
% Forma Linearizada: log10(y) = log10(alfa) + beta * log10(x)
% Transformação: X = log10(x) | Y = log10(y)
X_pot = log10(x);
Y_pot = log10(y);

% Chama a regressão para os dados linearizados
[a1_pot, a2_pot, r2_pot] = regressao_linear(X_pot, Y_pot, 'Potencia Linearizado');

% Retornando aos parâmetros originais do modelo não-linear
beta_pot = a1_pot;
alfa_pot = 10^(a2_pot); % Base 10 devido ao log10
fprintf('-> Parametros Originais (Potencia): alfa = %.4f, beta = %.4f\n', alfa_pot, beta_pot);

%% 4. MODELO DE TAXA DE CRESCIMENTO DE SATURAÇÃO
% Equação original: y = alfa * (x / (beta + x))
% Forma Linearizada: 1/y = 1/alfa + (beta/alfa) * (1/x)
% Transformação: X = 1/x | Y = 1/y
X_sat = 1 ./ x;
Y_sat = 1 ./ y;

% Chama a regressão para os dados linearizados
[a1_sat, a2_sat, r2_sat] = regressao_linear(X_sat, Y_sat, 'Crescimento de Saturacao Linearizado');

% Retornando aos parâmetros originais do modelo não-linear
alfa_sat = 1 / a2_sat;
beta_sat = a1_sat * alfa_sat;
fprintf('-> Parametros Originais (Saturacao): alfa = %.4f, beta = %.4f\n', alfa_sat, beta_sat);
