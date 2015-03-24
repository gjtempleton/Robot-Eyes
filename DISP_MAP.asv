function dispMap = DISP_MAP(leftImage, rightImage, search_windowWidth, search_windowHeight,support_windowWidth,support_windowHeight)

% leftImage = im2double(imread('scene_l.bmp'));
% rightImage =  im2double(imread('scene_r.bmp'));

[leftWidth,leftHeight] = size(leftImage);

dispMap = zeros(leftWidth,leftHeight);

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

for x  = 1 + margin_Width:leftWidth - margin_Width
    for y  = 1+ margin_Height:leftHeight - margin_Height
        tic
        [ pixel,cmpValue, dispVector ] = PIXEL_DISP( x, y, leftImage, rightImage, supportWindowWidthMargin, supportWindowHeightMargin, ...
            searchWindowWidthMargin,searchWindowHeightMargin);
        
        dispMap(x,y) = sqrt((dispVector(1))^2 + (dispVector(2))^2);
        toc        
    end
   waitbar( x / (leftWidth - margin_Width)) 
end

close(h);

end
