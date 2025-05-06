function [correlation_coefficients, min_index] = find_max_corr(real_data,predict_data)
%% 找到两个矩阵列相关系数最大

correlation_coefficients = zeros(1, size(real_data, 2));
for i = 1:size(real_data, 2)
    R = corrcoef(real_data(:, i), predict_data(:, i));
    correlation_coefficients(i) = R(1, 2);    % 提取相关系数
end
[~, min_index] = max(correlation_coefficients);

end

