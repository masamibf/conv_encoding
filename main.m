%==================================================%
% 文件名称：main.m
% 功    能：调用函数，输出卷积编码，绘制图像等
% 代码作者：长泽雅美男友
% 创建时间：2018/5/14
%==================================================%

%==================================================
%根据信源编码得到卷积编码，写入txt文件
%==================================================
clear;
%读取信源编码的输出txt文件，作为卷积编码的输入
fid = fopen('conv_input.txt','r');
msg = fscanf(fid,'%d');
%调用'conv213_encode.m'中的卷积编码函数，得到卷积编码输出序列
word = conv213_encode(msg);
%将卷积编码输出序列写入'conv_output.txt’文件中
fp = fopen('conv_output.txt','wt');
fprintf(fp,' %d%d',word);
fclose(fp);
%==================================================
% 卷积编码输出序列 通过无噪声信道
%==================================================
N = length(word);
x = 0.01:0.01:N;
[m,n] = size([word]'*ones(1,100));
y = reshape(([word]'*ones(1,100))',1,m*n);
figure(1);subplot(211);plot(x,y);
title('卷积编码时域波形(无噪声)');xlabel('时间t');ylabel('输出序列');
axis([0 N -0.5 1.5]);

Y = fft(y,N);

fy = 20*log10(abs(Y));
fy = fy(1:length(fy));
figure(1);subplot(212);plot(fy);
title('卷积编码频域波形(无噪声)');xlabel('频率');ylabel('幅度dB');
axis([0 N+10 -60 60]);
% %==================================================
% %卷积编码输出序列 通过AWGN信道
% %==================================================

%五种不同信噪比下的输出信号，绘制时域及频域图
SNR1 = 3;plot_awgn_out(word,SNR1,2);
SNR2 = 5;plot_awgn_out(word,SNR2,3);
SNR3 = 8;plot_awgn_out(word,SNR3,4);
SNR4 = 15;plot_awgn_out(word,SNR4,5);
SNR5 = 50;plot_awgn_out(word,SNR5,6);
