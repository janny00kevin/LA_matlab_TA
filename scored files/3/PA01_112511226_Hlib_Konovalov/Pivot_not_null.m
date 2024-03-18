function [mat,I] = Pivot_not_null(mat,i,I)
[X,Y]=size(mat);
max=0;
j=i;
fprintf('A,I before rows swap:\n')
disp(mat)
disp(I)
while i<=X
    if mat(i,j)~=0 && mat(i,j)~=max
        max=mat(i,j);
        new_pivot_idx=i;
    end
    i=i+1;
end
if max==0
    mat(:)=inf;
    disp(mat);
    return
    
end
mat([j,new_pivot_idx],:)=mat([new_pivot_idx,j],:);
I([j,new_pivot_idx],:)=I([new_pivot_idx,j],:);
fprintf('i j:\n');
disp(j);
disp(new_pivot_idx)