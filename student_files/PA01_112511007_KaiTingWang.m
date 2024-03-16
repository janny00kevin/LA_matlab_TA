function Ainv= GJinv(A)
   
    [m, n] = size(A);
    
    if m~=n
        msg = 'Error occurred( rectangular).';
        error(msg)
    end
    if m==1&&A(1,1)~=0
        Ainv=[1/A(1,1)];
    end
    if m==1&&A(1,1)==0

        msg = 'Error occurred( 0 scalar).';
        error(msg)
    end

    aum = [A eye(m)];
    
    
    for i=1:m-1
        for j=i:m-1
            a=1;
            c=1;
            while(aum(i,i)==0)
                if(a+i>m)
                    c=0;
                    break;
                end
                t=aum(i,:);
                aum(i,:)=aum(i+a,:);
                aum(i+a,:)=t;
                
            a=a+1;
            
            end
            if(c==1)
            aum(j+1,:)=aum(j+1,:)+aum(i,:)*(-aum(j+1,i)/aum(i,i));
            end
        end
    end
   b=0;
   for i=1:m
       if aum(i,i)==0
           b=1;
       end
   end
    if b==1
        msg = 'Error occurred(non-invertible).';
        error(msg)
   
    else if m~=1

    for i=1:m-1
        for j=1:m-i

               aum(m-j-i+1,:)=aum(m-j-i+1,:)+aum(m-i+1,:)*(-aum(m-j-i+1,m-i+1)/aum(m-i+1,m-i+1));
               
        end

    end

    for i=1:m
        aum(i,:)=(1/aum(i,i))*aum(i,:);
    end

    
    
       Ainv = aum(:, n+1:end);
       
    end
    
   


    end
end