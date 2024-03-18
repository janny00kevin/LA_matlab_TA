clc; clear; close all;
load pa01_GJinv_part_testing_matrices.mat
M5 = [1, 2, 3];
M6 = [1; 2; 3];  n = 3;
M7 = reshape(1:n^2, n, n)';
M8 = 0;
M9 = eye(100);
testData = {A, Asamp, B, C, M5, M6, M7, M8, M9};

accuracy = 6;
T = 100;
runTime = zeros(1, T);
for t = 1:T
    tic;
    for i = 1:length(testData)
        try
            answer = round(GJinv(testData{i}), accuracy);
            soln = round(inv(testData{i}),accuracy);
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

disp(['running time: ', num2str(round(sum(runTime),3)), ' sec'])
