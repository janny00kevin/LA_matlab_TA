function [Ainv] = GJinv(A)
[size_A,Y]=size(A);
I=eye(size_A);
disp(I)
for pivot_idx=1:size_A %go throw all pivots
    for row_idx=pivot_idx+1:size_A %go throw all variables under pivot
        k=-(A(row_idx,pivot_idx)/A(pivot_idx,pivot_idx));
        fprintf('k:\n')
        disp(k)
        A(row_idx,:)=A(row_idx,:)+A(pivot_idx,:).*k;
        I(row_idx,:)=I(row_idx,:)+I(pivot_idx,:).*k;
        fprintf('A, I:\n')
        disp(A)
        disp(I)
    end
    for i=1:size_A
        if A(i,i)==0
            fprintf('i:\n')
            disp(i)
            [A,I]=Pivot_not_null(A,i,I);
            fprintf('A, I after rows swap:\n')
            disp(A);
            disp(I);
        end
    end
    if A(pivot_idx,pivot_idx)==0
        error('pizda vipala 2.1.2')
    end
    fprintf('A, I:\n')
    disp(A)
    disp(I)
    pivot=A(pivot_idx,pivot_idx);
    A(pivot_idx,:)=A(pivot_idx,:)./pivot;
    I(pivot_idx,:)=I(pivot_idx,:)./pivot;
    fprintf('A, I:\n')
    disp(A)
    disp(I)
end
for pivot_idx=1:size_A
    if A(pivot_idx,pivot_idx)==0
        error('pizda vipala 2.1.1')
    end
    fprintf('A, I:\n')
    disp(A)
    disp(I)
    
    for column_idx=pivot_idx+1:size_A %eliminate A[pivot_idx,column_idx]
        eliminated=A(pivot_idx,column_idx);
        A(pivot_idx,:)=A(pivot_idx,:)-A(column_idx,:).*eliminated;
        I(pivot_idx,:)=I(pivot_idx,:)-I(column_idx,:).*eliminated;
    end
end
fprintf('A, I:\n')
    disp(A)
    disp(I)
end