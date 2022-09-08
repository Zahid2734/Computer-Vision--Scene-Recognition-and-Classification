function [conf, acc] = classify_knn_bow

%% for train part

file = fopen('train.txt','r');
data = textscan(file,'%s %s');
lab = data{1};
p = data{2};
imagebow = {};
for i = 1:1:size(lab,1)
    im = imread(fullfile(pwd,p{i}));
    imagebow{i}= im;  
end
vocab = build_visual_dictionary(imagebow,50);
d = size(vocab,2);
file = fopen('train.txt','r');
data = textscan(file,'%s %s');
lab = data{1};
p = data{2};
feature_train = ones(size(lab,1),d);
label_train = zeros(size(lab,1),1);
count_val = 1 ;
lab_val = lab{1};

for i = 1:size(lab,1)
    im = imread(fullfile(pwd,p{i}));
    [~,feat] = vl_dsift(im2single(im),'step', 10, 'fast');
    b = compute_bow(feat,vocab);
    feature_train(i,:) = b;
    
    if strcmp(lab_val,lab{i})
        label_train(i) = count_val;
    else
        count_val = count_val+1;
        label_train(i) = count_val;
    end
    
    lab_val = lab{i};
    
end

%%  for test part

file = fopen('test.txt','r');
data = textscan(file,'%s %s');
lab = data{1};
p = data{2};
feature_test = ones(size(lab,1),d);
label_test = zeros(size(lab,1),1);
count_val = 1 ;
lab_val = lab{1};
for i = 1:size(lab,1)
    im = imread(fullfile(pwd,p{i}));
    [~,feat] = vl_dsift(im2single(im),'step', 10, 'fast');
    b = compute_bow(feat,vocab);
    feature_test(i,:) = b;
    
    if strcmp(lab_val,lab{i})
        label_test(i) = count_val;
    else
        count_val = count_val+1;
        label_test(i) = count_val;
    end    
    lab_val = lab{i};
    
end

%% Knn prediction

[label_test_pred] = predict_knn(feature_train,label_train,feature_test,4);

%% Accuracy and confusion matrix calculation

acc=length(find(label_test_pred==label_test))/size(feature_test,1);
acc = acc*100;

conf = ones(15,15);

for i = 1:size(label_test_pred,1)
    
    if label_test(i) ~= label_test_pred(i)
        
       conf(label_test_pred(i),label_test(i)) = conf(label_test_pred(i),label_test(i))+1;
    end
end

end
   