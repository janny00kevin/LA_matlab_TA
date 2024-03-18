mat=rand(6,6);
disp(mat);
[X,Y]=size(mat);

if X~=Y
    error('pizda vipala')
end
I=eye(X);
for i=1:X
    if mat(i,i)==0
        mat=Pivot_not_null(mat,i,I);
        disp(mat);
    end
end
disp(mat)
Inverse(mat);
disp(inv(mat))