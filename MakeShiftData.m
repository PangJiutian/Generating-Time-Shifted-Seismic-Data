%% 制作时移数据 采用在原数据中找n个控制点 把原数据分成n+1块 每一块做不同的时移
clear;close all;clc

%% 参数设置
f0=30;           %测试角度时采用18    正常采用55    
dt=0.001; 
wavelet_len=80;  %测试角度时采用120   正常采用80
max_shift=20;    %最大时移
control_num=10;  %控制点总数
N=500;


%% 模型加载
load('Record.mat');
load("waveforms.mat")
load("logt.mat")     %时深关系
load("original_tdr.mat")
% AI_new=imp;

%% 时移数据
% [w_t,wavelet,r,imp,conv_wt,conv_wt_1,Record] = MakeRecord(f0,wavelet_len,dt,AI_new,AI_new,AI_new);
% data = repmat(original_tdr, 1, N);
data=logt(:,50);

[row,col]=size(data);
shift_waveforms=0*data;
disturnbance=0*data;
time_index=1:row;
shiftTime_index=time_index;
startIndex=max_shift;
endIndex=row-max_shift;
controlPoints=1:row;
SegmentPoints=zeros(control_num,col);
Shift=zeros(control_num+1,col);
%每一道选择不同的分段点  
for j=1:col
    SegmentPoints(:,j)=sort(randi([startIndex,endIndex],1,control_num));  
    Shift(:,j)=randi([-max_shift, max_shift],1,control_num+1);
end
%干扰距离
for j = 1:col
    for i = 1:row
        if controlPoints(i)> startIndex && controlPoints(i)<= SegmentPoints(1,j)
             disturnbance(i,j)=Shift(1,j);
        end
        for k = 1:control_num-1
            if controlPoints(i) > SegmentPoints(k, j) && controlPoints(i) <= SegmentPoints(k+1, j)
                disturnbance(i,j)=Shift(k,j);
                break; 
            end
        end
        if controlPoints(i)> SegmentPoints(control_num, j) && controlPoints(i)< endIndex
             disturnbance(i,j)=Shift(end,j);
        end
        if controlPoints(i)>= endIndex || controlPoints(i)<= startIndex
            disturnbance(i,j) = 0;
        end
    end
end
for j=1:col
    temp=time_index;
    temp(controlPoints) = temp(controlPoints) + disturnbance(:,j)';
    for i=1:row
        location=find(abs(time_index-temp(i))<1e-10);                     %找到时移后的时间点在原信号中的位置
        shift_waveforms(i,j)=data(location,j);                        %时移后的位置获取初始值
    end
end
% original_tdr=smooth(shift_waveforms,0.012,'lowess');
% for i = 2:length(original_tdr)
%     if original_tdr(i) < original_tdr(i-1)
%         original_tdr(i) = original_tdr(i-1)+0.00005;
%     end
% end

warped_tdr_test=0*shift_waveforms(:,j);
for j=1:size(data,2)
    warped_tdr_test(:,j)=smooth(shift_waveforms(:,j),0.012,'lowess');
    for i = 2:length(warped_tdr_test(:,j))
        if warped_tdr_test(i,j) < warped_tdr_test(i-1,j)
            warped_tdr_test(i,j) = warped_tdr_test(i-1,j)+0.00005;
        end
    end
end
tdr_labels_test=data-warped_tdr_test;
original_tdr_test=data;
%% plot
% figure
% plot(data,'DisplayName','true');hold on
% plot(original_tdr,'DisplayName','original');
% legend('show');

figure
plot(original_tdr_test(:,1),'DisplayName','true');hold on
plot(warped_tdr_test(:,1),'DisplayName','smooth');
% legend('show');
% figure
% wigb(tdr_labels_test(:,1:10:end));

% figure
% wigb(data)
% figure
% wigb(shift_data)

% figure
% plot(imp(:,150),'DisplayName','true');hold on
% plot(ShiftWell_imp(:,150),'DisplayName','shift')
% legend('show');
% 
% figure
% plot(imp(:,150)-ShiftWell_imp(:,150),'DisplayName','error')
% legend('show');