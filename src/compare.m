%�Ƚ���������
%input1:����1
%input2:����2
%res:��ȷ��Ԫ����
%accuracy:��ȷ��
function [res,accuracy] = compare(input1,input2)
    len1 = length(input1);
    len2 = length(input2);
    len = min(len1,len2);
    right_code = 0;
    for i = 1:len
        if input1(i) == input2(i)
            right_code = right_code + 1;
        end
    end
    res = right_code;
    accuracy = right_code / len;
end