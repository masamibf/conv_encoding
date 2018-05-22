%==================================================%
% 文件名称：con213_encode.m
% 函数名称：word = conv213_encode(msg)
% 函数功能：实现（2,1,3）卷积编码
% 输    入：msg （信源编码数据）
% 输    出：word（卷积编码数据）
% 代码作者：长泽雅美男友
% 创建时间：2018/5/14
%==================================================%
function word = conv213_encode(msg)
% 生成两倍msg长度的零向量
word = zeros(1,length(msg)*2); 
%当前的寄存器状态
current = [0,0,0];
for i = 1:length(msg)
    %编码器第一个输出
    out(1) = mod(msg(i) + current(2) + current(3),2);
    %编码器第二个输出
    out(2) = mod(msg(i) + current(2),2);
    %下一个状态的第一bit = 当前状态的第二个bit
    nextstate(1) = current(2);
    %下一个状态的第二bit = 当前状态的第三个bit
    nextstate(2) = current(3);
    %下一个状态的第三bit = 输入的第一个bit
    nextstate(3) = msg(i);
    %更新状态
    current = nextstate;
    %得到编码器输出序列
    word(2*i - 1) = out(1);
    word(2*i) = out(2);
end