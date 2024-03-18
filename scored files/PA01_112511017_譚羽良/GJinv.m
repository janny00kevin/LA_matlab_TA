function [Ainv] = GJinv(A)
    [m, n] = size(A);
    % Check if A is a scalar
    if m==1 && n==1
        if abs(A) < eps
            error('Matrix is singular');
        else
            Ainv = 1/A;
            return;
        end
    % Check if A is square
    elseif m~=n
        error('Matrix is rectangular');
    end
        
    

    % Augment the matrix with the identity matrix
    Aaug = [A, eye(m)];
    
    % Perform Gauss-Jordan elimination
    for i = 1:m
        % Find the pivot row index using find
        [pivot_row_index, ~] = find(Aaug(i:m, i), 1, 'first');
        
        % Adjust index relative to the entire matrix
        pivot_row_index = pivot_row_index + i - 1; 
        
        % Check if the column is all zeros
        if isempty(pivot_row_index)
            error("Matrix is singular");
        end
        
        % Swap the pivot row with the current row
        Aaug([i, pivot_row_index], :) = Aaug([pivot_row_index, i], :);
        
        % Normalize the pivot row
        Aaug(i, :) = Aaug(i, :) / Aaug(i, i);
        
        % Eliminate the elements below the pivot
        for j = i+1:m
            Aaug(j, :) = Aaug(j, :) - Aaug(j, i) * Aaug(i, :);
        end
    end

    
    % Check if the upper triangular matrix has non-zero elements along its diagonal
    if any(abs(diag(Aaug(:, 1:n))) < eps) 
        error('Matrix is singular');
    end

    % Eliminate the elements below the pivot
    for i = m:-1:1
        for j = i-1:-1:1
            Aaug(j, :) = Aaug(j, :) - Aaug(j, i) * Aaug(i, :);
        end
    end
    
    % Extract the inverse matrix from the augmented matrix
    Ainv = Aaug(:, m+1:end);
end

