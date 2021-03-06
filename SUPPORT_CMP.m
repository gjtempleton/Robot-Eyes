function [ diffNum ] = SUPPORT_CMP( windowL, windowR, method)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


if strcmp(method,'SSDNorm')
    
    meanL= mean2(windowL);
    standardDevL = std2(windowL);
    meanRegL = windowL-meanL;
    meanR= mean2(windowR);
    meanRegR = windowR-meanR;
    standardDevR = std2(windowR);
    standardDevProduct = standardDevL*standardDevR;
    
    %Get normalised difference between two support windows
    diffNum = sum(sum((meanRegL - meanRegR).^2))/standardDevProduct;
    
elseif strcmp(method,'SSD')
    diffNum =  - sum(sum((windowL - windowR).^2));
    
elseif strcmp(method,'SAD')
    
    diffNum = sum(sum(abs(windowL - windowR)));

elseif strcmp(method,'CRS')   
    
    diffNum = sum(sum(normxcorr2(windowL, windowR)));
    
end

end

