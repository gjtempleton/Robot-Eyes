function [ diffNum ] = SUPPORT_CMP( windowL, windowR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mean1=mean(mean(windowL));
standardDev1 = std2(windowL);
meanReg1 = windowL-mean1;
mean2=mean(mean(windowR));
meanReg2 = windowR-mean2;
standardDev2 = std2(windowR);
standardDevProduct = standardDev1*standardDev2;
try
%Get normalised difference between two support windows
diffNum = sum(sum((meanReg1 - meanReg2).^2)/standardDevProduct);
catch
    bloop = 1;
end
end

