function [output] = texture_output_rest(output, texture, texture_blur, content, content_blur, patchsize, overlap, tol, alpha)
outsize = [size(content, 1) size(content, 2)];

for i=1:patchsize-overlap:outsize(1)-patchsize+1
    currentpos = [i outsize(2)-patchsize+1];
    patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);   
    if(i == 1)
        output = cutu(texture, patchsize, overlap, output, patchpos, currentpos);
    else
        output = cut(texture, patchsize, overlap, output, patchpos, currentpos);
    end
end
for i=1:patchsize-overlap:outsize(2)-patchsize+1
    currentpos = [outsize(1)-patchsize+1 i];
    patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);   
     if(i == 1)
        output = cutl(texture, patchsize, overlap, output, patchpos, currentpos);
    else
        output = cut(texture, patchsize, overlap, output, patchpos, currentpos);
     end
end

currentpos = [outsize(1)-patchsize+1 outsize(2)-patchsize+1];
patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);   
output = cut(texture, patchsize, overlap, output, patchpos, currentpos);

end
