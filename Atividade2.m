A = [3, 2, -1;
    2, -2, 4;
    -1, 0.5, -1];

b = [1; -2; 0];

disp('Matriz A:');
disp(A);
disp('Vetor b:');
disp(b);

disp('Determinante de A:');
disp(det(A));

disp('Solução do sistema Ax = b:');
x = A\b;
disp(x);