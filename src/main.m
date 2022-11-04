%{
    本代码实现了对用户二进制码元的纠错编码与解码。
    核心功能采用的汉明码的方法。
    2020/8/4 23:10
    加入了交织编码技术,一定程度上避免了突发连续错误带来的误码
    2020/8/5 11:19
%}
%汉明编码一帧的码元数,对数据冗余度有影响
hamming_frame_size = 1;
%交织编码一帧的码元数,越大对于抵抗突发连续错误越好,但会增加处理时延
mixed_frame_size = 16;
%测试的码元数量,必须是frame_size以及mixed_frame_size的整数倍
code_num = 1e4 * 8;

%生成用户码元
user_code = genBipolar(code_num);
%交织编码
mix_code = mixed_encode(user_code,mixed_frame_size);
%发送出去的编码后的码元
send_code = hamming_encode(mix_code,hamming_frame_size);
fprintf('冗余度：%f\n',length(send_code)/length(user_code));
%误码率开始数
error_start = -4; % -4指10^-4
%误码率结束数
error_end = -0.3; % -0.3指10^(-0.3)
%误码率尝试数
error_size = 100;
%记录信道误码率的数组
channel_error_rec = zeros(1,error_size);
%记录实际误码率的数组
error_rec = zeros(1,error_size);
parfor error_index = 1:error_size
    %当前信道误码率
    error_rate = 10^(error_start + (error_index-1) / error_size * (error_end - error_start));
    channel_error_rec(error_index) = error_rate;
    %随机误码
    rec_code = randErrorCode(send_code,error_rate);
    %解码后的码元
    de_code = hamming_decode(rec_code,hamming_frame_size);
    %交织解码
    res_code = mixed_decode(de_code,mixed_frame_size);
    %计算实际误码率
    [~,accuracy] = compare(user_code,res_code);
    error_rec(error_index) = 1 - accuracy;
    fprintf('信道误码率：%f,实际误码率：%f\n',error_rate,1-accuracy);
end
%绘制实际误码率与信道误码率关系图
figure();
loglog(channel_error_rec,error_rec);
hold on;
loglog(channel_error_rec,channel_error_rec);
xlabel('信道误码率');
ylabel('实际误码率');
legend('使用纠错码传输','直接传输');
