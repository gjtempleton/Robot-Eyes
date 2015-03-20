[width,height] = size(image1);
dispMap = zeros(width, height);
for i=1:width
    for j=1:height
        [point, dispMap(i,j), vector]=PIXEL_DISP(i, j, imLeft, imRight);
    end
end