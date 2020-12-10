function [rsi] = GetRSI(pcimg,delta)
%The function accepts a image 'pcimg' in radial co-ordinates. The first index
%should be the radial location while the second image should be the angular
%location. 

%Handle inputs:
if ~exist('delta','var')
    delta = 0.015;  % Default value is 0.05 microns. 
end

if ~exist('sigma','var')
    sigma = delta/6;  % Default value is calculated as 3sigma = delta. 
end

 %Remove NAN is now performed  in RSI
     pcimg = pcimg(any(~isnan(pcimg),2)==1,any(~isnan(pcimg),1)==1);

[m,~]=size(pcimg);
MAD = zeros(1, length(m));

for i = 1:m
MAD(i) = mad(pcimg(i,:),0);   
end

% Calculate the RSI
rsi = mean( (1 - 1./(1+exp((-MAD+delta)/sigma +4.6))));
%rsi = mean( (1 - 1./(1+exp((-MAD+delta)/sigma +4.6))).* ((sum(isnan(pcimg),2)>180)*0.5 +(sum(isnan(pcimg),2)<180)*1)'); %If there are more NAN's then reduce the symmetry to half.
end
