function [Ainv] = GJinv(A)
    
    [m, n] = size(A);
    
    if m ~= n
        error('Matrix must be square');
    else
        
        B = eye(m);
        aug_matrix = [A B];
        % disp(det(A));
        for i = 1:m
            % disp(aug_matrix);
            % disp(i);
            % if pivot is zero, then exchange rows
    
            if abs( aug_matrix(i, i) ) <= 1e-23
    
                k = find(aug_matrix(i+1:end, i), 1) + i;
                % disp(k);
                if isempty(k)
                    error('Matrix is singular');
                    return;
                end
    
                aug_matrix([i k], :) = aug_matrix([k i], :);
            end
    
            pivot = aug_matrix(i, i);
            aug_matrix(i, :) = aug_matrix(i, :) / pivot;
    
            % Eliminate the non-zero elements below and above the pivot
            B = eye(m);
            B(i+1:end, i) = -aug_matrix(i+1:m, i);
            B(1:i-1, i) = -aug_matrix(1:i-1, i);
            aug_matrix = B * aug_matrix;
    
        end
        Ainv = aug_matrix(:, n+1:end);
    
    end

end




