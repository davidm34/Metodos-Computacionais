f5 = @(x,y) x.^2 - 3.*y.^2 + x.*y.^3;
I5_exato = 64/3;
fprintf('a) Valor Analitico Exato: %.5f\n', I5_exato);

% Limites e pontos
hx = (2 - (-2)) / 2; % n=2 -> hx=2
hy = (4 - 0) / 2;    % n=2 -> hy=2
X = -2:hx:2; % [-2, 0, 2]
Y = 0:hy:4;  % [0, 2, 4]

% Matriz de valores f(x,y)
Z = zeros(length(X), length(Y));
for i = 1:length(X)
    for j = 1:length(Y)
        Z(i,j) = f5(X(i), Y(j));
    end
end

% b) Aplicação múltipla do trapézio (n=2) nas duas direções
Iy_trap = zeros(1, length(X));
for i = 1:length(X)
    % Integra em y para um x fixo usando Trapezio n=2
    Iy_trap(i) = (hy/2) * (Z(i,1) + 2*Z(i,2) + Z(i,3));
end
% Integra os resultados em x
I5_trap = (hx/2) * (Iy_trap(1) + 2*Iy_trap(2) + Iy_trap(3));
fprintf('b) Integral Dupla (Trapezio n=2): %.5f | Erro: %.3f%%\n', I5_trap, erro_rel(I5_trap, I5_exato));

% c) Aplicação única de Simpson 1/3 nas duas direções (nota: n=2 pontos = 1 aplicacao simples)
Iy_simp = zeros(1, length(X));
for i = 1:length(X)
    % Integra em y para um x fixo usando Simpson 1/3 (n=2)
    Iy_simp(i) = (hy/3) * (Z(i,1) + 4*Z(i,2) + Z(i,3));
end
% Integra os resultados em x
I5_simp = (hx/3) * (Iy_simp(1) + 4*Iy_simp(2) + Iy_simp(3));
fprintf('c) Integral Dupla (Simpson 1/3 n=2): %.5f | Erro: %.3f%%\n', I5_simp, erro_rel(I5_simp, I5_exato));
