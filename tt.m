clear;
texture = imread('img/style_Cs.jpg');
texture = im2double(texture);
texture = imresize(texture,1/8);

content = imread('img/content_s.jpg');
content = im2double(content);
content = imresize(content,1/8);

patchsize = 25;
overlap = 5;
tol = 1;
alpha = 0.3;

tic
output = texture_transfer(texture, content, patchsize, overlap, tol, alpha);
toc
output = imresize(output,2);
% imout = imout / 255;
imshow(output);
