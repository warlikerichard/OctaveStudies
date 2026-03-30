% Solução numérica da EDO usando método backward

tic; % Iniciando o cronômetro para medir o tempo de execução do código.

% Definindo variáveis
coef_a = 1;
coef_b = 2;
coef_c = 1;
L = 10; % Comprimento do domínio
U_0 = 3;
U_L = 11;
N_p = 10000; % Número de partições
N_points = N_p + 1; % Número de pontos
h = L / N_p; % Tamanho de cada partição
x = 0:h:L; % Malha

% Matriz do sistema linear
MAT = zeros(N_points, N_points);

% Vetor imagem
Img = zeros(N_points, 1);

% Condições de contorno
Img(1) = U_0;
Img(N_points) = U_L;

% Componentes que multiplicam u(x-h), u(x) e u(x+h) respectivamente
A = coef_a / h^2;
B = -2 * coef_a / h^2  - coef_b / h;
C = coef_a / h^2 + coef_b / h + coef_c;

%Construindo a matriz A do sistema linear
for i = 1:N_points
    if i == 1
        MAT(1, 1) = 1;
    elseif i == N_points
        MAT(N_points, N_points) = 1;
    else
        MAT(i, i-1) = A;
        MAT(i, i) = B;
        MAT(i, i+1) = C;
    endif
endfor

% Resultado do sistema linear
Y = MAT \ Img;

% Solução analítica da EDO
an_solution = solucao_analitica(coef_a, coef_b, coef_c, U_0, U_L, L);
an_image = an_solution(x)'; % Transpondo para que seja um vetor coluna, como Y.

% Plotando gráfico de u(x)
figure;
plot(x, an_solution(x), "g", "LineWidth", 1.5);
title("Aproximação numérica de u(x)");
xlabel("x");
ylabel("u(x)");
hold on;
plot(x, Y, "b", "LineWidth", 1.5);
hold on;
plot(x, (abs(an_image - Y)), "r", "LineWidth", 1.5);
legend("Solução analítica", "Solução numérica", "Erro", "location", "best");
toc % Parando o cronômetro e mostrando o tempo de execução do código.
pause;