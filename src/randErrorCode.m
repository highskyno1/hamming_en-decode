function res = randErrorCode(input,error_rate)
%randErrorCode ���������Ԫ��������������
%input:����
%error_rate:������(%)
res = input;
for i = 1:length(input)
    if rand() < error_rate
        res(i) = ~res(i);
    end
end
end

