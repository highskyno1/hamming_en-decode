function res = randErrorCode(input,error_rate)
%randErrorCode 对输入的码元数组添加随机误码
%input:数组
%error_rate:误码率(%)
res = input;
for i = 1:length(input)
    if rand() < error_rate
        res(i) = ~res(i);
    end
end
end

