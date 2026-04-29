function u_x = sol_an(alpha, beta, gamma, u0, uL, L, X)
    delta = beta^2 - 4*alpha*gamma;

    if abs(delta) < 1e-12        % raízes reais repetidas
        r1 = -beta / (2*alpha);
        c1 = u0;
        c2 = (uL * exp(-r1*L) - c1) / L;
        u_x = (c1 + c2 * X) .* exp(r1 * X);

    elseif delta > 0             % raízes reais distintas
        r1 = (-beta + sqrt(delta)) / (2*alpha);
        r2 = (-beta - sqrt(delta)) / (2*alpha);
        M = [1, 1; exp(r1*L), exp(r2*L)];
        c = M \ [u0; uL];
        u_x = c(1) * exp(r1 * X) + c(2) * exp(r2 * X);

    else                         % raízes complexas (delta < 0)
        p = -beta / (2*alpha);
        q = sqrt(-delta) / (2*alpha);   % parte imaginária, sempre real e positiva
        c1 = u0;
        c2 = (uL * exp(-p*L) - c1 * cos(q*L)) / sin(q*L);
        u_x = exp(p * X) .* (c1 * cos(q * X) + c2 * sin(q * X));
    end
end