function[Ainv] = GJinv(A)
    % Get the number of rows and columns of the matrix
    [rows, cols] = size(A);
    
    % Check if the matrix is square
    if rows ~= cols
        error("Matrix must be square");
    end
    
    % Construct the augmented matrix
    aug_matrix = [A, eye(rows)];
    
    % GJ elimination
    for i = 1 : rows
        if abs(aug_matrix(i, i)) < eps

            % Boolean variable "bool" to check non-zero diagonal elements
            bool_invertible = 0;
            for j = i + 1 : rows
                if abs(aug_matrix(j, i)) > eps

                    % The pivot is not 0
                    bool_invertible = 1;
                    aug_matrix(i, :) = aug_matrix(i, :) + aug_matrix(j, :);
                    break
                end
            end
            if ~bool_invertible
                error("This matrix is not invertible");
            end
        end
        % Make every pivot be 1
        pivot = aug_matrix(i, i);
        aug_matrix(i, :) = aug_matrix(i, :) / pivot;
        for j = i + 1 : rows
            x = -1 * aug_matrix(j, i) / aug_matrix(i, i);
            aug_matrix(j, :) = aug_matrix(j, :) + x * aug_matrix(i, :);
        end
    end

    % Back substitution
    for i = rows : -1 : 1
        for j = 1 : (i - 1)
            aug_matrix(j, :) = aug_matrix(j, :) - aug_matrix(j, i) * aug_matrix(i, :);
        end
    end
    
    % Extract the inverse matrix
    Ainv = aug_matrix(:, rows + 1 : 2 * rows);
end