function[Ainv] = GJinv(A)
    [n, m] = size(A);
    if n ~= m
        error("Matrix must be square");
    end
    aug = [A, eye(n)];
    for i = 1:n
        if abs(aug(i,i))<eps
            ok=0;
            for j=i+1:n
                if abs(aug(j,i))>eps
                    ok=1;
                    aug(i,:) = aug(i,:)+aug(j,:);
                    break
                end
            end
            if ok == 0
                error("this matrix is not invertable");
            end
        end
        pivot = aug(i, i);
        aug(i, :) = aug(i, :)/pivot;
        for j = i+1 : n
            x = -1*aug(j, i)/aug(i, i);
            aug(j, :) = aug(j, :) + x * aug(i, :);
        end
    end

    for i = n:-1:1
        for j = 1:(i-1)
            aug(j, :) = aug(j, :) - aug(j, i)*aug(i, :);
        end
    end
    Ainv = aug(:, n+1:2*n);
end