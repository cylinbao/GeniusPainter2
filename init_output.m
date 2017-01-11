function [output] = init_output(content, patchsize, overlap)
outsize = [size(content, 1) size(content, 2)];
xtrim = patchsize - (outsize(2) - ((patchsize-overlap)*floor((outsize(2)-patchsize)/(patchsize-overlap))+1+patchsize-overlap));
ytrim = patchsize - (outsize(1) - ((patchsize-overlap)*floor((outsize(1)-patchsize)/(patchsize-overlap))+1+patchsize-overlap));

outsize_ = [outsize(1)+ytrim outsize(2)+xtrim];

if(size(content,3) ==1)
    output = zeros(outsize_);
else
    output = zeros([outsize_(1:2) size(content,3)]);
end
end
