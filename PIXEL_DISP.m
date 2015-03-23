function [ pixel,cmpValue, dispVector ] = PIXEL_DISP( xcoord, ycoord, leftImage, rightImage, support_width, support_height,search_Width,search_Height)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pixel = [];
cmpValue = 10000;

[rW,rH] = size(rightImage);

leftWindow = leftImage(xcoord-(support_width/2):xcoord+(support_width/2),ycoord-(support_height/2):ycoord+(support_height/2));

for x = xcoord - search_Width :xcoord  + search_Width
    for y = ycoord - search_Height:ycoord + search_Height
        
        
        rightWindow = rightImage(x-(support_width/2):x+(support_width/2),y-(support_height/2):y+(support_height/2));
        
        diff = SUPPORT_CMP(leftWindow, rightWindow);
        
        if diff < cmpValue
            cmpValue = diff;
            pixel = [x,y];
        end
        
    end
end


dispVector = sqrt((pixel(1) - xcoord)^2 + (pixel(2) - ycoord)^2);

end

