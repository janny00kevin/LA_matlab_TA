function [Ainv] = GJinv(A)
% Calculate inverse of matrix A using GJ elimination
    [w, l] = size(A);
    if (w ~= l)
        error('A is not a square matrix.');
    elseif (w == 1)
        Ainv = 1 / A;
        return
    end
    A = sym(A); % 1.333 is now 4/3
    M = [A eye(w)]; % augmented matrix
%     disp(M);
    % turn A into upper triangle matrix
    for i=1:w-1 % for each row i
        for j=i+1:w % for each row j under row i
            if (M(i,i) == 0) % if pivot i is 0
                temp = M(i,:); % exchange row i and j
                M(i,:) = M(j,:);
                M(j,:) = temp;
%                 fprintf('exchange row %d with row %d\n',i,j);
%                 disp(M); % display row change
            end
        end
        if (M(i,i) == 0) % if pivot is still 0
            error('A is not invertible. Missing pivot(s).');
        end
        for j=i+1:w % eliminate row j's with row i
            M(j,:) = M(j,:) - M(i,:) * (M(j,i) / M(i,i));
        end
%         fprintf('eliminate all terms under row %d pivot\n',i);
%         disp(M); % display elimination
    end
%     disp('----------------------------');
    % turn A into diagonal matrix
    for i=w:-1:2 % for each row i (starting from the bottom)
        for j=i-1:-1:1 % for each row j above row i
            M(j,:) = M(j,:) - M(i,:) * (M(j,i) / M(i,i));
        end
%         fprintf('eliminate all terms above row %d pivot\n',i);
%         disp(M); % display elimination
    end
    % turn A into identity matrix
    for i=1:w
        M(i,:) = M(i,:) ./ M(i,i);
    end
%     disp('apply scaling matrix');
%     disp(M); % display scaling
    Ainv = M(:, w+1:end); % get submatrix
    Ainv = vpa(Ainv, 6); % 4/3 is now 1.333333
end