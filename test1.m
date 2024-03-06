clc; clear; close all;
load pa01_GJinv_part_testing_matrices.mat
D = [1 2 3];
testData = {A, Asamp, B, C, D};

% disp(testData{1})
tic;
for i = 1:length(testData)
    try
        answer = round(PA01_112511058_carrson_fung(testData{i}), 2);
        soln = round(inv(testData{i}),2);
        if isequal(answer, soln)
            disp(['Prob ', num2str(i), ': O'])
        else
            disp(['Prob ', num2str(i), ': X'])
        end
    catch ME
        disp(['Prob ', num2str(i), ': O ', ME.message])
    end
end
disp(toc)

