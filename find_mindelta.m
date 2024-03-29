function mintexturepos = find_mindelta(texture, texture_blur, content, content_blur, output, contentpos, patchsize, overlap, tol, alpha)

sizetexture = size(texture);
sizetexture = sizetexture(1:2);

ssdarr = zeros(sizetexture(1)-patchsize+1, sizetexture(2)-patchsize+1);

for i=1 : 1 : sizetexture(1)-patchsize+1;
    for j=1 : 1 : sizetexture(2)-patchsize+1;
        texturepos = [i j];
        temp = get_ssd(texture, texture_blur, texturepos, content, content_blur, output, contentpos, patchsize, overlap, alpha);
        if temp == 0
            ssdarr(i, j) = 10000000000;
        else
            ssdarr(i, j) = temp;
        end
    end
end

minssd = min(min(ssdarr));
min_mat = repmat(minssd, size(ssdarr));
d_mat = min_mat*(1+tol) - ssdarr;
[temp_x, temp_y] = find(d_mat>0);

randindex = randperm(size(temp_x, 1) ,1);

mintexturepos = [ temp_x(randindex) temp_y(randindex) ];
