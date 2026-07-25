x2 = [0, 0.1, 0.3, 0.5, 0.7, 0.95, 1.2];
fx2 = [1, 0.9048, 0.7408, 0.6065, 0.4966, 0.3867, 0.3012];
a2 = 0; b2 = 1.2;

% a) Exato
I2_exato = 1 - exp(-1.2);
fprintf('a) Analiticamente: %.5f\n', I2_exato);

% b) Trapezio Unico (Apenas usando os extremos x=0 e x=1.2)
h_t2 = 1.2 - 0;
I2_trap_s = h_t2 * (fx2(1) + fx2(7)) / 2;
fprintf('b) Trapezio Unica: %.5f | Erro: %.3f%%\n', I2_trap_s, erro_rel(I2_trap_s, I2_exato));

% c) Combinacao de Trapezio e Simpson
% [0, 0.1]: h=0.1 (Trapezio)
I_c1 = 0.1 * (fx2(1) + fx2(2)) / 2;
% [0.1, 0.7]: h=0.2, 3 segmentos -> Simpson 3/8
I_c2 = (3*0.2/8) * (fx2(2) + 3*fx2(3) + 3*fx2(4) + fx2(5));
% [0.7, 1.2]: h=0.25, 2 segmentos -> Simpson 1/3
I_c3 = (0.25/3) * (fx2(5) + 4*fx2(6) + fx2(7));
I2_comb = I_c1 + I_c2 + I_c3;
fprintf('c) Combinacao Trapezio+Simpson: %.5f | Erro: %.3f%%\n\n', I2_comb, erro_rel(I2_comb, I2_exato));
