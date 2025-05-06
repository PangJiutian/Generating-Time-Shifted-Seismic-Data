function [record,w_t,wavelet] = MakeRecord(f0,wavelet_len,dt,vp,den,imp) 
%% 合成记录

% ricker子波
w_t=((-ceil(wavelet_len/2)):1:ceil((wavelet_len/2)))*dt;
wavelet=(1-2*(pi*f0*(w_t)).^2).*exp(-(pi*f0*(w_t)).^2);

% 反射系数
if nargin<=5
    logimp=log(vp.*den);
    [dz,~] = diff_z(size(logimp,1),0.5);
    r=dz*logimp;
else
    logimp=log(imp);
    [dz,~] = diff_z(size(logimp,1),0.5);
    r=dz*logimp;
end
%ceil(wavelet_len/2)+1  ceil((wavelet_len+1)/2)
% 褶积矩阵
conv_wt_initial=zeros(length(wavelet)+size(r,1)-1,size(r,1));
for j=1:size(r,1)
    conv_wt_initial((j:length(wavelet)+j-1),j)=wavelet;              %构建子波褶积矩阵 每列依次依次向下移一位 长度为子波长度
end
conv_wt=conv_wt_initial(ceil(wavelet_len/2)+1:ceil(wavelet_len/2)+size(r,1),:);  %对齐
% conv_wt=conv_wt_initial(ceil((wavelet_len+1)/2):ceil((wavelet_len+1)/2)+size(r,1)-1,:);  %对齐
% 合成记录
record=conv_wt*r.*mwindow(size(r,1),5);

conv_wt_1=conv_wt*dz;
end

%% 差分矩阵 DZ为正常差分矩阵 DZ_N为补充最后一行的差分矩阵
function [DZ,DZ_N] = diff_z(n,constant)
DZ=zeros(n-1,n);
for i=1:n-1
    for j=1:n
        if i==j
            DZ(i,j)=-constant;
        elseif j==i+1
            DZ(i,j)=constant;
        else
            DZ(i,j)=0;
        end
    end
end
%利用前向差分 后向差分 最后一个数据利用后向差分
DZ_N=zeros(n,n);
DZ_N(1:end-1,:)=DZ;
DZ_N(end,:)=DZ(end,:);
end


