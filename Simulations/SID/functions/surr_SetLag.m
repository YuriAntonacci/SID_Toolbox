%% Sets the vector of indexes for series and lags to be used for conditioning
% inputs:
% p: vector of embedding dimensions (one for each series; if 0, the series is excluded)
% tau: vector of embedding delays (one for each series)
% u: vector of propagation times (one for each series)
% zerolag: for each series, 1 if zerolag effect is wanted, 0 if not

function [V]=surr_SetLag(p,tau,u,zerolag)

M=length(p);
if nargin<4, zerolag=zeros(1,M); end
if nargin<3, u=ones(1,M); end

%% for internal test (leave commented)
% clear; close all; clc;
% % % iX=1;
% % % iY=2;
% p=[0 4 0 0]';
% u=[3 1 7 1]';
% tau=[1 1 7 1]';
% zerolag=[0 0 0 0]';


%% 2) Set time series and lags
V=[];
for m=1:M        
    if zerolag(m)==1
        V=[V; [m 0]];
    end
    for k=1:p(m)
        V=[V; [m u(m)+tau(m)*(k-1)]];
    end
end
