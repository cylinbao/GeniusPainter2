close all; clear all;  clc;
% clear all;
texture = imread('images/style_B.jpg');
texture = imresize(texture,1/4);
texture = double(texture);
% texture_blur = imgaussfilt(texture,1);

content = imread('images/content1.jpg');
content_uint8 = imresize(content,1/4);
content = double(content_uint8);
% content_blur = imgaussfilt(content,0.5);

tol = 0.5;
alpha = 0.2;

patchsize1 = 15;
patchsize2 = 10;
patchsize3 = 5;
overlap1 = 4;
overlap2 = 3;
overlap3 = 2;

output = init_output(content, patchsize1, overlap1);

% Qlevels = 2^6;
% area_th = [1000 100];

% [block_list label_count] = get_block_list(content_uint8,Qlevels,area_th);

load('block_list.mat');

tic
wb = waitbar(0.1,'Progress');
output = texture_transfer(output, texture, texture, content, content, patchsize1, overlap1, block_list(1).region_list, label_count, tol, alpha);
waitbar(1/3);
output = texture_transfer(output, texture, texture, content, content, patchsize2, overlap2, block_list(2).region_list, label_count, tol, alpha);
waitbar(2/3);
output = texture_transfer(output, texture, texture, content, content, patchsize3, overlap3, block_list(3).region_list, label_count, tol, alpha);
waitbar(3/3);
delete(wb);
toc

outsize = [size(content, 1) size(content, 2)];
output = output(1:outsize(1),1:outsize(2),:);
output2 = output/255;

figure
imshow(output2);

imwrite(output2,'transfer_B.jpg');
