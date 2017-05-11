
clc
DataTest=[]
mkdir('testing');
format long
[namefile,pathname]=uigetfile({'*.bmp;*.tif;*.jpg;*.jpeg','IMAGE Files (*.bmp,*.tif,*.jpg,*.jpeg)'},'Chose  Image');
kk=0;
count=0;
if namefile~=0
    
    [im]=imread(strcat(pathname,namefile));
    [BWX]=extractSignTop5(im);
    
    
    for i = 1:size(BWX,3)
           
            imwrite(BWX(:,:,i),sprintf('testing/%d.bmp',i),'bmp');
            tmp=BWX(:,:,i);
            DataTest(:,i)=double(tmp(:));
            
        
    end
    
end

load('PCA_DATA.mat','DataTrain','princComp','meanVec','projectimg');

fprintf('Testing...\n');

testface=DataTest;
% testing
testface = double(testface)-repmat(meanVec,1,size(testface,2)); % mean subtracted vector

projtestimg = princComp*testface; % projection of test image onto the facespace
close all;
%%%%% calculating & comparing the euclidian distance of all projected trained images from the projected test image %%%%%
for j=1:size(testface,2)

for i=1 : size(projectimg,2)
    euclide_dist(i) = (norm(projtestimg(:,j)-projectimg(:,i)))^2;
    
end


[euclide_dist_min(j) recognized_index(j)] = min(euclide_dist);

timg=uint8(255.*reshape(DataTrain(:,recognized_index(j)),64,64));
tflag=0;
for x=1:64
    
    for y=1:64
        if(timg(x,y)~=0)
            tflag=1;
            count=count+1;
            h=msgbox('Traffic Sign Recognised');
            break;
        end
        if(tflag==1)
            break;
        end
    end
end  

if(tflag==1)
figure,subplot(1,2,1),imshow(uint8(255.*reshape(DataTest(:,j),64,64)));
subplot(1,2,2),imshow(uint8(255.*reshape(DataTrain(:,recognized_index(j)),64,64)));
[euclide_dist, idx]=sort(euclide_dist,'ascend');
[euclide_dist', idx']
n=recognized_index(j);

end

end
[euclide_dist_min' recognized_index']

if(count==0)
    if(tflag==0)
     h=msgbox('Traffic Sign Not Recognised');
    end
end