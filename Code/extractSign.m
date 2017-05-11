function [bw]=extractSign(a)
[h,w]=size(a);
scale=1024.0/w;
a=imresize(a,scale);
%figure(1),imshow(a);
b= a(:,:,1)>75 & a(:,:,2)<75 & a(:,:,3)<75;
b = bwareaopen(b, 10);

%figure(2),imshow(b);
cc = bwconncomp(b, 4)

for i=1:cc.NumObjects
    
    ss(i)=length(cc.PixelIdxList{i});
    
end

[~,idx]=sort(ss,'descend');
grain = false(size(b));
grain(cc.PixelIdxList{idx(1)}) = true;
%figure(3),imshow(grain);
[rows,cols]=find(grain);
c=grain(min(rows):max(rows),min(cols):max(cols));
%figure(4),imshow(c); % red component
d=a(min(rows):max(rows),min(cols):max(cols),:);
%figure(5),imshow(d);
e=(c==0);
[rows,cols]=find(e);

%figure(6),imshow(e); % ROI
for i=1:length(rows)
    
    flag=0;
    
    for jj=1:cols(i)
        
       if(c(rows(i),jj))
          flag=flag+1;
          break;
           
       end
    end
    
    for jj=cols(i):size(c,2)
        
       if(c(rows(i),jj))
          flag=flag+1;
          break;
           
       end
    end
    
    
    for ii=1:rows(i)
        
       if(c(ii,cols(i)))
          flag=flag+1;
          break;
           
       end
    end
    
    
    for ii=rows(i):size(c,1)
        
       if(c(ii,cols(i))==1)
          flag=flag+1;
          break;
           
       end
    end
    
    if flag~=4
        d(rows(i),cols(i),:)=0;
        e(rows(i),cols(i))=0;
    end
    
end

%figure(7),imshow(d);
%figure(8),imshow(e);
[rows,cols]=find(~e);
f=d;
%%figure(9),imshow(f);
for i=1:length(rows)
    f(rows(i),cols(i),:)=0;
end
%figure(9),imshow(f);
%imwrite(rgb2gray(f),'C:\Extras\data\minor_project\datagray\45.jpg');

level = graythresh(f);
bw = im2bw(f,level);
bw = bwareaopen(bw, 1);

bw=imresize(bw,[64 64]);

%figure(10),imshow(bw);
