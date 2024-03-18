function Ainv = GJinv(A)
    [r, c] = size(A);
    if r ~= c || isempty(A)
        error("Matrix is not invertible");
    end
    main = [A, eye(r)];
    for i = 1:r
        pos = find(main(i:end, i) ~= 0, 1) + i - 1;
        if isempty(pos)
            error("Matrix is not invertible");
        end
        main([i, pos], :) = main([pos, i], :);
        main(i, :) = main(i, :) / main(i, pos);
        for j = i + 1:c
            num = main(j, i) / main(i, i);
            main(j, :) = main(j, :) - num .* main(i, :);
        end
    end
    for i = c:-1:2
        for j = i - 1:-1:1
            num = main(j, i) / main(i, i);
            main(j, :) = main(j, :) - num .* main(i, :);
        end
    end
    Ainv = main(:, c + 1:end);
    Ainv = Ainv./ diag(main(:,1:c));
end

