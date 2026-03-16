t = 0:2*pi/99:2*pi; # Cria um vetor de 100 pontos entre 0 e 2*pi
f = exp(-0.1*t) .* sin(t);

figure;
plot(t, f);
title("Função Exponencial Decrescente Multiplicada por Seno");
xlabel("t");
ylabel("f(t)");
grid on;

disp('Gráfico plotado! Pressione Enter para fechar...');
pause;