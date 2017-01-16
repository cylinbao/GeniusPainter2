function [output] = texture_output_pre(output, texture, texture_blur, content, content_blur, patchsize, overlap, tol, alpha)
outsize = [size(content, 1) size(content, 2)];

for i=1:patchsize-overlap:outsize(1)-patchsize+1
    currentpos = [i 1];
    patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);   
    output(currentpos(1):currentpos(1)+patchsize-1,currentpos(2):currentpos(2)+patchsize-1,:) = texture(patchpos(1):patchpos(1)+patchsize-1,patchpos(2):patchpos(2)+patchsize-1,:);
end
for i=1+patchsize-overlap:patchsize-overlap:outsize(2)-patchsize+1
    currentpos = [1 i];
    patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);   
    output(currentpos(1):currentpos(1)+patchsize-1,currentpos(2):currentpos(2)+patchsize-1,:) = texture(patchpos(1):patchpos(1)+patchsize-1,patchpos(2):patchpos(2)+patchsize-1,:);
end

end
