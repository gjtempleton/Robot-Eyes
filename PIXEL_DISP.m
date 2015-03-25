function [ pixel,cmpValue, dispVector] = PIXEL_DISP( xcoord, ycoord, leftImage, rightImage, support_width, support_height,search_Width,search_Height,dispMethod)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pixel = [0, 0];
cmpValue = 10000;

leftWindow = leftImage(ycoord-support_height : ycoord+support_height, xcoord-support_width : xcoord+support_width);
for x = xcoord - search_Width :xcoord  + search_Width
    for y = ycoord - search_Height:ycoord + search_Height
        
        
        rightWindow = rightImage(y-support_height : y+support_height, x-support_width : x+support_width);
        
        diff = abs(SUPPORT_CMP(leftWindow, rightWindow,dispMethod));
        
        if diff < cmpValue
            cmpValue = diff;
            pixel = [x,y];
        end
        
    end
end

%Sanity check on the pixel that's the best match, if no pixel that's a good
%match has been found, set the vector as [0,0]
if pixel(1)==0
    dispVector = [0,0];
else
    dispVector = [(pixel(1) - xcoord), (pixel(2) - ycoord)];
end

end

