UbitName = '########';
personNumber = '#######';
data = xlsread ('university data.xlsx', 'C2:F50');

%Extracting individual variables from the entire data set
V1 = data(:,1);
V2 = data(:,2);
V3 = data(:,3);
V4 = data(:,4);

%Calculating the mean values for individual variables
mu1 = mean (V1);
mu2 = mean (V2);
mu3 = mean (V3);
mu4 = mean (V4);

%Calculating the variance values for individual variables
var1 = var(V1);
var2 = var(V2);
var3 = var(V3);
var4 = var(V4);

%Calculating the standard deviation values for individual variables
sigma1 = std(V1);
sigma2 = std(V2);
sigma3 = std(V3);
sigma4 = std(V4);

%Mean vector for the entire data set
mu_data = mean(data);

%Std. Deviation vector for the entire data set
sigma_data = std(data);

%Generating the covariance Matrix for the entire data set. (A 4*4 matrix)
covarianceMat = cov (data);

%Generating the corelation Matrix for the entire data set. (A 4*4 matrix)
correlationMat = corr (data);
 
%Calculating logLikelihood for the data set
logLikelihood=0;
for a = 1:4
logLikelihood = logLikelihood+sum(log(normpdf(data(:,a),mu_data(a),sigma_data(a))));
end
 


%BNloglikelihood as a minimum value for comparison
BNlogLikelihood = logLikelihood;

%Looking at the correlation values, the following BNmatrix was observed
BNgraph_mat=[0 0 0 0; 1 0 1 1; 0 0 0 1; 1 0 0 0];
%Initialising with value 0
logLike_BNgraph = 0;
for x =1:4
index_1 = find(BNgraph_mat(:,x));
if not(isempty(index_1))
indexes = [x;index_1];
indexes_t=indexes.';
index_1t=index_1.';
num_pdf = sort(indexes_t);
den_pdf = sort(index_1t);
loglike_num = sum(log(mvnpdf(data(:,num_pdf),mu_data(num_pdf),covarianceMat(num_pdf,num_pdf))));
loglike_den = sum(log(mvnpdf(data(:,den_pdf),mu_data(den_pdf),covarianceMat(den_pdf,den_pdf))));
logLike_BNgraph = logLike_BNgraph + (loglike_num - loglike_den);
else
loglike =  sum(log(mvnpdf(data(:,x),mu_data(x),covarianceMat(x,x))));
logLike_BNgraph = logLike_BNgraph + loglike;
end
end
if logLike_BNgraph>BNlogLikelihood
BNlogLikelihood = logLike_BNgraph;
BNgraph = BNgraph_mat;
end



%Saving the required variables in a .mat file
save('proj1.mat', 'UbitName', 'personNumber', 'mu1', 'mu2', 'mu3', 'mu4', 'var1', 'var2', 'var3', 'var4', 'sigma1', 'sigma2', 'sigma3', 'sigma4', 'covarianceMat', 'correlationMat', 'logLikelihood', 'BNlogLikelihood', 'BNgraph');





