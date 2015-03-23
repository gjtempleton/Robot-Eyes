function [ diffNum ] = SUPPORT_CMP( windowL, windowR)
%SUPPORT_CMP returns the diff valu between two support windows
%   Returns the calculated difference value between two provided support
%   windows based on the specified function. Default is normalised SSD.
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

