function Ainv = GJinv(A)
    [m, n] = size(A);
    if m ~= n
        error('Not a square matrix!');
    end
    M = [A, eye(n)];
    for i = 1:m
        p = M(i, i);
        if p == 0
            valid = find(M(i+1:end, i), 1) + i;
            if isempty(valid)
                error('Uninvertible!');
            end
            M([i, valid], :) = M([valid, i], :);
            p = M(i, i);
        end
        for j = 1:m
            if j ~= i
                mult = M(j, i) / p;
                M(j, :) = M(j, :) - mult * M(i, :);
            end
        end
    end
    for i = 1:m
        M(i, :) = M(i, :) / M(i, i);
    end
    Ainv = M(:, n+1:end);
end