function [bow_feature] = compute_bow(feature, vocab)
    
    lenght = zeros(1,size(vocab,2));
    for i = 1:size(feature,2)
        m = inf;
        for j = 1:size(vocab,2)
            bla = sqrt(sum((double(feature(:,i))-double(vocab(:,j))).^2));
            if m > bla
               sla = j;
               m = bla;
            end
        end
       lenght(sla) = lenght(sla)+1; 
    end
    bow_feature  = lenght ./ norm(lenght);
end