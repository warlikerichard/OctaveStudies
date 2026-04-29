% Função para encontrar a solução analítica da EDO.
function y = solucao_analitica(coef_alpha, coef_beta, coef_gamma, f_0, f_L, L, X)

% Calculando o discriminante da equação característica.
delta = coef_beta^2 - 4*coef_alpha*coef_gamma;

% Caso delta seja maior que zero, temos raízes reais distintas.
if (delta > 0)
    r1 = (-coef_beta + sqrt(delta)) / (2*coef_alpha);
    r2 = (-coef_beta - sqrt(delta)) / (2*coef_alpha);

    % Sistema linear resolvido (C1 e C2).
    % [e^(r1*0)  e^(r2*0) ] [C1]   [f_0]
    % [e^(r1*L)  e^(r2*L) ] [C2] = [f_L]
    A_matrix = [1, 1; exp(r1*L), exp(r2*L)];
    consts = A_matrix \ [f_0; f_L];
    C1 = consts(1);
    C2 = consts(2);

    % Avaliar a solução nos pontos X
    y = C1*exp(r1*X) + C2*exp(r2*X);


% Caso delta seja menor que zero, temos raízes complexas conjugadas.
elseif (delta < 0)
    r1 = (-coef_beta + sqrt(delta)) / (2*coef_alpha);
    r2 = (-coef_beta - sqrt(delta)) / (2*coef_alpha);

    a = real(r1); % Parte real da raiz.
    b = abs(imag(r1)); % Parte imaginária da raiz.

    % Sistema linear resolvido (C1 e C2).
    % [e^(a*0)*cos(b*0)  e^(a*0)*sin(b*0)] [C1]   [f_0]
    % [e^(a*L)*cos(b*L)  e^(a*L)*sin(b*L)] [C2] = [f_L]
    A_matrix = [1, 0; exp(a*L)*cos(b*L), exp(a*L)*sin(b*L)];
    consts = A_matrix \ [f_0; f_L];

    C1 = consts(1);
    C2 = consts(2);

    % Avaliar a solução nos pontos X.
    y = C1*exp(a*X).*cos(b*X) + C2*exp(a*X).*sin(b*X);


% Caso delta seja igual a zero, temos uma raiz real dupla.
else
    r = -coef_beta / (2*coef_alpha);

    % Sistema linear resolvido (C1 e C2).
    % [e^(r*0)      0*e^(r*0)  ] [C1]   [f_0]
    % [e^(r*L)      L*e^(r*L)  ] [C2] = [f_L]
    A_matrix = [1, 0; exp(r*L), L*exp(r*L)];
    consts = A_matrix \ [f_0; f_L];

    C1 = consts(1);
    C2 = consts(2);

    y = (C1 + C2*X).*exp(r*X);
endif
endfunction
