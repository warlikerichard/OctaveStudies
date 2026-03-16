disp("Vamos achar a função f:[0, 1] -> R tal que\na.f''(x) + b.f'(x) + c.f(x) = 0\n");
a_f = input("Digite o valor de a: ");
b_f = input("Digite o valor de b: ");
c_f = input("Digite o valor de c: ");

f_0 = input("Digite o valor de f(0): ");
f_1 = input("Digite o valor de f(1): ");

delta = b_f^2 - 4*a_f*c_f;

if (delta > 0)
    r1 = (-b_f + sqrt(delta))/(2*a_f);
    r2 = (-b_f - sqrt(delta))/(2*a_f);

    % Sistema linear resolvido (C1 e C2)
    consts = [e^(r1*0), e^(r2*0); 
              e^(r1*1), e^(r2*1)]\[f_0; f_1];
    C1 = consts(1);
    C2 = consts(2);

    fprintf("\nC1 = %f\n", C1);
    fprintf("C2 = %f\n", C2);

    %Resultado
    f = @(x) C1*e^(r1*x) + C2*e^(r2*x) % Função anônima que pode ser usada para encontrar os valores de f(x)
    fprintf("\nResultado: f(x) = %.2f*e^(%.2f*x) + %.2f*e^(%.2f*x)\n", C1, r1, C2, r2);

elseif (delta < 0)
    r1 = (-b_f+ sqrt(delta))/(2*a_f); % Só usamos essa parte, mas declarei r2 para fins didáticos.
    r2 = (-b_f - sqrt(delta))/(2*a_f); % Podemos usar essa raiz também, sem problemas.

    a = real(r1); % Parte real da raiz
    b = abs(imag(r1)); % Parte imaginária da raiz

    % Sistema linear resolvido
    consts = [e^(a*0)*cos(b*0), e^(real(r2)*0)*sin(b*0);
              e^(a*1)*cos(b*1), e^(real(r2)*1)*sin(b*1)]\[f_0; f_1];
    
    C1 = consts(1);
    C2 = consts(2);

    fprintf("\nC1 = %f\n", C1);
    fprintf("C2 = %f\n", C2);

    % Função pronta para uso
    f = @(x) C1 * e^(a*x)*cos(b*x) + e^(real(r2)*x)*sin(b*x)

    fprintf("Resultado: f(x) = %.2f*e^(%.2f*x)*cos(%.2f*x) + %.2f*e^(%.2f*x)*sen(%.2f*x)\n", C1, a, b, C2, a, b);
else
    r = -b_f/(2*a_f);

    % Sistema linear resolvido
    consts = [e^(r*0), e^(r^0);
              e^(r*1), e^(r*1)]\[f_0; f_1];
    
    C1 = consts(1);
    C2 = consts(2);

    % Função pronta para uso
    f = @(x) (C1 + C2*x) * e^(r*x) 

    fprintf("Resultado: f(x) = (%.2f + %.2f*x) * e^(%.2f*x)\n", C1, C2, r);
endif