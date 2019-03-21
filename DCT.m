clear
clc
RGB = imread('autumn.tif');
I = rgb2gray(RGB);

% I2=I(1:10,1:10);
I3=imresize(I,[10,10]);

J = dct2(I);
J3 = dct2(I3);

figure
subplot(121),imshow(I),title('Input Image')
subplot(122),imshow(log(abs(J)),[]),title('DCT')

% colormap(gca,jet(64))
% colorbar

J(abs(J) < 10) = 0;
J3(abs(J3) < 10) = 0;


K = idct2(J);
K3 = idct2(J3);


figure
imshowpair(I3,K3,'montage')
title('Original Grayscale Image (Left) and Processed Image (Right)');
