function GJinvTestScript()
    function GJinvTest()
        % Test matrices
        A1 = [1,2,3;2,4,5;3,5,6];
        A2 = [0,0,-2;2,4,-10;2,4,-5];
        A3 = [1,2,3;2,4,5;-4,-8,-10];
        A4 = [1,2,3,3;2,4,5,4;3,5,6,5;7,8,9,6];

        % Test the function with each matrix
        disp("Matrix 1:")
        try
            Ainv1 = GJinv(A1);
            disp(Ainv1);
        catch ME
            disp(ME.message);
        end

        disp("Matrix 2:")
        try
            Ainv2 = GJinv(A2);
            disp(Ainv2);
        catch ME
            disp(ME.message);
        end

        disp("Matrix 3:")
        try
            Ainv3 = GJinv(A3);
            disp(Ainv3);
        catch ME
            disp(ME.message);
        end

        disp("Matrix 4:")
        try
            Ainv4 = GJinv(A4);
            disp(Ainv4);
        catch ME
            disp(ME.message);
        end
    end

    % Call the test function
    GJinvTest();
end
