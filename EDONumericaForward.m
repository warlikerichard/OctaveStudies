% Solução numérica da EDO usando método forward.
function [x, Y, tempo] = EDONumericaForward(coef_a, coef_b, coef_c, U_0, U_L, L, N_p)

if nargin == 0
    coef_a = 1;
    coef_b = 2;
    coef_c = 1;
    U_0 = 3;
    U_L = 11;
    L = 10;
    N_p = 10000;
endif

tic;

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
B = -2 * coef_a / h^2 - coef_b / h + coef_c;
C = coef_a / h^2 + coef_b / h;

% Construindo a matriz do sistema linear
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

tempo = toc;

% Se a saída não foi atribuída a nenhuma variável, plota o resultado e compara com a solução analítica.
if nargout == 0
    an_solution = solucao_analitica(coef_a, coef_b, coef_c, U_0, U_L, L);
    an_image = an_solution(x)';

    figure;
    plot(x, an_solution(x), "g", "LineWidth", 1.5);
    title("Aproximação numérica de u(x) - Forward");
    xlabel("x");
    ylabel("u(x)");
    hold on;
    plot(x, Y, "b", "LineWidth", 1.5);
    plot(x, abs(an_image - Y), "r", "LineWidth", 1.5);
    legend("Solução analítica", "Solução numérica", "Erro", "location", "best");
    pause;
endif

endfunction