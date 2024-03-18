function Ainv = GJinv(A)
    [m , n] = size(A);
    if m ~= n
        error("This matrix is not invertible.");
    elseif m == [1 1]
        if(A(1) == 0)
            error("This matrix is not invertible.");
        else
            Ainv = 1/A;
        end
    elseif isscalar(A)
        Ainv = eye(m)./A(1,1);
        return
    else
        B = [A eye(m)];
        for i=1:(m(1)-1)
           e = i;
           while B(e,i) == 0 
               e = e+1;
               if(e > m)
                error("This matrix is not invertible.")
               end
           end
           C = B(i,:);
           B(i,:) = B(e,:);
           B(e,:) = C;

           B(i,:) = B(i,:)./B(i,i);
           B([i+1 : m],:) = B([i+1 : m],:)-B(i,:).*B([i+1 : m],i);
        end
        for i=m:-1:2
            e = i;
           while B(e,i) == 0 
               e = e-1;
               if(e < 1)
                error("This matrix is not invertible.")
               end
           end
           C = B(i,:);
           B(i,:) = B(e,:);
           B(e,:) = C;

           B(i,:) = B(i,:)./B(i,i);
           B([i-1 : -1 :1],:) = B([i-1: -1 : 1],:)-B(i,:).*B([i-1:-1 : 1],i);
        end
        if B(:,[1:m]) == eye(m)
            B(m,:) = B(m,:)./B(m,m);
            Ainv = B(:,[m+1:end]);
        else
            error("This matrix is not invertible.");
        end
    end
end