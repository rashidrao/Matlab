%% Image Compression with the Discrete Cosine Transform

clear
clc

I = imread('cameraman.tif');
I = im2double(I);

T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);

mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);


invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[8 8],invdct);

imshow(I)

figure
imshow(I2)




%%  Compression Ratio Calculation
f=I;
imwrite(f,'Image1_50.jpg','Quality',50)
% imwrite(f,'Image1.jpg');

k=imfinfo('Image1.jpg');
k3=imfinfo('Image1_50.jpg');


ib=k.Width*k.Height*k.BitDepth/8;
cb=k.FileSize;
cr=ib/cb

f2=I2;
imwrite(f2,'Image2.jpg');
k2=imfinfo('Image2.jpg');

ib2=k2.Width*k2.Height*k2.BitDepth/8;
cb2=k2.FileSize;
cr2=ib2/cb2

%% Compression Ratio
rgb_size=size(I2);

num_mem_bytes = prod(rgb_size)
s = dir('Image2.jpg');
num_file_bytes = s.bytes

r = num_mem_bytes / num_file_bytes

