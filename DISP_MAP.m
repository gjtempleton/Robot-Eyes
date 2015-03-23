leftImage = imread('pentagon_left.bmp');
rightImage = imread('pentagon_right.bmp');

[lW,lH] = size(leftImage);

dispMap = zeros(lW,lH);

support_windowWidth = 4;
support_windowHeight = 4;


search_windowWidth = 20;
search_windowHeight = 20;

margin_Width = (search_windowWidth + support_windowWidth);
margin_Height = (search_windowHeight + support_windowHeight);

for x  = 1 + margin_Width:lW - margin_Width
    for y  = 1+ margin_Height:lH - margin_Height
    
        [ pixel,cmpValue, dispVector ] = PIXEL_DISP( x, y, leftImage, rightImage, support_windowWidth, support_windowHeight, ...
            search_windowWidth,search_windowHeight);
        
         dispMap(x,y) = dispVector;                                      
                                                
    end
end
    
    