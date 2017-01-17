function [output] = texture_output(output, texture, texture_blur, content, content_blur, patchsize, overlap, region_list, label_count, tol, alpha)
outsize = [size(content, 1) size(content, 2)];

ite_num = size(region_list,2);
for ite = 1:ite_num
	blockpos = region_list(ite).topleft;
	blocksize = region_list(ite).boxsize;
	for i=1:patchsize-overlap:blocksize(1)-patchsize+1,
    	for j=1:patchsize-overlap:blocksize(2)-patchsize+1,
      	currentpos = [i j] + blockpos;
        patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);
        output = cut(texture, patchsize, overlap, output, patchpos, currentpos);
    	end
	end
end
end
