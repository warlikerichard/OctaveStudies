function u = sol_an_f(f, x, U_0, U_L)
    % Resolve u'' = f(x) com u(0) = U_0 e u(L) = U_L
    int_f = cumtrapz(x, f);       % integral de f de 0 ate x

    % Segunda integral: u(x) = U_0 + c1*x + integral(int_f, 0, x)
    int_int_f = cumtrapz(x, int_f);

    % Aplicando u(L) = U_L para encontrar c1:
    % U_L = U_0 + c1*x(end) + int_int_f(end)
    c1 = (U_L - U_0 - int_int_f(end)) / x(end);

    % Solução completa
    u = U_0 + c1 .* x + int_int_f;
endfunction