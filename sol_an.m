function u_x = sol_an(alpha, beta, gamma, u0, uL, L, X)
    % Resolve alpha*u'' + beta*u' + gamma*u = 0 com u(0)=u0 e u(L)=uL
    
    % 1. Encontrar as raízes da equação característica
    % delta = beta^2 - 4*alpha*gamma
    delta = beta^2 - 4*alpha*gamma;
    r1 = (-beta + sqrt(delta)) / (2*alpha);
    r2 = (-beta - sqrt(delta)) / (2*alpha);

    % 2. Resolver o sistema para as constantes c1 e c2
    if abs(delta) < 1e-12 % Raízes reais repetidas (Delta = 0)
        % u(x) = (c1 + c2*x) * exp(r1*x)
        % u(0) = c1 = u0
        % u(L) = (c1 + c2*L) * exp(r1*L) = uL
        c1 = u0;
        c2 = (uL * exp(-r1*L) - c1) / L;
        u_x = (c1 + c2 * X) .* exp(r1 * X);

    elseif isreal(delta) % Raízes reais distintas (Delta > 0)
        % u(x) = c1*exp(r1*x) + c2*exp(r2*x)
        % [1  1 ; exp(r1*L)  exp(r2*L)] * [c1; c2] = [u0; uL]
        A = [1, 1; exp(r1*L), exp(r2*L)];
        B = [u0; uL];
        c = A \ B;
        u_x = c(1) * exp(r1 * X) + c(2) * exp(r2 * X);

    else % Raízes complexas (Delta < 0)
        % r = p +/- iq
        p = real(r1);
        q = imag(r1);
        % u(x) = exp(p*x) * (c1*cos(q*x) + c2*sin(q*x))
        % u(0) = 1*(c1*1 + 0) = u0 => c1 = u0
        % u(L) = exp(p*L) * (c1*cos(q*L) + c2*sin(q*L)) = uL
        c1 = u0;
        c2 = (uL * exp(-p*L) - c1 * cos(q * L)) / sin(q * L);
        u_x = exp(p * X) .* (c1 * cos(q * X) + c2 * sin(q * X));
    end
end