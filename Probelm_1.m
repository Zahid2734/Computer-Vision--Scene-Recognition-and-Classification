import get_tiny_image.*
import predict_knn.*
import classify_knn_tiny.*

% Getting Result

[conf,acc]=classify_knn_tiny;
figure(3);
imagesc(conf);
colormap jet;
xticks(1:1:15)
xticklabels({'Kit','Sto','Bed','Liv','Off','Ind','Sub','Cty','Bid','St','HW','OC','Cst','Mnt','For'})
yticks(1:1:15)
yticklabels({'kitchen','store','bedroom','livingroom','office','Industrial','suburb','Insidecity','Tallbuilding','street','Highway','OpenCountry','Coast','Mountain','Forest'})
xlabel(['Accuracy(%): ',num2str(acc)])