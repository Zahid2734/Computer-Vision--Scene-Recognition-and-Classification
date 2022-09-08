
import build_visual_dictionary.*
import compute_bow.*
import classify_knn_bow.*

% Getting Result

[conf,acc]=classify_knn_bow;
figure();
imagesc(conf);
colormap jet;
xticks(1:1:15)
xticklabels({'Kit','Sto','Bed','Liv','Off','Ind','Sub','Cty','Bid','St','HW','OC','Cst','Mnt','For'})
yticks(1:1:15)
yticklabels({'kitchen','store','bedroom','livingroom','office','Industrial','suburb','Insidecity','Tallbuilding','street','Highway','OpenCountry','Coast','Mountain','Forest'})
xlabel(['Accuracy(%) :',num2str(acc )])