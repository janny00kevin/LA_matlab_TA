function [Ainv] = GJinv(A)
    % scalar
    if isscalar(A)
        if A==0
            error("Not invertible");
        else
            Ainv = 1/A;
            return;
        end
    end
    [r,c] = size(A);
    if r==c
        gj = [A,eye(r)]; 
        for i = 1:r-1
            if gj(i,i) == 0 % pivot=0
                k = find(gj(i+1:r,i));  % next element!=0
                if isempty(k) % all 0 in this column
                    error("Not invertible");
                else
                    gj([i i+k(1,1)],:) = gj([i+k(1,1) i],:); % swap two rows
                end
            end
            gj(i,i:2*r) = gj(i,i:2*r) / gj(i,i); % make the pivot to 1
            gj(i+1:r,i:2*r) = gj(i+1:r,i:2*r)- gj(i+1:r,i) * gj(i,i:2*r); % eliminate same column          
        end
        gj(r,:) = gj(r,:) / gj(r,r); %last pivot to 1
        for i = 1:r-1
            gj(r-i:-1:1,r-i+1:2*r) = gj(r-i:-1:1,r-i+1:2*r) - gj(r-i:-1:1,r-i+1) * gj(r-i+1,r-i+1:2*r);
            % eliminate elements above the diagonal
        end
        Ainv = gj(1:r,r+1:2*r); 
    else % not square
        error("Not invertible, should be a square");
    end
end