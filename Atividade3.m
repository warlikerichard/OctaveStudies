interval = 0:1:9; # Vetor de 0 a 9 com 10 elementos

result = [];
for num = interval
    result = [result, 1/factorial(num)];
endfor

disp('Aproximation of e:');
disp(sum(result));

disp('Real e value:');
disp(e);