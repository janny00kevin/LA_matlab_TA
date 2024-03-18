function[Ainv] = GJinv(A)
%GJINV Summary of this function goes here
%   Detailed explanation goes here
%   Function takes a matrix as an argument and returns it's inverse, if one
%   exists usning GJ elimination under the hood to determine the inverse.


    [col, row] = size(A);
    %Checking if this is a square matrix 
    if col~=row
        error("The matrix has to be a square matrix to invert it");
     end
    %continue check for scalar, since A is mxm
    if col == 1
        if A == 0  
            error("The scalar is non invertable since it equals to 0");
        else
            disp(1/A);
            return;
        end    
    end
    
    %Proceeding to GJ eliminaiton
    
    %Augmenting A
    I = eye(col);
    A = [A, I];
 
    
    %Reduction under main diagonal
    i = 1;
    j = 1;
    k = 0;
    while i~=row || j~=col
        %Swap the rows so that we are getting ~0 elements on main diagonal
        while A(i, i) == 0
            k = k+1;
            % if i+k>row => we checked that whole column of A is 0 => A has no inverse
            if i+k > row
                error("Matrix has no inverse");
            end
            A = swap_rows(A, i, i+k);
        end
        k=0;

        A(i+1:row, :) = A(i+1:row,:) - (A(i+1:row, j) / A(i, j)) * A(i, :);
        j=j+1;
        i=i+1;
    end

    %Reduction over main diagonal
    i = row;
    j = col;
    k = 0;
    disp(A)
    while i ~= 1 || j ~= 1
	    % Swap the rows so that we get ~0 elements on the main diagonal
	    while A(i, i) == 0
		    k = k + 1;
		    % If i+k > row => we checked that the whole column of A is 0 => A has no inverse
		    if i+k > row
			    error("Matrix has no inverse");
		    end
		    A = swp_r(A, i, i - k);
        end
        k=0;

	    A(i - 1:-1:1, :) = A(i - 1:-1:1, :) - (A(i - 1:-1:1, j) / A(i, j)) * A(i, :);
	    j = j - 1;
	    i = i - 1;
    end   

    i = 1;
    eps = 1e-10;
    %Making sure that matrix is EA = I
    while i <= row
        if abs(A(i, i) - 1) > eps
            A(i, :) = A(i, :) / A(i,i);
        end
        i=i+1;
    end

    Ainv = A(:, col+1:col*2);
end


function[A_swp] = swap_rows(A, r0, r)
temp = A(r0, :);
A(r0, :) = A(r, :);
A(r, :) = temp;
A_swp = A;
end