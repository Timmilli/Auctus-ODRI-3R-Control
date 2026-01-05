function disp_eqs(A, B)
if length(A) ~= length(B) || length(A(1)) ~= length(B(1))
    disp('Error: Dimensions of A and B are different.')
    return;
end
for i = 1:length(A)
    for j = 1:length(A(1))
        fprintf('(%d, %d) %s = %s\n', i, j, A(i, j), B(i, j));
    end
end
end