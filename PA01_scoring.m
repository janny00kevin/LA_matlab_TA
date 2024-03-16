clc; clear; close all;
load pa01_GJinv_part_testing_matrices.mat
n = 2;
D = [1 2 3];
E = [1.111; 2.222; 3.3333];
F = reshape(1:n^2, n, n)';
n = 3;
G = reshape(1:n^2, n, n)';
I = eye(105);
Y = G;
Y(3,3) = 9.001;
%           1  2      3  4  5  6  7  8  9
testData = {A, Asamp, B, C, D, E, F, Y, I};



accuracy = 10;
T = 100;
runTime = zeros(1, T);
for t = 1:T
    tic;
    for i = 1:length(testData)
        try
            answer = round(PA01_112511006_Brave_Chang(testData{i}), accuracy);
            soln = round(inv(testData{i}),accuracy);
            if isequal(answer, soln) && t == 1
                disp(['Prob ', num2str(i), ': O'])
%                 disp(soln)
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
