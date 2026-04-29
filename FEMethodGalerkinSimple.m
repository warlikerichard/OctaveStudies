% Warlike Richard da Silva Soares

% Definindo parâmetros.
U_0 = 0;
U_L = 0;
L = 25;
N = 1000;

h = L/(N - 1); % Tamanho de cada partição.
x = linspace(0, L, N); % Vetor de pontos para as integrais e derivadas.
f = x.^2 + 3.*x + 2;

% Definindo a base.
basis = eye(N); % Base canônica, onde cada phi_i é 1 em um ponto específico e 0 nos outros.

% Calculando valores da matriz A.
A = zeros(N, N);
A(1, 1) = 1; % Condição de contorno em x=0.
A(N, N) = 1; % Condição de contorno em x=L.

for i = 2:(N-1)
    A(i, i-1) = -1/h; % Contribuição de phi_(i-1) para a derivada de phi_i.
    A(i, i) = 2/h; % Contribuição de phi_i para a derivada de phi_i.
    A(i, i+1) = -1/h; % Contribuição de phi_(i+1) para a derivada de phi_i.
end

% Calculando b, tal que Ax = b.
b = zeros(N, 1);

for i = 1:N
    b(i) = -trapz(x, f.*basis(i, :)); % Calculando a integral de f(x)*phi_i(x) para cada i.
end

b(1) = U_0; % Condição de contorno em x=0.
b(2) = b(2) -A(2, 1)*U_0; % Contribuição da condição de contorno em x=0 para o segundo ponto.
b(N-1) = b(N-1) -A(N-1, N)*U_L; % Contribuição da condição de contorno em x=L para o penúltimo ponto.
b(N) = U_L; % Condição de contorno em x=L.

A(2, 1) = 0; % Ajuste para a condição de contorno em x=0.
A(N-1, N) = 0; % Ajuste para a condição de contorno em x=L.

% Resolvendo o sistema linear Ax = b.
result = A\b;
result_an = sol_an_f(f, x, U_0, U_L); % Solução analítica para comparação.

% Plot
figure;
plot(x, result, 'b-', 'LineWidth', 2, 'DisplayName', 'Solução Numérica');
hold on;
plot(x, result_an, 'r--', 'LineWidth', 2, 'DisplayName', 'Solução Analítica');
hold off;
xlabel('x');
ylabel('u(x)');
title('Comparação: Solução Numérica vs Solução Analítica');
legend('Location', 'best');
grid on;
pause;