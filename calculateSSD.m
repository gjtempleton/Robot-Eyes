function [ SSD, dispMap, valMap ] = calculateSSD( image1, image2 , supportWindowSize, searchWindowSize)
%UNTITLED Calculates SSD of two images provided, must be of same size, must
%be grayscale
%   Detailed explanation goes here
[width,height] = size(image1);
image1 = im2double(image1);
image2 = im2double(image2);
%Get margins for both support and search windows
searchWindowMargin = (searchWindowSize-1)/2;
supportWindowMargin = (supportWindowSize-1)/2;
totalMargin = searchWindowMargin+supportWindowMargin;
%Create matrices for differences and distances
dispMap = zeros(width, height);
valMap = zeros(width-(2*totalMargin),height-(2*totalMargin));
%Sum of total differences
total = 0.0;
%Loop through left image
for i=1+(searchWindowMargin+supportWindowMargin):width-(searchWindowMargin+supportWindowMargin)
    for j=1+(searchWindowMargin+supportWindowMargin):height-(searchWindowMargin+supportWindowMargin)
        %Create support window for left image
        region1=image1(i-supportWindowMargin : i+supportWindowMargin, j-supportWindowMargin : j+supportWindowMargin);
        mean1=mean(mean(region1));
        standardDev1 = std2(region1);
        meanReg1 = region1-mean1;
        %Declare diff to be arbitrarily large
        diff = 100000;
        xDiff = 0;
        yDiff = 0;
        %Search across search window space
        for k = i-searchWindowMargin:i+searchWindowMargin
            for l = j-searchWindowMargin:j+searchWindowMargin
                %Create support window for right image to be compared
                region2=image2(k-supportWindowMargin : k+supportWindowMargin, l-supportWindowMargin : l+supportWindowMargin);
                mean2=mean(mean(region2));
                meanReg2 = region2-mean2;
                standardDev2 = std2(region2);
                standardDevProduct = standardDev1*standardDev2;
                %normedRegion1 = meanReg1/standardDevProduct;
                %normedRegion2 = meanReg2/standardDevProduct;
                %Get normalised difference between two support windows
                currDiff = sum(sum((meanReg1 - meanReg2).^2)/standardDevProduct);
                if currDiff<diff
                    diff = currDiff;
                    xDiff = i-k;
                    yDiff = j-l;
                end
            end
        end
        dispMap(i,j) = diff;
        valMap(i-totalMargin,j-totalMargin) = sqrt((xDiff.^2)+(yDiff.^2));
        %diff = (normedRegion1 - normedRegion2).^2;
        %diff = (region1 - region2).^2;
        %diff=(image1(i,j)-image2(i,j));
        %total = (total+sum(sum(diff)));
        %dispMap(i,j) = min(min(diff));
    end
end
SSD = total;
end