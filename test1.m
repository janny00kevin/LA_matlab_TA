clc; clear; close all;
load pa01_GJinv_part_testing_matrices.mat
testData = {A, Asamp, B, C};

% disp(testData{1})
for i = 1:4
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

