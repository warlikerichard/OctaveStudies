% Função para encontrar a solução analítica da EDO.
function y = solucao_analitica(coef_alpha, coef_beta, coef_gamma, f_0, f_L, L)

% Calculando o discriminante da equação característica.
delta = coef_beta^2 - 4*coef_alpha*coef_gamma;

% Caso delta seja maior que zero, temos raízes reais distintas.
if (delta > 0)
    r1 = (-coef_beta + sqrt(delta))/(2*coef_alpha);
    r2 = (-coef_beta - sqrt(delta))/(2*coef_alpha);

    % Sistema linear resolvido (C1 e C2).
    consts = [exp(r1*0), exp(r2*0);
              exp(r1*L), exp(r2*L)]\[f_0; f_L];
    C1 = consts(1);
    C2 = consts(2);

    % Função anônima que pode ser usada para encontrar os valores de f(x)
    y = @(x) C1*exp(r1*x) + C2*exp(r2*x);


% Caso delta seja menor que zero, temos raízes complexas conjugadas.
elseif (delta < 0)
    r1 = (-coef_beta+ sqrt(delta))/(2*coef_alpha); % Só usamos essa parte, mas declarei r2 para fins didáticos.
    r2 = (-coef_beta - sqrt(delta))/(2*coef_alpha); % Podemos usar essa raiz também, sem problemas.

    a = real(r1); % Parte real da raiz.
    b = abs(imag(r1)); % Parte imaginária da raiz.

    % Sistema linear resolvido (C1 e C2).
    consts = [exp(a*0)*cos(b*0), exp(real(r2)*0)*sin(b*0);
              exp(a*L)*cos(b*L), exp(real(r2)*L)*sin(b*L)]\[f_0; f_L];

    C1 = consts(1);
    C2 = consts(2);

    % Função anônima que pode ser usada para encontrar os valores de f(x).
    y = @(x) C1 * exp(a*x).*cos(b*x) + C2 * exp(real(r2)*x).*sin(b*x);


% Caso delta seja igual a zero, temos uma raiz real dupla.
else
    r = -coef_beta/(2*coef_alpha);

    % Sistema linear resolvido (C1 e C2).
    consts = [exp(r*0), 0*exp(r*0);
              exp(r*L), L*exp(r*L)]\[f_0; f_L];

    C1 = consts(1);
    C2 = consts(2);

    % Função anônima que pode ser usada para encontrar os valores de f(x).
    y = @(x) (C1 + C2*x) .* exp(r*x);
endif
endfunction
