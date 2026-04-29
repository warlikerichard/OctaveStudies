disp("Vamos resolver a EDO do tipo alpha * u''(x) + beta * u'(x) + gamma * u(x) = 0 usando o método de elementos finitos.");

a = input("Digite o valor de alpha: ");
b = input("Digite o valor de beta: ");
c = input("Digite o valor de gamma: ");

L = input("Digite o comprimento do intervalo [0, L]: ");
N = input("Digite o número de elementos na base de H1: ");

h = L/(N - 1); % Tamanho de cada elemento.

U_0 = input("Digite o valor de u(0): ");
U_L = input("Digite o valor de u(L): ");

X = linspace(0, L, N); % Vetor de pontos para a base de H1, que vai ter N pontos, incluindo os extremos 0 e L.

A = zeros(N);
A(1, 1) = 1; % Condição de contorno em x=0.
A(N, N) = 1; % Condição de contorno em x=L.

% Usaremos as funções chapéu por padrão.

% Vamos definir aqui a matriz global.
for i = 2:(N-1)
    for j = 1:N
        if i == j
            A(i, j) = 2*a/h + c*2*h/3;
        elseif abs(i - j) == 1
            A(i, j) = -a/h + b/2 + c/6;
        endif

    endfor
endfor

b_ls = zeros(N, 1);
b_ls(1) = U_0; % Condição de contorno em x=0.
b_ls(N) = U_L; % Condição de contorno em x=L.

result = A\b_ls;

disp("Os coeficientes da função u(x) na base de H1 são: ");
disp(result);

% Calcular solução analítica
analitica = sol_an(a, b, c, U_0, U_L, L, X);

% Veja que cada coeficiente de result representa o valor de u(x) na base de H1, já que cada phi_i só tem valor 1 em um ponto específico e 0 nos outros.

figure;
plot(X, result, 'b-o', 'LineWidth', 2, 'MarkerSize', 5, 'DisplayName', 'Solução Numérica (Galerkin)');
hold on;
plot(X, analitica, 'r-s', 'LineWidth', 2, 'MarkerSize', 5, 'DisplayName', 'Solução Analítica');
hold off;
title("Comparação: Solução Numérica vs Solução Analítica");
xlabel("x");
ylabel("u(x)");
legend('Location', 'best');
grid on;
drawnow;

pause;