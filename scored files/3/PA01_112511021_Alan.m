function [Ainv] = GJinv(A)
    [rows, cols] = size(A);
    if rows ~= cols
        error('矩陣必須是方陣');
    end
    
    I = eye(rows);
    
    AI = [A I];
    
    for i = 1:rows
        [~, maxIndex] = max(abs(AI(i:rows, i)));
        maxIndex = maxIndex + i - 1;
        AI([i, maxIndex], :) = AI([maxIndex, i], :);
        
        if AI(i, i) == 0
            error('矩陣不可逆');
        end
        
        AI(i, :) = AI(i, :) / AI(i, i);
        
        for j = [1:i-1, i+1:rows]
            AI(j, :) = AI(j, :) - AI(i, :) * AI(j, i);
        end
    end
    
    Ainv = AI(:, cols+1:end);
end