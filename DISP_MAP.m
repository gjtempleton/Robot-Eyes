function dispMap = DISP_MAP(leftImage, rightImage, search_windowWidth, search_windowHeight,support_windowWidth,support_windowHeight,dispMethod)

leftImage = im2double(leftImage);
rightImage =  im2double(rightImage);

[leftHeight,leftWidth]= size(leftImage);

dispMap = zeros(leftHeight,leftWidth);

% search_windowWidth = 9;
% search_windowHeight = 9;
% 
% support_windowWidth = 5;
% support_windowHeight = 5;


%Get margins for both support and search windows
searchWindowWidthMargin = (search_windowWidth-1)/2;
searchWindowHeightMargin = (search_windowHeight-1)/2;

supportWindowWidthMargin = (support_windowWidth-1)/2;
supportWindowHeightMargin = (support_windowHeight-1)/2;

margin_Width = (searchWindowWidthMargin + supportWindowWidthMargin);
margin_Height = (searchWindowHeightMargin + supportWindowHeightMargin);

h = waitbar(0,'Calculating disparity....');

tic
%Loop through entire left image
for x  = 1 + margin_Width:leftWidth - margin_Width
    for y  = 1+ margin_Height:leftHeight - margin_Height
         %Get the best match pixel in the right image's location, the value
        %returned by the difference measure and the vector between the two.
        [ pixel,cmpValue, dispVector ] = PIXEL_DISP( x, y, leftImage, rightImage, supportWindowWidthMargin, supportWindowHeightMargin, ...
            searchWindowWidthMargin,searchWindowHeightMargin,dispMethod);
        
      %Populate the corresponding pixel in the disparity map image with
        %the magnitude of the vector.
        dispMap(y,x) = sqrt((dispVector(1))^2 + (dispVector(2))^2);
             
    end
   waitbar( x / (leftWidth - margin_Width)) 
end

close(h);
 toc  
end
