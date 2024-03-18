function Ainv = GJinv(A)
    [r,c] = size(A);
    if r ~= c
        msg='It is not invertible.';
        error(msg) 
    end

    Ainv = eye(r); % Initialize the inverse matrix as the identity matrix

    for j = 1:r
        % Find the pivot element
        pivot = A(j, j);
        if pivot == 0
            disp('Error');
            Ainv = [];
            return
        end

        % Scale the row to make the pivot element 1
        A(j, :) = A(j, :) / pivot;
        Ainv(j, :) = Ainv(j, :) / pivot;

        % Perform row operations to make other elements in the column zero
        for i = 1:r
            if i ~= j
                factor = A(i, j);
                A(i, :) = A(i, :) - factor * A(j, :);
                Ainv(i, :) = Ainv(i, :) - factor * Ainv(j, :);
            end
        end
    end
end
