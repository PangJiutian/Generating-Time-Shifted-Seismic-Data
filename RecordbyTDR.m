function warpped_record = RecordbyTDR(z,data_imp,dt,f0,wavelet_len,tdr)
%% 由TDR生成合成记录
[row,col]=size(tdr);
data_imp=repmat(data_imp,1,col);
temp=cell(1,col);
imp_warpped=0*tdr;
for j=1:col
    temp{1,j} = logtotime2([z,data_imp(:,j)],[z,tdr(:,j)],dt);
    imp_warpped(:,j)=unique_sample(temp{1,j}(:,2),row);
end
warpped_record = MakeRecord(f0,wavelet_len,dt,imp_warpped,imp_warpped,imp_warpped);
warpped_record=[warpped_record;warpped_record(end,:)];
end

