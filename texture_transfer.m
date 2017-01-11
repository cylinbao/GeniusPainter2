function [output] = texture_output(output, texture, texture_blur, content, content_blur, patchsize, overlap, region_list, label_count, tol, alpha)
outsize = [size(content, 1) size(content, 2)];
% xtrim = patchsize - (outsize(2) - ((patchsize-overlap)*floor((outsize(2)-patchsize)/(patchsize-overlap))+1+patchsize-overlap));
% ytrim = patchsize - (outsize(1) - ((patchsize-overlap)*floor((outsize(1)-patchsize)/(patchsize-overlap))+1+patchsize-overlap));
% 
% outsize_ = [outsize(1)+ytrim outsize(2)+xtrim];
% 
% if(size(content,3) ==1)
%     output = zeros(outsize_);
% else
%     output = zeros([outsize_(1:2) size(content,3)]);
% end

outsize_ = [size(output,1) size(output,2)];

ite_num = size(region_list,2);
for ite = 1:ite_num
	blockpos = region_list(ite).topleft;
	blocksize = region_list(ite).boxsize;

% for i=1:patchsize-overlap:outsize_(1)-patchsize+1,
    % for j=1:patchsize-overlap:outsize_(2)-patchsize+1,
for i=1:patchsize-overlap:blocksize(1)-patchsize+1,
    for j=1:patchsize-overlap:blocksize(2)-patchsize+1,
        % waitbar((i*j_size + j)/(i_size * j_size));
        % if(i == 1 && j == 1)
        % if(i == 1 && j == 1)
            % currentpos = [i j] + blockpos;
            %% pos = find_mindelta(texture, texture_blur, content, content_blur, output, [1 1], patchsize, overlap, tol, alpha);
            % pos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);
            % output(i:i+patchsize-1,j:j+patchsize-1,:) = texture(pos(1):pos(1)+patchsize-1,pos(2):pos(2)+patchsize-1,:);
        % else
            %if(i > outsize(1)-patchsize+1)
            if(i > blocksize(1)-patchsize+1)
                i_new = blocksize(1)-patchsize+1;
            else
                i_new = i;
            end
            if(j > blocksize(2)-patchsize+1)
                j_new = blocksize(2)-patchsize+1;
            else
                j_new = j;
            end
            currentpos = [i_new j_new] + blockpos;

            patchpos = find_mindelta(texture, texture_blur, content, content_blur, output, currentpos, patchsize, overlap, tol, alpha);

            output = cut(texture, patchsize, overlap, output, patchpos, currentpos);
        % end
    end
end
% output = output(1:outsize(1),1:outsize(2),:);
end
end
