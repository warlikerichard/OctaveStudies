% Compara os métodos forward, backward e centrado para a mesma EDO.

clear;
clc;

% Parâmetros
coef_a = 1;
coef_b = 2;
coef_c = 1;
L = 10;
U_0 = 3;
U_L = 11;
N_p = 100;

% Executa os três métodos numéricos
[xF, yF, tF] = EDONumericaForward(coef_a, coef_b, coef_c, U_0, U_L, L, N_p);
[xB, yB, tB] = EDONumericaBackward(coef_a, coef_b, coef_c, U_0, U_L, L, N_p);
[xC, yC, tC] = EDONumericaCentered(coef_a, coef_b, coef_c, U_0, U_L, L, N_p);

% Solução analítica
an_solution = solucao_analitica(coef_a, coef_b, coef_c, U_0, U_L, L);
an_image = an_solution(xF)';

% Erros absolutos
errF = abs(an_image - yF);
errB = abs(an_image - yB);
errC = abs(an_image - yC);

% Gráfico 1: soluções
figure;
plot(xF, an_solution(xF), "k", "LineWidth", 2.0);
hold on;
plot(xF, yF, "b", "LineWidth", 1.4);
plot(xB, yB, "r", "LineWidth", 1.4);
plot(xC, yC, "m", "LineWidth", 1.4);
title("Comparacao das solucoes numericas");
xlabel("x");
ylabel("u(x)");
grid on;
legend("Analitica", "Forward", "Backward", "Centrado", "location", "best");

% Gráfico 2: erros
figure;
plot(xF, errF, "b", "LineWidth", 1.4);
hold on;
plot(xB, errB, "r", "LineWidth", 1.4);
plot(xC, errC, "m", "LineWidth", 1.4);
title("Erro absoluto por metodo");
xlabel("x");
ylabel("|u_{analitica} - u_{numerica}|");
grid on;
legend("Forward", "Backward", "Centrado", "location", "best");

fprintf("Tempo Forward : %.6f s\n", tF);
fprintf("Tempo Backward: %.6f s\n", tB);
fprintf("Tempo Centrado: %.6f s\n", tC);

pause;
