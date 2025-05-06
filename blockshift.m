function [warped_tdr_test] = blockshift(data,control_num,block_num,max_shift,N)
%% 对曲线进行块状整体时移
if nargin>4
    data = repmat(data, 1, N);
end
[row,col]=size(data);
shift_waveforms=0*data;
disturnbance=0*data;
time_index=1:row;
startIndex=max_shift;
endIndex=row-max_shift;
controlPoints=1:row;
block_len=ceil(row/block_num);
total_num=control_num*block_num;
SegmentPoints=zeros(total_num,col);
Shift=zeros(total_num+1,col);

%每一道选择不同的分段点  
for j=1:col
    Segment=[];
    for i=1:block_num
        if i==1 
            st_index=startIndex;
            ed_index=block_len*i;
        elseif i==block_num
            st_index=block_len*(i-1);
            ed_index=endIndex;
        else
            st_index=block_len*(i-1);
            ed_index=block_len*i;
        end
        temp_Segment=sort(randi([st_index,ed_index],1,control_num));
        Segment=[Segment temp_Segment];
%         SegmentPoints(:,j)=sort(randi([startIndex,endIndex],1,total_num));  
    %     Shift(:,j)=randi([-max_shift, max_shift],1,control_num+1);
    end
    SegmentPoints(:,j)=Segment;
    temp1=randi([5, max_shift],1,total_num/2+1);
    temp2=randi([-max_shift, -5],1,total_num/2);
    temp3=[temp1 temp2];
    Shift(:,j)=temp3(randperm(length(temp3)));
end
%干扰距离
for j = 1:col
    for i = 1:row
        if controlPoints(i)> startIndex && controlPoints(i)<= SegmentPoints(1,j)
             disturnbance(i,j)=Shift(1,j);
        end
        for k = 1:total_num-1
            if controlPoints(i) > SegmentPoints(k, j) && controlPoints(i) <= SegmentPoints(k+1, j)
                disturnbance(i,j)=Shift(k,j);
                break; 
            end
        end
        if controlPoints(i)> SegmentPoints(total_num, j) && controlPoints(i)< endIndex
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

warped_tdr_test=0*shift_waveforms(:,j);
for j=1:size(data,2)
    warped_tdr_test(:,j)=smooth(shift_waveforms(:,j),0.012,'lowess');
    warped_tdr_test(:,j)=shift_waveforms(:,j);
    for i = 2:length(warped_tdr_test(:,j))
        if warped_tdr_test(i,j) < warped_tdr_test(i-1,j)
            warped_tdr_test(i,j) = warped_tdr_test(i-1,j)+0.00005;
        end
    end
end

end

