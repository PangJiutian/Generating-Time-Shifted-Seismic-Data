%% TDR
clear;close all;clc
set(0, 'DefaultFigureColormap', jet);
%% load data
load("small_vp.mat")
load("small_imp.mat")
load("small_logt.mat")
load("small_recordtime.mat")
load("small_original_tdr.mat")
load("small_warpped_tdr.mat")
load("small_tdr_labels.mat")
small_real_tdr=small_logt(:,250)-small_original_tdr;
%% parameters
z=(0:1.25:1.25*(size(small_vp,1)-1))';
f0=30;               
dt=0.001; 
wavelet_len=80; 
%% 真实时深转换 获取真实tdr和真实合成记录
% small_logt=0*small_vp;
% for j=1:size(small_vp,2)
%     small_logt(:,j)=2*vint2t(small_vp(:,j),z);
% end
% small_recordtime=RecordbyTDR(z,small_imp,dt,f0,wavelet_len,small_logt);
%% TDR-record
N=size(small_warpped_tdr,2);
imp_temp=repmat(small_imp(:,250), 1, N);
small_original_record=RecordbyTDR(z,small_imp(:,250),dt,f0,wavelet_len,small_original_tdr);
small_original_record= repmat(small_original_record, 1, N);

small_warpped_record=RecordbyTDR(z,imp_temp,dt,f0,wavelet_len,small_warpped_tdr);

%% plot
figure
plot(small_original_record(:,1),'DisplayName','original','Color','#0099e5');hold on;
plot(small_recordtime(:,250),'DisplayName','real','Color','#ff4c4c');
legend('show');

figure
plot(small_original_record(:,1),'DisplayName','original','Color','#0099e5');hold on;
plot(small_warpped_record(:,50),'DisplayName','warp','Color','#ff4c4c');
legend('show');




