% Teste de gráfico com octave-cli
x = 0:0.1:2*pi;
y = sin(x);

figure;
plot(x, y);
title('Função Seno');
xlabel('x');
ylabel('sin(x)');
grid on;

% Pause para manter a janela aberta
disp('Gráfico plotado! Pressione Enter para fechar...');
pause;
