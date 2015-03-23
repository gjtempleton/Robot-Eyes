function [ pixel,cmpValue, dispVector] = PIXEL_DISP( xcoord, ycoord, leftImage, rightImage, support_width, support_height,search_Width,search_Height)
%UNTITLED Takes in two images, with the dimensions of their support and
%search windows and the coordinates of the current pixel being looked at 
%in the left image. Returns the best match pixel's location in the right
%image as well as the value returned by the specified difference function
%and the vector between the two.
%   Detailed explanation goes here

pixel = [];
%Declare an arbitrarily high value for the value returned by SUPPORT_CMP
cmpValue = 10000;

%Create the support window in the Left Window
leftWindow = leftImage(ycoord-support_height : ycoord+support_height, xcoord-support_width : xcoord+support_width);

%Loop through the entire search window
for x = xcoord - search_Width :xcoord  + search_Width
    for y = ycoord - search_Height:ycoord + search_Height
        %Create the support window for the right image
        rightWindow = rightImage(y-support_height : y+support_height,x-support_width : x+support_width);
        %Call SUPPORT_CMP to get the diff value from the specified
        %difference method
        diff = SUPPORT_CMP(leftWindow, rightWindow);
        %If the returned diff is lower than the current lowest set the new
        %diff as the lowest yet and store the x y coordinates of the right
        %pixel being looked at
        if diff < cmpValue
            cmpValue = diff;
            pixel = [x,y];
        end
    end
end

%Set dispvector as the X,Y vectore between the left pixel being looked at
%and its best match in the search window of the right image
dispVector = [(pixel(1) - xcoord), (pixel(2) - ycoord)];

end

