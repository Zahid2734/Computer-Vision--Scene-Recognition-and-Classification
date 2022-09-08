function [confusion_mat, accuracy] = classify_knn_tiny
%% for training data

file = fopen('train.txt','r');
data = textscan(file,'%s %s');
label = data{1};
path = data{2};
d = 256;
feature_train = ones(size(label,1),d);
label_train = zeros(size(label,1),1);
count_val = 1 ;
lab_val = label{1};

for i = 1:size(label,1)
    im = imread(fullfile(pwd,path{i}));
    im_small = get_tiny_image(im,[16,16]);
    feature_train(i,:) = im_small;
    
    if strcmp(lab_val,label{i})
        label_train(i) = count_val;
    else
        count_val = count_val+1;
        label_train(i) = count_val;
    end
    
    lab_val = label{i};
    
end

%% for testing data

file = fopen('test.txt','r');
data = textscan(file,'%s %s');
label = data{1};
path = data{2};
feature_test = ones(size(label,1),d);
label_test = zeros(size(label,1),1);
count_val = 1 ;
lab_val = label{1};
for i = 1:size(label,1)
    im = imread(fullfile(pwd,path{i}));
    im_small = get_tiny_image(im,[16,16]);
    feature_test(i,:) = im_small;
    
    if strcmp(lab_val,label{i})
        label_test(i) = count_val;
    else
        count_val = count_val+1;
        label_test(i) = count_val;
    end
    
    lab_val = label{i};
    
end

%% classification using KNN
[label_test_pred] = predict_knn(feature_train,label_train,feature_test,4);

%%  confusion matrix Calculation
confusion_mat = ones(15,15);

for i = 1:size(label_test_pred,1)   
    if label_test(i) ~= label_test_pred(i) 
       confusion_mat(label_test_pred(i),label_test(i)) = confusion_mat(label_test_pred(i),label_test(i))+1;
    end
end

%%  accuracy Calculation
if isempty(label_test)==0
    accuracy=length(find(label_test_pred==label_test))/size(feature_test,1);
    accuracy = accuracy*100;
end
