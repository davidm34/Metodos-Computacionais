f1 = @(x) 8 + 4*cos(x);
a1 = 0;
b1 = pi/2;

% a) Valor Exato
I1_exato = 4*pi + 4;
fprintf('a) Valor Analitico Exato: %.5f\n', I1_exato);

% Funcao anonima para o erro relativo
erro_rel = @(aprox, exato) abs((exato - aprox) / exato) * 100;

% b) Regra do Trapezio Simples (unica)
h_trap_s = b1 - a1;
I1_trap_s = h_trap_s * (f1(a1) + f1(b1)) / 2;
fprintf('b) Trapezio Unica: %.5f | Erro: %.3f%%\n', I1_trap_s, erro_rel(I1_trap_s, I1_exato));

% c) Trapezio Multipla (n=2 e n=4)
for n = [2, 4]
    h = (b1 - a1) / n;
    x = a1:h:b1;
    I1_trap_m = (h/2) * (f1(x(1)) + 2*sum(f1(x(2:end-1))) + f1(x(end)));
    fprintf('c) Trapezio Multipla (n=%d): %.5f | Erro: %.3f%%\n', n, I1_trap_m, erro_rel(I1_trap_m, I1_exato));
end

% d) Simpson 1/3 Simples
h_s13 = (b1 - a1) / 2;
x_s13 = a1:h_s13:b1;
I1_simp13_s = (h_s13/3) * (f1(x_s13(1)) + 4*f1(x_s13(2)) + f1(x_s13(3)));
fprintf('d) Simpson 1/3 Unica: %.5f | Erro: %.3f%%\n', I1_simp13_s, erro_rel(I1_simp13_s, I1_exato));

% e) Simpson 1/3 Multipla (n=4)
n = 4; h = (b1 - a1) / n; x = a1:h:b1;
soma_impar = sum(f1(x(2:2:end-1)));
soma_par = sum(f1(x(3:2:end-2)));
I1_simp13_m = (h/3) * (f1(x(1)) + 4*soma_impar + 2*soma_par + f1(x(end)));
fprintf('e) Simpson 1/3 Multipla (n=4): %.5f | Erro: %.3f%%\n', I1_simp13_m, erro_rel(I1_simp13_m, I1_exato));

% f) Simpson 3/8 Simples
h_s38 = (b1 - a1) / 3;
x_s38 = a1:h_s38:b1;
I1_simp38_s = (3*h_s38/8) * (f1(x_s38(1)) + 3*f1(x_s38(2)) + 3*f1(x_s38(3)) + f1(x_s38(4)));
fprintf('f) Simpson 3/8 Unica: %.5f | Erro: %.3f%%\n', I1_simp38_s, erro_rel(I1_simp38_s, I1_exato));

% g) Simpson Multipla (n=5)
% Combinando Simpson 1/3 nos primeiros 2 segmentos e Simpson 3/8 nos 3 ultimos
n = 5; h = (b1 - a1) / n; x = a1:h:b1;
I_parte1 = (h/3) * (f1(x(1)) + 4*f1(x(2)) + f1(x(3))); % n=2
I_parte2 = (3*h/8) * (f1(x(3)) + 3*f1(x(4)) + 3*f1(x(5)) + f1(x(6))); % n=3
I1_simp_n5 = I_parte1 + I_parte2;
fprintf('g) Simpson Multipla (n=5): %.5f | Erro: %.3f%%\n\n', I1_simp_n5, erro_rel(I1_simp_n5, I1_exato));
