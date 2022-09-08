function [vocab] = build_visual_dictionary(training_image_cell, dict_size)
    
    lenght = size(training_image_cell,2);
    feature = [];
    stepSize = 10;
    for i = 1:lenght
        [~,feat] = vl_dsift(im2single(training_image_cell{i}),'step', stepSize, 'size' ,8,'fast');
        feature = [feature feat]; 
    end
    feature = double(feature');
    [~,c ] = kmeans(feature, dict_size);
    vocab = c';
end