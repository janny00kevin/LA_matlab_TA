function [inM] = GJinv (M)
    sz = size(M);
    r = sz(1);
    c = sz(2);
    if r ~= c
        error("Rectangular Matrix");
    end

    if r == 1
        inM = 1 / M;
    elseif r > 1
        msg = "Non-invertible";
        I = eye(r);
    %check empty rows or cols
        for i = 1:r
            if M(i,:) == 0
                error(msg);
            end
            if M(:,i) == 0
                error(msg);
            end
        end
    %Main GJ
        for i = 1:c
            count = i;
            while(M(i,i) == 0)
                if count + 1 > r
                    error(msg);
                end
                M([i,count+1],:) = M([count+1,i],:);
                I([i,count+1],:) = I([count+1,i],:);
                count=count+1;
            end
            if(M(i,i)~=1)
                I(i,:) = I(i,:) / M(i,i);
                M(i,:) = M(i,:) / M(i,i);
            end
            for j = i+1:r
                I(j,:) = I(j,:) + I(i,:) * -1 * M(j,i);
                M(j,:) = M(j,:) + M(i,:) * -1 * M(j,i);
            end
        end
        for i = c:-1:1
            for j = i-1:-1:1
                I(j,:) = I(j,:) + I(i,:) * -1 * M(j,i);
                M(j,:) = M(j,:) + M(i,:) * -1 * M(j,i);
            end
        end
        inM = I;
    end
    %disp(M);
    %display(inM);
end