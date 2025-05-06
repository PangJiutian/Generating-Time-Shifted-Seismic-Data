function [dout] = MakeTDRs(din,Numpercent,noisepercent)
%% 对原始TDR添加高斯扭动 MakeTDRs(din,Numpercent,noisepercent)
row=size(din,1);
dout=din;
randomIndices = sort(randperm(row, row*Numpercent));
dout(randomIndices)=add_noise(dout(randomIndices),noisepercent);
dout = smooth(dout,0.04,'lowess');   % 使用局部加权线性回归平滑
% dout(1) = din(1);
% dout=dout+0.03;
for i=1:20
    if dout(i)<0
        dout(i)=-dout(i);
    end
end
% for i = 2:length(dout)
%     if dout(i) < dout(i-1)
%         dout(i) = dout(i-1)+0.00005;
%     end
% end

%% 分段扰动 MakeTDRs(din,control_num)
% row=size(din,1);
% random_points = sort(randperm(row-2, control_num) + 1);
% segment_points = [1, random_points, row];
% y_segmented = din;
% max_shift=0.02*max(din);
% for i = 1:length(segment_points)-1
%     shift = randi([ceil(-max_shift*1e+05), ceil(max_shift*1e+05)])/1e+05;
%     start_idx = segment_points(i);
%     end_idx = segment_points(i+1);
%     % 垂直平移
%     y_segmented(start_idx:end_idx) = y_segmented(start_idx:end_idx) + shift;
% end
% y_segmented(1:5) = din(1:5);
% y_segmented(end-4:end) = din(end-4:end);
% for i = 2:length(y_segmented)
%     if y_segmented(i) < y_segmented(i-1)
%         y_segmented(i) = y_segmented(i-1)+0.0005;
%     end
% end
% dout=smooth(y_segmented,0.012,'lowess');
% dout(1) = din(1);
% dout(end) = din(end);
end

