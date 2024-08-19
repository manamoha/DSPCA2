%% Q2

clear all
close all


%% loading picture
originalPic = imread('tiger.jpg');
figure(1);imshow(originalPic);title("original");

%% DCT of picture
DCTPic = dct2(originalPic);
figure(2);
imshow(log(abs(DCTPic)))
colormap parula
colorbar

%% Copression :
Percentage = 0.05;      % change it to 5 or 

%% Compression 1  :  threshold

%finding the threshold
CompressionPercentage =1 - Percentage;
sortedCoefficients = sort(abs(DCTPic(:)), 'descend');
numCoefficients = size(sortedCoefficients);
thresholdIndex = round(CompressionPercentage * numCoefficients(1));
thresholdValue = sortedCoefficients(thresholdIndex);

%filtering the datas that are less than threshold
compressedDctImage1 = DCTPic .* (abs(DCTPic) >= thresholdValue);

figure(3);imshow(log(abs(compressedDctImage1)));title("threshold");
colormap parula
colorbar

%% Inverse of compressed DCT 1
CompressedPic1 = uint8(idct2(compressedDctImage1));
figure(4);imshow(CompressedPic1);title("threshold");
imwrite(CompressedPic1, 'Compressed1.jpeg')

%% Copression 2  :  triangle zero

[rows, columns] = size(DCTPic);

a = sqrt(2 * Percentage);

RowNum = floor(rows * a);
ColNum = floor(columns * a);

m = ColNum / RowNum;
n = 0;
compressedDctImage2 = DCTPic;
for i = 0 : RowNum
    num = ceil(-1*m*i)+ColNum;
    n = n+num;
    compressedDctImage2(rows-i, end-num : end) = 0;
end


figure(5); imshow(log(abs(compressedDctImage2)));title("triangle zero");
colormap parula
colorbar

%% Inverse of compressed DCT 2

CompressedPic2 = uint8(idct2(compressedDctImage2));
figure(6);imshow(CompressedPic2);title("triangle zero");
imwrite(CompressedPic2, 'Compressed2.jpeg')

%% Compression 3  :  row and column omitting
S=size(DCTPic);
m = S(1)/S(2);
num = Percentage / (1+m);
I=S(1) - round(S(1)*num*m);J=S(2) - round(S(2)*num);
compressedDctImage3(1:I,1:J)=DCTPic(1:I,1:J);
figure(5); imshow(log(abs(compressedDctImage3)));
 

%% Inverse of compressed DCT 3
CompressedPic3 = uint8(idct2(compressedDctImage3));
figure(6); imshow(CompressedPic3);title("row co omitted");
imwrite(CompressedPic3, 'Compressed3.jpeg')
 
%% plotting all
 figure(9)
 subplot(2,2,1);imshow(originalPic);title("original");
  subplot(2,2,2);imshow(CompressedPic1);title("threshold");
   subplot(2,2,3);imshow(CompressedPic2);title("triangle zero");
    subplot(2,2,4);imshow(CompressedPic3);title("row co omitted");
 