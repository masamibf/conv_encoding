%============================================================%
% 文件名称：plot_awgn_out.m
% 函数名称：plot_awgn_out(input,SNR,index)
% 函数功能：绘制AWGN信道输出的卷积编码的时域及频域图
% 输    入：input：原始卷积编码序列，SNR：信噪比，index：图片编号
% 输    出：时域及频域图
% 代码作者：长泽雅美男友
% 创建时间：2018/5/16
%============================================================%
function plot_awgn_out(input,SNR,index)

N = length(input);
x = .01:.01:N;
awgn_word = awgn(input,SNR);
[m,n] = size([awgn_word]'*ones(1,100));
y_snr = reshape(([awgn_word]'*ones(1,100))',1,m*n);
Y = fft(y_snr,N);
fy = 20*log10(abs(Y));

% for i = 1:length(y_snr)
%     if y_snr(i) > 1
%         y_snr(i) = 1;
%     end
%     if y_snr(i) < 1
%         y_snr(i) = 0;
%     end
% end

%将卷积编码输出序列写入'awgn_output.txt’文件中
snr = int2str(SNR);
file_name = ['awgn_output(SNR=',snr,').txt'];
fp = fopen(file_name,'wt');
fprintf(fp,' %f',awgn_word);
fclose(fp);

snr = int2str(SNR);
title1 = ['卷积编码时域波形(SNR = ',snr,'dB)'];
title2 = ['卷积编码频域波形(SNR = ',snr,'dB)'];
figure(index);subplot(211);plot(x,y_snr);
title(title1);xlabel('时间t');ylabel('AWGN输出序列');
axis([0 N -1.5 1.5]);
figure(index);subplot(212);plot(fy);
title(title2);xlabel('频率');ylabel('幅度dB');
axis([0 N+10 -60 60]);

end

