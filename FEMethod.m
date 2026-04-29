% Warlike Richard da Silva Soares

% Definindo parâmetros.
U_0 = 0
U_L = 0
L = input('Enter the length of the interval: ');
N = input('Enter the number of elements (size of a basis for the ODE): ');
f = input("Enter the polynomial function f(x), (for example, 2x.^2 + 3): ", 's');
f = str2func(['@(x) ' f]);

n = 10^3; % Número de partições; Define a precisão das integrais e derivadas.
h = L/n; % Tamanho de cada partição.
x = 0:h:L; % Vetor de pontos para as integrais e derivadas.

f = f(x); % Calculando os valores de f(x) para cada ponto em x.

% Definindo a base.
basis = zeros(N, n+1);
for i = 1:N
    for j = 1:(n+1)
        basis(i, j) = x(j).^i .* (x(j) - L); % i aqui representa phi_i, e j é cada elemento da partição de phi_i.
    end
end

% Calculando derivadas da base.
dbasis = zeros(N, n+1);
for i = 1:N
    for j = 1:(n+1)
        dbasis(i, j) = i .* (x(j).^(i-1)) .* (x(j) - L) + x(j).^i; % i aqui representa a derivada de phi_i, e j é cada elemento da partição de d_phi_i.
    end
end

% Calculando valores da matriz A.
A = zeros(N, N);

for i = 1:N
    for j = 1:N
        A(i, j) = trapz(x, dbasis(i, :).*dbasis(j, :));
    end
end

% Calculando b, tal que Ax = b.
b = zeros(N, 1);

for i = 1:N
    b(i) = -trapz(x, f.*basis(i, :)); % Calculando a integral de f(x)*phi_i(x) para cada i.
end

% Resolvendo o sistema linear Ax = b.
result = A\b;

log1 = "A função u é igual a: u(x) = ";
functionlog = "";
for i = 1:N
    termo = sprintf("%g*phi_%d(x)", result(i), i);
    if i != 1
        if  result(i) >= 0
            functionlog = [functionlog, " + ", termo];
        else
            functionlog = [functionlog, " ", termo];
        endif
    else
        functionlog = [functionlog, termo];
    endif
end

disp([log1, functionlog]);
