function[Ainv] = GJinv(A)
    a = size(A);
    if a(1,1) == a(1,2)
        m = 0;
        Ainv = eye(length(A));
        for i=2:length(A)
            for l=i:length(A)
                if A(i-1,i-1) == 0
                    n = A(i-1,:);
                    A(i-1,:) = A(l,:);
                    A(l,:) = n;
                    n = Ainv(i-1,:);
                    Ainv(i-1,:) = Ainv(l,:);
                    Ainv(l,:) = n;
                else
                    break;
                end
            end
            if A(i-1,i-1) == 0
                m = 1;
                break;
            end
            for k = i:length(A)
                x = A(k,i-1) / A(i-1,i-1);
                for j = 1:length(A)
                    A(k,j) = A(k,j) - x * A(i-1,j);
                    Ainv(k,j) = Ainv(k,j) - x * Ainv(i-1,j);
                end
            end
        end
        for i=length(A)-1:-1:1
            if m == 1
                break;    
            end
            for k = i:-1:1
                x = A(k,i+1) / A(i+1,i+1);
                for j = length(A):-1:1
                    A(k,j) = A(k,j) - x * A(i+1,j);
                    Ainv(k,j) = Ainv(k,j) - x * Ainv(i+1,j);
                end
            end
        end
        for i = 1:length(Ainv)
            if m == 1
                break; 
            end
            x = A(i,i);
            Ainv(i,:) = Ainv(i,:) / x;
            A(i,i) = A(i,i)/x;
        end
        if m == 1
            error("can't inverse");
        end
    else
        error("not square matrix");
    end
end