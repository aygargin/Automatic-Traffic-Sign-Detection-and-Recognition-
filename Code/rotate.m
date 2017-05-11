clc
clear
close all


[file_namesX]=dir('datargb1/*.jpg');
mkdir('datargb');
kk=-15;
kkk=0;
for x=1:length(file_namesX(:,1))    
    kkk=kkk+1;
a=imread(sprintf('datargb1/%s',file_namesX(x,:).name));
kk=-15;
for y=1:31
    i=a;
i=imrotate(i,kk);
kk=kk+1;
imwrite(i,sprintf('datargb/%d_%d_%s',kkk,kk,file_namesX(x,:).name));
end
end
'rotation complete'




