function inverse_matrix = inverse_gauss_jordan(C)
    % Check if the matrix is square
    [m, n] = size(C);
    if m ~= n
        error('Matrix must be square');
    end

    % Augment C with identity matrix
    augmented_matrix = [C, eye(n)];

    % Apply Gauss-Jordan elimination to transform C into reduced row-echelon form
    for col = 1:n
        % Partial pivoting to avoid division by zero
        [~, pivot_row] = max(abs(augmented_matrix(col:end, col)));
        pivot_row = pivot_row + col - 1;

        if pivot_row ~= col
            % Swap rows
            augmented_matrix([col, pivot_row], :) = augmented_matrix([pivot_row, col], :);
        end

        if augmented_matrix(col, col) == 0
            error('Matrix is singular, it does not have an inverse');
        end

        % Make the diagonal element 1
        augmented_matrix(col, :) = augmented_matrix(col, :) / augmented_matrix(col, col);

        % Make the elements above and below the diagonal zero
        for row = 1:n
            if row ~= col
                factor = augmented_matrix(row, col);
                augmented_matrix(row, :) = augmented_matrix(row, :) - factor * augmented_matrix(col, :);
            end
        end
    end

    % Extract the inverse matrix from the augmented matrix
    inverse_matrix = augmented_matrix(:, n+1:end);
end
