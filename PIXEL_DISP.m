function [ pixel,cmpValue, dispVector] = PIXEL_DISP( xcoord, ycoord, leftImage, rightImage, support_width, support_height,search_Width,search_Height,dispMethod)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pixel = [];
cmpValue = 10000;

leftWindow = leftImage(xcoord-support_width : xcoord+support_width, ycoord-support_height : ycoord+support_height);

for x = xcoord - search_Width :xcoord  + search_Width
    for y = ycoord - search_Height:ycoord + search_Height
        
        rightWindow = rightImage(x-support_width : x+support_width, y-support_height : y+support_height);
        
        diff = abs(SUPPORT_CMP(leftWindow, rightWindow,dispMethod));
        
        if diff < cmpValue
            cmpValue = diff;
            pixel = [x,y];
        end
        
    end
end

dispVector = [(pixel(1) - xcoord), (pixel(2) - ycoord)];

end

