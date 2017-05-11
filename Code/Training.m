function Training()

[file_namesX]=dir('datargb/*.jpg');
mkdir('training_images');
kk=0;
DataTrain=[];
for x=1:length(file_namesX(:,1))
kk=kk+1;    
a=imread(sprintf('datargb/%s',file_namesX(x,:).name));

[bw]=extractSign(a);
DataTrain(:,kk)=bw(:);
imwrite(bw,sprintf('training_images/%s',file_namesX(x,:).name));
end
% PCA
dim=min([size(DataTrain,1)/2 size(DataTrain,2)/2]);
[princComp,meanVec,projectimg,LInv]=PCA_Train(DataTrain,dim);
save('PCA_DATA.mat','DataTrain','princComp','meanVec','projectimg','LInv');


'training complete'