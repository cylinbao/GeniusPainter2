function [cost] = get_ssd(texture, texture_blur, texturepos, content, content_blur, output, contentpos, patchsize, overlap, alpha)

texture_box = texture_blur(texturepos(1):texturepos(1)+patchsize-1, texturepos(2):texturepos(2)+patchsize-1, :);
content_box = content_blur(contentpos(1):contentpos(1)+patchsize-1, contentpos(2):contentpos(2)+patchsize-1, :);

d1 = texture_box - content_box;
d1 = d1.^2;
cost_d1 = sum(sum(sum(d1)));

% if ite == 1
	texture_overlap1 = texture(texturepos(1):texturepos(1)+overlap-1, texturepos(2):texturepos(2)+patchsize-1, :);
	output_overlap1 = output(contentpos(1):contentpos(1)+overlap-1, contentpos(2):contentpos(2)+patchsize-1,:);

	texture_overlap2 = texture(texturepos(1)+overlap-1:texturepos(1)+patchsize-1, texturepos(2):texturepos(2)+overlap-1, :);
	output_overlap2 = output(contentpos(1)+overlap-1:contentpos(1)+patchsize-1, contentpos(2):contentpos(2)+overlap-1,:);

	d2_ov1 = texture_overlap1 - output_overlap1;
	d2_ov2 = texture_overlap2 - output_overlap2;

	d2_ov1 = d2_ov1.^2;
	d2_ov1 = sum(sum(sum(d2_ov1)));
	d2_ov2 = d2_ov2.^2;
	d2_ov2 = sum(sum(sum(d2_ov2)));
	cost_d2 = d2_ov1 + d2_ov2;
% else
%	texture_box = texture(texturepos(1):texturepos(1)+patchsize-1,texturepos(2):texturepos(2)+patchsize-1,:);
%	output_box = output(contentpos(1):contentpos(1)+patchsize-1,contentpos(2):contentpos(2)+patchsize-1,:);

% d2 = texture_box - output_box;
% d2 = d2.^2;
% cost_d2 = sum(sum(sum(d2)));
% end

cost = (1-alpha)*cost_d1 + alpha*cost_d2;
end
