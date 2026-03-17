%{ 
Este código recebe os coeficientes a, b e c de uma equação diferencial ordinária de segunda ordem, 
assim como as condições de contorno f(0) e f(L). Ele então calcula as raízes da equação característica 
associada à EDO e, dependendo do valor do discriminante (delta), determina a forma da solução geral da EDO.
%}

% Limite superior fixo do intervalo [0, L].
L = 1;

% Recebendo os valores através do input do usuário.
disp("Vamos achar a função f:[0, L] -> R tal que\nalpha.f''(x) + beta.f'(x) + gamma.f(x) = 0\n");
coef_alpha = input("Digite o valor de alpha: ");
coef_beta = input("Digite o valor de beta: ");
coef_gamma = input("Digite o valor de gamma: ");

% Condições de contorno no intervalo [0, L].
f_0 = input("Digite o valor de f(0): ");
f_L = input("Digite o valor de f(L): ");

% Calculando o discriminante da equação característica.
delta = coef_beta^2 - 4*coef_alpha*coef_gamma;

% Caso delta seja maior que zero, temos raízes reais distintas.
if (delta > 0)
    r1 = (-coef_beta + sqrt(delta))/(2*coef_alpha);
    r2 = (-coef_beta - sqrt(delta))/(2*coef_alpha);

    % Sistema linear resolvido (C1 e C2).
    consts = [e^(r1*0), e^(r2*0); 
              e^(r1*L), e^(r2*L)]\[f_0; f_L];
    C1 = consts(1);
    C2 = consts(2);

    % Função anônima que pode ser usada para encontrar os valores de f(x)
    f = @(x) C1*e^(r1*x) + C2*e^(r2*x)

    % Resultado
    fprintf("\nResultado: f(x) = %.2f*e^(%.2f*x) + %.2f*e^(%.2f*x)\n", C1, r1, C2, r2);

% Caso delta seja menor que zero, temos raízes complexas conjugadas.
elseif (delta < 0)
    r1 = (-coef_beta+ sqrt(delta))/(2*coef_alpha); % Só usamos essa parte, mas declarei r2 para fins didáticos.
    r2 = (-coef_beta - sqrt(delta))/(2*coef_alpha); % Podemos usar essa raiz também, sem problemas.

    a = real(r1); % Parte real da raiz.
    b = abs(imag(r1)); % Parte imaginária da raiz.

    % Sistema linear resolvido (C1 e C2).
    consts = [e^(a*0)*cos(b*0), e^(real(r2)*0)*sin(b*0);
              e^(a*L)*cos(b*L), e^(real(r2)*L)*sin(b*L)]\[f_0; f_L];
    
    C1 = consts(1);
    C2 = consts(2);

    % Função anônima que pode ser usada para encontrar os valores de f(x).
    f = @(x) C1 * e^(a*x)*cos(b*x) + C2 * e^(real(r2)*x)*sin(b*x) 

    % Resultado.
    fprintf("Resultado: f(x) = %.2f*e^(%.2f*x)*cos(%.2f*x) + %.2f*e^(%.2f*x)*sen(%.2f*x)\n", C1, a, b, C2, a, b);

% Caso delta seja igual a zero, temos uma raiz real dupla.
else
    r = -coef_beta/(2*coef_alpha);

    % Sistema linear resolvido (C1 e C2).
    consts = [e^(r*0), 0*e^(r*0);
              e^(r*L), L*e^(r*L)]\[f_0; f_L];
    
    C1 = consts(1);
    C2 = consts(2);

    % Função anônima que pode ser usada para encontrar os valores de f(x).
    f = @(x) (C1 + C2*x) * e^(r*x) 

    % Resultado.
    fprintf("Resultado: f(x) = (%.2f + %.2f*x) * e^(%.2f*x)\n", C1, C2, r);
endif