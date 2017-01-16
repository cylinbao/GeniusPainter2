function output = cutu(sample, patchsize, overlap, output, samplepos, outputpos)

samplesz = size(sample);
sampledms = length(samplesz);

output(outputpos(1)+overlap:outputpos(1)+patchsize-1, outputpos(2)+overlap:outputpos(2)+patchsize-1, :) = sample(samplepos(1)+overlap:samplepos(1)+patchsize-1, samplepos(2)+overlap:samplepos(2)+patchsize-1, :);

outputsz = size(output);
outputdms = length(outputsz);

samplet = zeros(overlap, patchsize);
outputt = zeros(overlap, patchsize);
delta = zeros(overlap, patchsize);

if sampledms == 2
    samplet(:, :) = sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2):samplepos(2)+patchsize-1);
else
    for k=1: 1: samplesz(3);
        samplet(:, :) = samplet(:, :) + sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2):samplepos(2)+patchsize-1, k);
    end
end

if outputdms == 2
    outputt(:, :) = output(outputpos(1):outputpos(1)+overlap-1, outputpos(2):outputpos(2)+patchsize-1);
else
    for p=1: 1: outputsz(3);
        outputt(:, :) = outputt(:, :) + output(outputpos(1):outputpos(1)+overlap-1, outputpos(2):outputpos(2)+patchsize-1, p);
    end
end

delta(:, :) = samplet(:, :) - outputt(:, :);
delta(:, :) = abs(delta(:, :));

ddelta = zeros(overlap, patchsize);

ddelta(:, 1) = delta(:, 1);

for i=2: 1: patchsize;
    for j=1: 1: overlap;
        if j == 1
            ddelta(1, i) = delta(1, i) + min([delta(1, i-1) delta(2, i-1)]);
        elseif j == overlap
            ddelta(overlap, i) = delta(overlap, i) + min([delta(overlap-1, i-1) delta(overlap, i-1)]);
        else
            ddelta(j, i) = delta(j, i) + min([delta(j-1, i-1) delta(j, i-1) delta(j+1, i-1)]);
        end
    end
end

cutarr = zeros(patchsize, 1);

cutarr(patchsize) = find(ddelta(:, patchsize)==min(ddelta(:, patchsize)), 1, 'first');

for i=patchsize: -1: 2;
    if cutarr(i) == 1
        temp = [ddelta(1, i-1) ddelta(2, i-1)];
        cutarr(i-1) = find(temp==min(temp), 1, 'first');
    elseif cutarr(i) == overlap
        temp = [ddelta(overlap, i-1) ddelta(overlap-1, i-1)];
        cutarr(i-1) = overlap + 1 - find(temp==min(temp), 1, 'first');
    else
        temp = [ddelta(cutarr(i)-1, i-1) ddelta(cutarr(i), i-1) ddelta(cutarr(i)+1, i-1)];
        cutarr(i-1) = cutarr(i) - 2 + find(temp==min(temp), 1, 'first');
    end
end

for i=0: 1: patchsize-1;
    output(outputpos(1)+cutarr(i+1)-1:outputpos(1)+overlap-1, outputpos(2)+i, :) = sample(samplepos(1)+cutarr(i+1)-1:samplepos(1)+overlap-1, samplepos(2)+i, :);
end
