function Ainv = GJinv(A)
    % Set a small number epsilon to handle numerical instability
    epsilon = 1e-10;

    % Get the size of the input matrix
    [m, n] = size(A);

    % Check if the matrix is square
    if m ~= n
        error('Matrix must be square.');
    end

    % Check for scalar matrix
    if m == 1
        % If the matrix is a scalar, check if it's zero (singular) or not
        if abs(A) <= epsilon
            error('Matrix is singular.');
        else
            % Compute the inverse of the scalar matrix
            Ainv = 1 / A;
            return;
        end
    end

    % Augment A with the identity matrix of the same size
    augmented = [A eye(m)];

    % Perform Gauss-Jordan elimination
    for i = 1:m
        % Pivoting
        pivot = augmented(i, i);
        if abs(pivot) <= epsilon
            error('Matrix is singular.');
        end
        augmented(i, :) = augmented(i, :) / pivot;

        % Elimination
        for j = 1:m
            if i ~= j
                factor = augmented(j, i);
                augmented(j, :) = augmented(j, :) - factor * augmented(i, :);
            end
        end
    end

    % Extract the inverse from the augmented matrix
    Ainv = augmented(:, n+1:end);
end
