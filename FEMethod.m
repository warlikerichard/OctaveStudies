% Definindo parâmetros.
U_0 = 0
U_L = 0
L = input('Enter the length of the interval: ');
N = input('Enter the number of elements (size of a basis for the ODE): ');
f = input("Enter the polynomial function f(x), (for example, 2x.^2 + 3): ", 's');
f = str2func(['@(x) ' f]);

% Definindo a base.
basis = {};
for i = 1:N
    basis{end + 1} = @(x) x.^(i).*(x-L);
end

% Calculando derivadas da base.
dbasis = {}
for i = 1:N
    dbasis{end + 1} = @(x) (i)*x.^(i-1).*(x-L) + x.^(i);
end

% Calculando valores da matriz A.
A = zeros(N, N);

for i = 1:N
    for j = 1:N
        A(i, j) = integral(@(x) dbasis{i}(x).*dbasis{j}(x), 0, L);
    end
end

% Calculando b, tal que Ax = b.
b = zeros(N, 1);

for i = 1:N
    b(i) = -integral(@(x) f(x).*basis{i}(x), 0, L);
end

% Resolvendo o sistema linear Ax = b.
result = A\b;

log1 = "A função u é igual a: u(x) = ";
functionlog = "";
for i = 1:N
    termo = sprintf("%g*phi_%d(x)", result(i), i);
    if i != 1
        functionlog = [functionlog, " + ", termo];
    else
        functionlog = termo;
    endif
end

disp([log1, functionlog]);
