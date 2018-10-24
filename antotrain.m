function [ annotrain ] = antotrain( anno )
%This function can transform the origin annotation to the training
%annotation using one-hot encoding.

l = length(anno);
annotrain = zeros(l,4);
for i = 1:l
    if anno(i) == 0
        annotrain(i,:) = [0,0,0,1];
    else if anno(i) == 1
            annotrain(i,:) = [1,0,0,0];
        else if anno(i) == 3
                annotrain(i,:) = [0,1,0,0];
            else annotrain(i,:) = [0,0,1,0];
            end
        end
    end
end

end

