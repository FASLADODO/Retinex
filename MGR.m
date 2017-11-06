%%%%%%%%%%%%%%%%%%%%%%%%%%
%Muti-Guidefilter-Retienx%
%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
strhead = '3';%the name of file
strtail = '.jpg' ;% the format of the file
str = strcat(strhead,strtail);
I = imread(str);%read the image .
Ir=I(:,:,1);
Ig=I(:,:,2);
Ib=I(:,:,3); 
Ir_double=double(Ir);
Ig_double=double(Ig);
Ib_double=double(Ib); 

tic
%% �����˲������նȷ���
%
figure;subplot(2,3,1);imshow(I);title('ԭͼ'); 
I_double=double(I)/255;
I_gray =rgb2gray(I_double);
p = I_gray;
[m,n]=size(I);
r=800;
%
eps1 = 0.01;
G1 = guidedfilter(I_gray, p, r, eps1);
%
eps2 = 0.1;
G2 = guidedfilter(I_gray, p, r, eps2);
%
eps3 = 1;
G3 = guidedfilter(I_gray, p, r, eps3);

G=0.25*G1+0.5*G2+0.25*G3;
subplot(2,3,2);imshow(G),title('�����˲�');
string=strcat(strhead,'guidefilter.jpg');
imwrite(G,string);

%%%%%%%%�նȷ����Աȶ�����%%%%%%%
%
%����Ӧ��������
G=imread(string);
otsu = graythresh(G) %Otsu��ֵ
BW = im2bw(I,otsu); %�õõ�����ֱֵ�Ӷ�ͼ����ж�ֵ��
subplot(2,3,3);imshow(BW);title('Otsu��ֵ');
G=double(G);
G=255./(1+1.05.^(255*otsu-G));
subplot(2,3,5);imshow(uint8(G)),title('�Աȶ�����');
string=strcat(strhead,'illumination.jpg');
imwrite(uint8(G),string);
%}
%%%%%��ͼ��ת����������%%%%%% 
%G=imread(strhead,'guidefilter.jpg');
G=double(G);
Ir_log=log(Ir_double+1);
Ig_log=log(Ig_double+1);
Ib_log=log(Ib_double+1);
G_log=log(G+1);

%%%%��ͨ������ԭͼ���նȷ���%%%%
Rr_log=Ir_log-G_log; 
Rg_log=Ig_log-G_log; 
Rb_log=Ib_log-G_log; 

%%%%%% ��������
%
Rr = uint8(255*exp(Rr_log)); 
Rg = uint8(255*exp(Rg_log));
Rb = uint8(255*exp(Rb_log));

toc
%%%%%%��ʾ%%%%%%
R=cat(3,Rr,Rg,Rb);
subplot(2,3,6);imshow(R);title('MGR');
string=strcat(strhead,'MGR.jpg');
imwrite(R,string);
%}