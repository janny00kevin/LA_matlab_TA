clc; clear; close all;
load pa01_GJinv_part_testing_matrices.mat
D = [1 2 3];
testData = {A, Asamp, B, C, D};

T = 100;
runTime = zeros(1, T);
for t = 1:T
    tic;
    for i = 1:length(testData)
        try
            answer = round(GJinva112511228(testData{i}), 2);
            soln = round(inv(testData{i}),2);
            if isequal(answer, soln) && t == 1
                disp(['Prob ', num2str(i), ': O'])
            elseif t == 1
                disp(['Prob ', num2str(i), ': X'])
            end
        catch ME
            if t == 1
                disp(['Prob ', num2str(i), ': O ', ME.message])
            end
        end
    end
    runTime(t) = toc;
end

disp(sum(runTime))
