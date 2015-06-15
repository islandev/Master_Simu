function [C,opt]=eigenvalue_estimation(Cx,n,varargin);
% EIGENVALUE_ESTIMATION improves estimation of the eigenvalues of a covariance matrix
% This MATLAB function is an algorithm designed to improve the eigenvalue estimates of Wishart-
% distributed covariance matrices and to recompute an improved covariance matrix from the 
% eigenvalues. The function is an implementation of the procedure developed and published by 
% Avishai Ben-David and Charles E. Davidson, "Eigenvalue Estimation of Hyperspectral Wishart 
% Covariance Matrices From Limited Number of Samples", IEEE Trans. Geosci. Remote Sens., Vol. 50, % no. 11, pp. 4384- 4396, November 2012. 
%
% Usage
%
%   [C,opt]=eigenvalue_estimation(Cx,n,varargin);
%
% Input
%
%   Cx       - p-by-p covariance matrix or p-by-1 vector of eigenvalues in
%              descending order (i.e., as returned by SVD).  If Cx is a p-by-p
%              covariance matrix it is assumed to be symmetric and positive
%              semi-definite.
%   n        - scalar, number of degrees of freedom used in computing the
%              sample covariance matrix (number of vectors minus 1)
%   varargin - optional input variables using property/value pair syntax
%              (i.e., comma-separated list syntax, see VARARGIN for more).
%              The following properties are supported: 
%
%              't', scalar value indicating the transition point between large
%                 and small eigenvalues.  The default value is [] which means
%                 that either MDL or a successive linear regression method
%                 will be used to estimate it.  Valid values are in the range
%                 2:p.
%
%              'MDL', logical scalar, specifying whether minimum description
%                 length should be used for determining the transition point,
%                 't', between small and large eigevnalues.  Default is true
%                 so the MDL is used.  False will use the successive linear
%                 regression method described in the TGRS paper, Eq. (12).  In
%                 general MDL is a good method for n/p<10.
%
%              'g', function handle defining a monotonic transformation of the
%                 eigenvalues that is applied prior to estimating 't' using
%                 the successive linear regressions.  The default is the
%                 anonymous function @(x)x which is the identity transform and
%                 represents computing the regression in "linear-scale".  Use
%                 @log for "log-scale".  In the paper estimating 't' using
%                 linear-scale was better for Telops data; estimating 't'
%                 using log-scale was better for SEBASS.  The function in 'g'
%                 will only be used if 'MDL' is set to false.
%
%              'm', p-by-1 apparent multiplicity curve.  Default is [] so that
%                 'm' will be estimated from equations (8-9) from the paper.
%                 In the paper, the apparent multiplicity is called "p_i".
%
% Output
%
%   C   - p-by-p corrected covariance matrix or p-by-1 vector of corrected
%         eigenvalues 
%   opt - (optional) struct containing values of the optional input arguments
%         used internally inside the function
%
% Notes
%
%   This function implements the eigenvalue correction and estimation procedure outlined in 
%   Ben-David and Davidson, TGRS 50(11), 4384-4396 (2012), which is designed
%   to improve the eigenvalue estimates of Wishart-distributed covariance
%   matrices.  It lacks the simulation and evaluation functionality of the
%   full code and only implements the correction procedure on a single sampled
%   covariance matrix (or spectrum of eigenvalues).
%
%   This function accepts either a covariance matrix or a vector of
%   eigenvalues. In the former case, the output will be a corrected
%   covariance matrix recreated using an SVD decomposition, where the
%   corrected eigenvalues take the place of the sample eigenvalues (but sample
%   eigenvectors are unaltered, for lack of knowledge). In the latter case,
%   the output will simply be a vector of corrected eigenvalues.
%
%   In the TGRS paper, we show through simulation that this procedure is able
%   to "adjust" the sample eigenvalues so that they are better estimates
%   (overall) of the eigenvalues of the population covariance matrix while
%   simultaneously improving the condition number of the covariance matrix.
%   The resulting (inverse) corrected covariance matrices improved detection
%   performance of the matched filter compared to using the original (inverse)
%   sample covariance matrix, and also improved over the Effron-Morris
%   estimator of the inverse covariance (an example of the empirical-Bayes
%   class of estimators) which takes the form of diagonal loading.  The
%   "two-subset" method (which is a technique to remove bias at the expense of
%   higher variance) showed slightly improved detection results when used in
%   the matched filter, though it is less good at improving the eigenvalue
%   estimates.
%
%   EXAMPLES
%
%      %generate some artificial input data for demo purposes
%      sx=sort(exp(randn(125,1)).*2,'descend'); %eigenvalues
%      n=300;                                   %d.o.f.
%
%      %a corresponding artificial covariance matrix
%      U=orth(rand(125)); %eigenvectors
%      Cx=U*diag(sx)*U.'; %covariance matrix
%
%      %use all defaults passing sx as input (output is corrected e.v.)
%      [s,opt]=eigenvalue_estimation(sx,n);
%
%      %use all defaults passing Cx as input (output is corrected cov. matrix)
%      
%[C,opt]=eigenvalue_estimation(Cx,n);
%      %note that C = U*diag(s)*U.'; 
%
%      %instead of MDL use the successive regression method (in linear space)
%      [s,opt]=eigenvalue_estimation(sx,n,'MDL',false);
%
%      %instead of MDL use the successive regression method (in log space)
%      [s,opt]=eigenvalue_estimation(sx,n,'MDL',false,'g',@log);
%
%      %specify a particular value of t to use
%      [s,opt]=eigenvalue_estimation(sx,n,'t',5);
%
% Last Documented Change: 12/10/12, CED (R2010b)

 
if nargin<2 || isempty(n) || isempty(Cx)
    error('"Cx" and "n" must be passed.');
end
 
%defaults for optional inputs (stored in a structure where the field name and
%value defines the property/value pairs)
opt.t=[];     %allow user to specify a particular value of the transition point
opt.MDL=true; %use MDL for estimating t by default if 't' is empty
opt.g=@(x)x;  %use linear-scale when 'MDL' is false and 't' is empty
opt.m=[];     %allow user to specify a particular multiplicity curve
 
%override defaults with user inputs
opt=localParseVarargin(opt,varargin); %subfunction
 
%number of dimensions
p=length(Cx);
 
if numel(Cx)==p
    %Cx is really a vector of eigenvalues, not a covariance matrix
    covarianceFlag=false;
    sx=Cx(:); %column vector
else
    %Cx is a covariance matrix
    covarianceFlag=true;
    
    %compute eigenvalues
    [U,S]=svd(Cx); %V=U'
    sx=diag(S);
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%step 1: shifted eigenvalues%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if isempty(opt.m) || numel(opt.m)~=p
    %multiplicity curve needs to be estimated
    opt.m=multiplicity(sx,n); %subfunction
end
 
%adjust the eigenvalues
k=opt.m(:)./n; %column vector
s=sx.*(1+k)./(1-k).^2;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%step 2: energy normalization%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if isempty(opt.t)
    %transition location between large and small eigenvaules needs to be
    %estimated (the "knee" of the scree plot)
    
    if opt.MDL
        %default method is to use MDL (which is reasonable for n/p<10 and for
        %eigenvalue spectra that are not "too peaked")
        opt.t=local_MDL_knee(sx,n); %subfunction
    else
        %use the successive regression method...whether the transition point
        %is computed in "linear-space" or "log-space" will depend on the
        %function g.  By default g is linear.  Log-space is achieved by
        %setting g to be @log.  Any other transformation may be specified
        %using the function handle syntax, but problems will arise if g is not
        %monotonic, and so arbitrary g is not recommended...
        opt.t=find_the_knee(opt.g(sx)); %subfunction
    end
end
 
%by definition t must be within the range of 2 to p (in case user passed in an
%invalid value)
opt.t=max(min(opt.t,p),2);
 
large=1:opt.t-1; %index for large eigenvalues
small=opt.t:p;   %index for small eigenvalues
 
actual1=sum(s(small));  %trace of (small) corrected eigenvalues
target1=sum(sx(small)); %desired trace for small eigenvalues
 
actual2=sum(s(large));  %trace of (large) corrected eigenvalues
target2=sum(sx(large)); %desired trace for large eigenvalues
 
s(small)=s(small).*target1./actual1;
s(large)=s(large).*target2./actual2;
 
%re-sort
s=sort(s,'descend');
 
if covarianceFlag
    %user passed in the sample covariance, pass out the corrected covariance
    %matrix using the original eigenvectors and the corrected eigenvalues
    C=U*diag(s)*U';
else
    %user passed in the eigenvalues, just pass out corrected eigenvalues
    C=s;
end
 
return;
 
 
function prop=localParseVarargin(prop,v);
%LOCALPARSEVARARGIN A vastly simplified local version of PARSEVARARGIN that
%   will cycle through the optional input arguments and the fields of the
%   property/value pair struct and override the default values in the struct
%   with user-set values.  If the same property is matched twice, the last one
%   passed in varargin will be used.  Matching is case-insensitive, but
%   otherwise must be exact (abbreviations won't match).  Note also that there
%   are no warnings for failed matches (failed matches are simply ignored).
 
   %number of elements in v (which is the cell array varargin)
   numv=length(v);
   
   if mod(numv,2)
       %number of elements in varargin should have been even
       error(['Improper property/value pair syntax ',...
           '(odd number of elements appearing in varargin)']);
   end
   
   %get fields we will test for
   propNames=fieldnames(prop);
   N=length(propNames);
   
   for i=1:2:numv
       %for each odd input element
       for j=1:N
           %check all property names
           if strcmpi(v{i},propNames{j})
               %assign new value if there is a match
               prop.(propNames{j})=v{i+1};
           end
       end
   end
 
 
function m=multiplicity(s,n);
%MULTIPLICTY Subfunction to estimate of the apparent multiplicity, Eq. (9)
%   from paper, using theoretical bounds on the value of the sampled
%   eigenvalue (as a function of n,p and the population eigenvalue).  We don't
%   know the population eigenvalue, so we use the sampled eigenvalue, instead.
%   This is similar to how in a GLRT the estimated parameters take the place
%   of the population parameters in the likelihood ratio (for lack of
%   knowledge).
 
    p=numel(s);
    
    %approximate bounds on the eigenvalues used in Eq. (8) that are derived
    %from the Marcenko-Pastur law
    k=p./n;        %band-to-vector ratio
    rootk=sqrt(k); %for convenience
    
    lim=s(:)*(1-[rootk -rootk]).^2; %[a b]
        
    %Eq. (9)
    for i=p:-1:1
        m(i,1)=sum(lim(i,2)<=lim(:,2) & lim(i,2)>=lim(:,1));
    end
    
    %limit the multiplicity curve so that it can't decrease once it has
    %reached a maximum, Eq. (10)
    [maxm,loc]=max(m);
    
    if m(end)~=maxm
        m(loc:end)=maxm;
    end
 
 
function t=find_the_knee(s);
%FIND_THE_KNEE Estimate the transition point between large and small
%   eigenvalues using the successive regressions from the left and right (see
%   Eq. (12) from paper).  The terminology is based on the idea of a "scree"
%   plot, where it is common to try to find the "crook" or "elbow" or "knee"
%   of the curve.
 
    p=numel(s);
    x=(1:p)';
    
    %initialize residuals
    res1(p-2,1)=0;
    res2=res1;
    
    for i=2:p-1
        %compute the "from the left" residual curve 
        [P1,R1]=polyfit(x(1:i),s(1:i),1);
        res1(i-1)=R1.normr;
        %res1(i-1,1)=norm(polyval(P1,x)-s);
        
        %compute the "from the right" residual curve 
        [P2,R2]=polyfit(x(i:p),s(i:p),1);
        res2(i-1)=R2.normr;
        %res2(i-1,1)=norm(polyval(P2,x)-s);
    end
    
    %the transition point is the location the residual curves intersect
    [t,t]=min(abs(res1-res2));
    t=t+1;
    
 
function t=local_MDL_knee(s,n);
%LOCAL_MDL_KNEE Local subfunction based on Avi Ben-David's MDL_KNEE function.
%   This function just returns the value of the transition in the scree plot
%   (none of the other outputs returned by the main function are needed).
 
    p=numel(s);
    
    MDL(p-1,1)=0; %initialize
    
    %for efficiency (no need to recompute inside of loop)
    logn=log(n);
    
    for k=1:p-1
        Es=mean(s(k+1:p));    %arithmetic mean
        Gs=geomean(s(k+1:p)); %geometric mean
        
        MDL(k)=-(p-k).*n.*log(Gs./Es)+0.5.*k.*(2.*p-k).*logn;
    end
    
    [t,t]=min(MDL);


