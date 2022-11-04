user_code = [1 0 0 1 1 0 1];
en_code = encode(user_code,7);
%误码位
en_code(11) = ~en_code(11);
de_code = decode(en_code,7);
%计算正确率
[~,accuracy] = compare(user_code,de_code);
fprintf('误码率：%f\n',1-accuracy);