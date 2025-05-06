%% Test for data
clear;close all;clc
set(0, 'DefaultFigureColormap', jet);
%% load data
load("small_vp.mat")
load("small_imp.mat")
load("small_logt.mat")
load("small_recordtime.mat")
% load("real_tdr_labels.mat")
% load("record_1_s2.mat")
% load("record_2_s2.mat")
% load("pre_tdr_kan.mat")
% load("pre_tdr_nokan.mat")
load("real_tdr_s3.mat")
load("record_1_s3.mat")
load("record_2_s3.mat")
load("tdr_1_s3.mat")
load("pre_tdr_test.mat")
%% parameters
z=(0:1.25:1.25*(size(small_vp,1)-1))';
f0=30;               
dt=0.001; 
wavelet_len=80; 
max_shift=15;    %最大时移
block_num=8;     %总段数
control_num=3;   %每段的控制点数
Numpercent=0.05;
noisepercent=0.2;
N=2000;
%% TDR-record
data_tdr=small_logt(:,50);
data_imp=small_imp(:,50);
tdr_s4=blockshift(data_tdr,control_num,block_num,max_shift,N);
% tdr_2_s3=blockshift(tdr_1_s3,control_num,block_num,max_shift);
% warpped_tdr_gussian = MakeTDRs(data_tdr,Numpercent,noisepercent);
record_s4=RecordbyTDR(z,data_imp,dt,f0,wavelet_len,tdr_s4);
% record_2_s3=RecordbyTDR(z,data_imp,dt,f0,wavelet_len,tdr_2_s3);
% tdr_labels_s2=tdr_1_s3-tdr_2_s3;
% real_tdr_labels=data_tdr-tdr_1_s3;
% method 2:生成2000道 分成两组 
tdr_1_s4=tdr_s4(:,1:2:end);
tdr_2_s4=tdr_s4(:,2:2:end);
record_1_s4=record_s4(:,1:2:end);
record_2_s4=record_s4(:,2:2:end);
tdr_labels_s4=tdr_1_s4-tdr_2_s4;
real_tdr_s4=data_tdr-tdr_1_s4;
%% update
% % tdr_1_s2=data_tdr-real_tdr_labels;
% update_record=RecordbyTDR(z,data_imp,dt,f0,wavelet_len,tdr_1_s3-pre_tdr_test);
% % 找到效果最好的一列
% [mse_tdr,tdr_idex]=find_min_mse(real_tdr_s3,-pre_tdr_test);
% [corr, max_index] = find_max_corr(real_tdr_s3,-pre_tdr_test);
% % [min_mse_record,record_idex]=find_min_mse(small_recordtime(:,50),update_record);
% 
% figure;
% plot(real_tdr_s3(:,1),'DisplayName','real shift','Color','#0099e5');hold on;
% plot(-pre_tdr_test(:,1),'DisplayName','predict shift','Color','#ff4c4c')
% % plot(tdr_2_s2(:,1),'DisplayName','second tdr','Color','#7d3f98');
% legend('show');
% title('预测时移')
% figure;
% plot(small_recordtime(:,50),'DisplayName','real record','Color','#0099e5');hold on;
% plot(record_1_s3(:,1),'DisplayName','warpped record','Color','#ff4c4c')
% plot(update_record(:,1),'DisplayName','updated tdr','Color','#7d3f98');
% legend('show');
% title('更新合成记录')
%% plot
figure;
plot(data_tdr,'DisplayName','real tdr','Color','#0099e5');hold on;
% plot(tdr_1_s4(:,1),'DisplayName','first tdr','Color','#ff4c4c');hold on;
plot(tdr_1_s4(:,1),'DisplayName','second tdr','Color','#7d3f98');
legend('show');
title('整体时移')
figure;
plot(small_recordtime(:,50),'DisplayName','real record','Color','#0099e5');hold on;
plot(record_1_s4(:,50),'DisplayName','first record','Color','#ff4c4c');hold on;
plot(record_2_s4(:,50),'DisplayName','second record','Color','#7d3f98');
legend('show');
title('整体时移合成记录')





