
function [princComp,meanVec,projectimg,Evalues] = PCA_Train(data,dim)
[nDim nData] = size(data);
meanVec = mean(data,2);
data = data-repmat(meanVec,1,nData);


  [W, EvalueMatrix] = eig(cov(data'));
   Evalues = diag(EvalueMatrix);

% order by largest eigenvalue
    Evalues = Evalues(end:-1:end-dim);

    W = W(:,end:-1:end-dim); princComp=W';
  

% generate PCA component space (PCA scores)
   projectimg  = princComp * data;
