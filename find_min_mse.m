function [mse, min_index] = find_min_mse(real_data,predict_data)
%% 找到最好的结果
err=real_data-predict_data;
column_means = mean(err);
mse = mean((err - column_means).^2);
[~, min_index] = min(mse);
end

