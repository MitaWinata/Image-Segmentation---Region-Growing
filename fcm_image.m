function [labelledImage, e] = fcm_image( I, n_clusters )
%%
% This function will segment an image using Fuzzy-C mean method based on a
% given number of clusters
% This function will use MATLAB build in function 'fcm'
% INPUT
%   n_clusters =  Positive integer representing the number of clusters
% OUTPUT
%   labelledImage = Segmented image
%   e = Computation time
%
% EXAMPLE OF USAGE
%   Suppose one wants to segment an image, I, using Fuzzy-C-means method with n clusters
%   The callback of this function can be as follows:
%       fcm_image( I, n )
% Here the parameters will be set to default and the iteration will not be
% display:
%  - exponent for the matrix U    : 2.0
%  - maximum number of iterations : 100
%  - minimum amount of improvement: 1e-5
%  - info display during iteration: 0
%%
t = cputime;
[i_height, i_width, rgb] = size(I);
% Image matrix needs to be rearranged before passed in to the function
% Need to make the image to be 2D
data = double(I)./double(max(I(:)));
data = reshape(data,i_height*i_width,rgb);

%Generate the cluster using fcm
opts = [nan;nan;nan;0];
[center, U] = fcm(data, n_clusters, opts);
% Extract the cluster index from the generated matrix
[temp,cluster_idx] = max(U);
% To save memory clear the unnecessary file
clear temp;
% Construct a new matrix based on the clustered generated
lbl = reshape(cluster_idx,i_height,i_width);

labelledImage = label2rgb(uint8(lbl));
e = cputime - t;
end

