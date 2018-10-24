clc;
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script is made up of 4 scripts.
%   signalprecess is for cutting the origin data into the length we need.
%   findreliable is for looking for the period the subject is awake.
%   featureextract is for extracting features for training the network.
%   testone is for training the net and finally get a analysis result.
%   Last editted by Brady Deng in 1-28.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




signalprecess;
findreliable;
featureextract;
%testone will build 23 nets for recognition.
% testone;
%Onenet will build a net for the whole net.
% featurecombine;
% Onenet;
