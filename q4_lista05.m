x_val = pi/4;
h = pi/12;
f4 = @(x) cos(x);
df4_exato = -sin(x_val);

fprintf('Valor exato da derivada: %.5f\n', df4_exato);

% Diferenca Progressiva O(h)
df_prog_1 = (f4(x_val + h) - f4(x_val)) / h;
err_prog_1 = erro_rel(df_prog_1, df4_exato);
fprintf('Prog. O(h): %.5f | Erro: %.3f%%\n', df_prog_1, err_prog_1);

% Diferenca Progressiva O(h^2)
df_prog_2 = (-f4(x_val + 2*h) + 4*f4(x_val + h) - 3*f4(x_val)) / (2*h);
err_prog_2 = erro_rel(df_prog_2, df4_exato);
fprintf('Prog. O(h^2): %.5f | Erro: %.3f%%\n', df_prog_2, err_prog_2);

% Diferenca Regressiva O(h)
df_reg_1 = (f4(x_val) - f4(x_val - h)) / h;
err_reg_1 = erro_rel(df_reg_1, df4_exato);
fprintf('Regr. O(h): %.5f | Erro: %.3f%%\n', df_reg_1, err_reg_1);

% Diferenca Regressiva O(h^2)
df_reg_2 = (3*f4(x_val) - 4*f4(x_val - h) + f4(x_val - 2*h)) / (2*h);
err_reg_2 = erro_rel(df_reg_2, df4_exato);
fprintf('Regr. O(h^2): %.5f | Erro: %.3f%%\n', df_reg_2, err_reg_2);

% Diferenca Centrada O(h^2)
df_cent_2 = (f4(x_val + h) - f4(x_val - h)) / (2*h);
err_cent_2 = erro_rel(df_cent_2, df4_exato);
fprintf('Centrada O(h^2): %.5f | Erro: %.3f%%\n\n', df_cent_2, err_cent_2);
