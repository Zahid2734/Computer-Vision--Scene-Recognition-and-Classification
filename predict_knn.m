function [label_test_pred] = predict_knn(feature_train,label_train,feature_test,k)

label_test_pred=zeros(size(feature_test,1),1);

bla=zeros(size(feature_test,1),size(feature_train,1)); 
sla=zeros(size(feature_test,1),size(feature_train,1));


for i=1:size(feature_test,1)
    for j=1:size(feature_train,1)
        bla(i,j)= sum(abs(feature_test(i,:)-feature_train(j,:)));
    end
    [bla(i,:),sla(i,:)]=sort(bla(i,:));
end

knn=zeros(size(feature_test,1),k); 
knn=sla(:,1:k);
for i=1:size(knn,1)
    uni=unique(label_train(knn(i,:)'));
    maxc=0;
    maxl=0;
    for j=1:length(uni)
        val=length(find(label_train(knn(i,:)')==uni(j)));
        if val>maxc
            maxl=uni(j);
            maxc=val;
        end
    end
    label_test_pred(i)=maxl;
end

end



