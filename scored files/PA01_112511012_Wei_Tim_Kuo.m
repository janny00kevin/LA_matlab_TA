function [Ainv] = GJinv(A)
%取大小
[m,n] = size(A);
%先判斷是否為方陣
if m~=n
    error('No inverse matrix.');
end
%做增廣
augmented=[A eye(n)];

%GJ
%i是處理到第幾行，j是i以下的行
i = 1;
check = 0;
%確保對角線元素不為0
while i<=n
    %若對角線元素為0則找i以下的行來互換
    if augmented(i,i)==0
        j = i+1;
        while j<=n
            %找到非0行，做行互換，互換完i-1，同行繼續做
            if augmented(j,i) ~= 0
                temp = augmented(j,:);
                augmented(j,:) = augmented(i,:);
                augmented(i,:) = temp;
                check = 999;
                break;
                %沒找到就往下找
            else
                j = j + 1;
            end
        end
        %代表找不到可以行互換的行
        if augmented(i,i)==0
            error('No inverse matrix.')
        end
    else
        %先單位化第i行
        augmented(i,:) = augmented(i,:)/augmented(i,i);
        j = i+1;
        %再把i以下的行做消元
        while j <= n
            augmented(j,:) = augmented(j,:)-augmented(j,i)*augmented(i,:);
            j = j+1;
        end

    end
    if check == 999 % 有行互換
        check = 0;
    else
        i = i + 1;
    end
end
%從倒數第二行開始往上消
i = n-1;
%做向上的消元
while i >= 1
    %把i以下的行都拿來消元
    j = i+1;
    %只要不要超界就繼續消
    while j<=n
        if augmented(i,i) ~= 0  %只有在對角線元素不為0時才需要進行消元
            augmented(i,:) = augmented(i,:) - augmented(j,:)*augmented(i,j);
        end
        j = j+1;
    end
    i = i-1;
end    
Ainv = augmented(1:m,n+1:end);
end