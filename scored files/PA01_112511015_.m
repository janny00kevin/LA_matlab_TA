function inverse = GJInverse(matrix)
    [r, c] = size(matrix);
    
    if (r~=c)
        disp('Matrix must be square.');
        inverse = [];
        return;
    end

    if isscalar(matrix)
        if (matrix==0)
            disp('0 cannot be inverted.');
            inverse = [];
            return;
        else
            inverse=1/matrix;
            return;
        end
    end

    addmat = [matrix eye(r)];

    for (k = 1:r)
        [~, maxRow]=max(abs(addmat(k:r, k)));
        maxRow=maxRow+k-1;
        if (maxRow~=k)
            addmat([k maxRow], :) = addmat([maxRow k], :);
        end

        pivot = addmat(k, k);
        if (pivot==0)
            disp('Matrix isnt invertible');
            inverse=[];
            return
        end
        addmat(k,:)=addmat(k,:)/pivot;

        for (i=1:r)
            if (i~=k)
                t=addmat(i, k);
                addmat(i,:) =addmat(i,:)- t*addmat(k, :);
            end
        end
    end

    
    for (k=r:-1:2)
        for (i=(k-1):-1:1)
            t=addmat(i,k);
            addmat(i,:) =addmat(i,:)-t*addmat(k,:);
        end
    end

    inverse = addmat(:, c+1:c*2);
end
