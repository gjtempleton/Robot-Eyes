function [ diffNum ] = SUPPORT_CMP( windowL, windowR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
meanL= mean2(windowL);
standardDevL = std2(windowL);
meanRegL = windowL-meanL;
meanR= mean2(windowR);
meanRegR = windowR-meanR;
standardDevR = std2(windowR);
standardDevProduct = standardDevL*standardDevR;

%Get normalised difference between two support windows
diffNum = sum(sum((meanRegL - meanRegR).^2))/standardDevProduct;

end

