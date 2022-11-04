%{
    ������ʵ���˶��û���������Ԫ�ľ����������롣
    ���Ĺ��ܲ��õĺ�����ķ�����
    2020/8/4 23:10
    �����˽�֯���뼼��,һ���̶��ϱ�����ͻ�������������������
    2020/8/5 11:19
%}
%��������һ֡����Ԫ��,�������������Ӱ��
hamming_frame_size = 1;
%��֯����һ֡����Ԫ��,Խ����ڵֿ�ͻ����������Խ��,�������Ӵ���ʱ��
mixed_frame_size = 16;
%���Ե���Ԫ����,������frame_size�Լ�mixed_frame_size��������
code_num = 1e4 * 8;

%�����û���Ԫ
user_code = genBipolar(code_num);
%��֯����
mix_code = mixed_encode(user_code,mixed_frame_size);
%���ͳ�ȥ�ı�������Ԫ
send_code = hamming_encode(mix_code,hamming_frame_size);
fprintf('����ȣ�%f\n',length(send_code)/length(user_code));
%�����ʿ�ʼ��
error_start = -4; % -4ָ10^-4
%�����ʽ�����
error_end = -0.3; % -0.3ָ10^(-0.3)
%�����ʳ�����
error_size = 100;
%��¼�ŵ������ʵ�����
channel_error_rec = zeros(1,error_size);
%��¼ʵ�������ʵ�����
error_rec = zeros(1,error_size);
parfor error_index = 1:error_size
    %��ǰ�ŵ�������
    error_rate = 10^(error_start + (error_index-1) / error_size * (error_end - error_start));
    channel_error_rec(error_index) = error_rate;
    %�������
    rec_code = randErrorCode(send_code,error_rate);
    %��������Ԫ
    de_code = hamming_decode(rec_code,hamming_frame_size);
    %��֯����
    res_code = mixed_decode(de_code,mixed_frame_size);
    %����ʵ��������
    [~,accuracy] = compare(user_code,res_code);
    error_rec(error_index) = 1 - accuracy;
    fprintf('�ŵ������ʣ�%f,ʵ�������ʣ�%f\n',error_rate,1-accuracy);
end
%����ʵ�����������ŵ������ʹ�ϵͼ
figure();
loglog(channel_error_rec,error_rec);
hold on;
loglog(channel_error_rec,channel_error_rec);
xlabel('�ŵ�������');
ylabel('ʵ��������');
legend('ʹ�þ����봫��','ֱ�Ӵ���');
