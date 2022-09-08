 function [feature] = get_tiny_image(I, output_size)
    
    [h , w] = size(I);
    tiny_image = zeros(output_size(1),output_size(2));
    
    h_scale = floor(h/output_size(1));
    w_scale = floor(w/output_size(2));
    
    for i =1:output_size(2)
       for j = 1:output_size(1)
            tiny_image(j,i)= I(h_scale*j,w_scale*i);
       end
    end
    min_1=min(min(tiny_image));
    max_1=max(max(tiny_image));
    n = uint8(255 .* ((double(tiny_image)-double(min_1))) ./ double(max_1-min_1));
    feature = n(:);
end
