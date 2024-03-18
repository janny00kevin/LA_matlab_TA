function Ainv = GJinv(A)
    % 檢查是否為方陣
    [m, n] = size(A);
    if m ~= n
        error('Matrix must be square for inversion.');
    end

    % 檢查是否為scalar matrix
    if isscalar(A)
        % 若為0的話是invertible
        if A == 0
            error('Matrix is not invertible .');
        else
            Ainv = 1/A;
            return;
        end
    end   
    
    %生出增廣
    Aug = [A, eye(m)];

    for col = 1:m
        % 找到主對角線上非零的行數
        pivotRow = find(Aug(col:end, col), 1) + col - 1;   
        % 把原本的跟找到的交換
        Aug([col, pivotRow], :) = Aug([pivotRow, col], :);
        % 讓pivot變成1
        Aug(col, :) = Aug(col, :) / Aug(col, col);
        % 把剩下的變成0
        for row = 1:m
            if row ~= col
                Aug(row, :) = Aug(row, :) - Aug(row, col) * Aug(col, :);
            end
        end
    end

    % 確認是否可逆
    if any(Aug(:, 1:m) == eye(m))
        Ainv = Aug(:, m+1:end);
    else
        error('Matrix is not invertible.');
    end
end
