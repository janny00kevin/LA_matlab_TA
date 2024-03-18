function [Ainv] = GJinv(A)
    if isscalar(A)
        if A == 0
            error('Error: Scalar input is zero, inverse does not exist');
        else
            Ainv = 1/A; 
            return;
        end
    end

    [m, n] = size(A);
    if m ~= n
        error('Error: Input matrix must be square');
    end

    aug = [A eye(n)];

    for col = 1:n
        pivot_row = col;
        while pivot_row <= m && aug(pivot_row, col) == 0
            pivot_row = pivot_row + 1;
        end
        
        if pivot_row > m
            error('Error: Matrix is singular, inverse does not exist');
        end
        
        if pivot_row ~= col
            aug([col,pivot_row],:) = aug([pivot_row,col],:);
        end
        
        pivot = aug(col,col);
        aug(col,:) = aug(col,:) / pivot;
        
        for row = 1:m
            if row ~= col
                multiplier = aug(row,col);
                aug(row,:) = aug(row,:) - multiplier * aug(col,:);
            end
        end
    end

    Ainv = aug(:, n+1:end);
end