function [Ainv] = GJinv(A)
    % To get the size of A, see if it's square matrix
    [m,n] = size(A);
    if (m ~= n || isempty(A))
        error("There's no inverse for this.")
    end

    % Get the # of rows, make the augmented matrix
    aug = [A eye(m)];
    
    % Sort the matrix and do GJ
    for i = 1:m
        pivot = aug(i,i);
        if abs(pivot) < eps
            for j = (i + 1):m
                if abs(aug(i, j)) > eps
                    aug([i j], :) = aug([j i], :);
                    pivot = aug(i,i);
                end % Do row exchange if the original entry(i,i) is 0
            end
            if abs(pivot) < eps
                error("There's no inverse for this.")
                % There's no inverse if a collumn has no pivot
            end
        end

        % Make the pivot be 1
        aug(i,:) = aug(i,:) ./ pivot;
        
        % Do the row elimination
        for j = i + 1:m
            factor = aug(j, i);
            aug(j,:) = aug(j, :) - (aug(i,:) .* factor);
        end
    end

    % Do back substitution
    for i = 1:m
        idx = m-i+1;
        for j = 1:idx - 1
            factor = aug(j, idx);
            aug(j,:) = aug(j, :) - (aug(idx,:) * factor);
        end
    end
    % disp("This is a square matrix.")
    % Take the inverse out
    Ainv = aug(:, m+1:end);
end
