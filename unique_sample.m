function [dout] = unique_sample(din,target_length)
%% 采样 确保不震荡

original_data = din;
original_length = length(original_data);
% 原始数据的索引
original_indices = linspace(1, original_length, original_length);
% 目标数据的索引
target_indices = linspace(1, original_length, target_length);
% 使用线性插值
dout = interp1(original_indices, original_data, target_indices, 'linear');

end

