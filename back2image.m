% Text to image conversion
% % Open the txt file
fid = fopen('grayimage.txt', 'r');
% Scann the txt file 
%img = fscanf(fid, '%x', [1 inf]); 
img = fscanf(fid, '%2x', [2048 1153]); 
% Close the txt file
fclose(fid);
% restore the image
outImg = reshape(img,[2048 1153]);
outImg = outImg';
figure, imshow(outImg,[])