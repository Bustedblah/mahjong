function readHand(filename)

% Clear all the mess from previous runs
%clear all
%close all
%clc

pkg load all

% Create the folder for the results

path=strcat(filename,'_identify');
if exist(path)==7
else
    mkdir(path)
end
 
Pic=imread(filename); 

Pic_R=Pic(:,:,1);
Pic_G=Pic(:,:,2);
Pic_B=Pic(:,:,3);

size_v = size(Pic,1);
size_h = size(Pic,2);

%This is the filter for what mahjong tiles look like
ind_comb=find(Pic_R<150 & Pic_B<150 & Pic_G<150);
ind_comb2=find(abs(Pic_R-Pic_B)>15 || abs(Pic_G-Pic_B)>15 || abs(Pic_R-Pic_G)>15);

binImg=ones(size(Pic,1),size(Pic,2));
binImg(ind_comb)=0;
binImg(ind_comb2)=0;

gray = rgb2gray(Pic.*binImg);

scaleFactor = 0.05;

tileWidth = 1+3/32;
tileHeight = .75+1/32;

%TODO: This is the part that takes mad long and should be updated.
G = fspecial('gaussian',[20 20],10);
Ig = imfilter(binImg,G,'same')>.4;
processed = logical(imresize(Ig,scaleFactor)>.3);

%STATS_temp  = regionprops(processed, 'all');
imshow(processed)





% BELOW IS RANDOM TEXT THAT CAN BE EFFECTIVELY DISCARDED:


%a = 1+3/32
%a = 1.0938
%b = 0.75+1/32
%b = 0.78125
%
%a/b
%ans =  1.4000
%a/(2*b)
%ans =  0.70000
%a/(3*b)
%ans =  0.46667
%size(pic(1))/size(pic(2))
%ans =  1.00000
%size(pic,1)/size(pic,2)
%ans =  0.68064
%a/(4*b)
%ans =  0.35000

% A.3 Start the loop for the different parts of the puzzle 

% for p=1:3  
%    %
%    %A.3.1 Name of the part
%    %Old Code: Name_part=strcat('Raw_images\puzzle2_(',num2str(p),' of 3)_400dpi.tif');
%    Name_part=strcat('hand(',num2str(p),' of 3).jpg');
%    %
%    %A.3.2 Read the part (i.e. image of the puzzle)
%    Part=imread(Name_part);
%    %
%    %A.3.3 Create the RGB matrices
%    Part_R=Part(:,:,1);
%    Part_G=Part(:,:,2);
%    Part_B=Part(:,:,2);
%    %
%    %A.3.4 Identify pink zones 
%    ind_comb=find(Part_R>251 & Part_G<50);
%    %
%    %A.3.5 Part_pink=Image where all the pink zones are equal to zero
%    Part_pink=ones(size(Part,1),size(Part,2));
%    Part_pink(ind_comb)=0;
%    Part_pink(1:TL_corner_y(p,1),1:TL_corner_x(p,1))=0;
%    %
%    %A.3.6 Binarize the part_pink image
%    cc_temp=bwlabel(Part_pink,8);
%    %
%    %A.3.7 Statistics analysis of the part_pink binary image (TEMPORARY IMAGE)
%    STATS_temp = regionprops(cc_temp,'all');
%    counter=0;
%    for i=1:size(STATS_temp,1)
%        display(strcat('Part number',num2str(p),'-Progress=',num2str(100*i/size(STATS_temp,1))));
%        if STATS_temp(i,1).Area<500 %%%IMPORTANT: Remove all the parts thar are too small to be a piece of paper
%            ind=find(cc_temp==i);
%            Part_pink(ind)=0; %%%We consider these small parts to be part of the Part_pink background image and set them to zero
%            clear ind
%        end
%    end
%
%%A.3.8 Re-binarize the part_pink image which has been clean with A.3.7
%cc=bwlabel(Part_pink,8);
%%
%%A.3.9 New statistics analysis with the clean binary image
%%->>Identification of the pieces of paper
%STATS = regionprops(cc,'all');
%%
%%A.3.10 Plot to check we made a good (blow-)job with the identification process 
%imagesc(cc)
%set(gca,'Visible','off')
%for i=1:size(STATS,1)
%    text(STATS(i,1).Centroid(1,1)-15,STATS(i,1).Centroid(1,2)+25,num2str(i),'FontSize',8,'Rotation',90,'FontWeight','demi')    
%end
%saveas(gcf,strcat(path_A,'Puzzle5_part',num2str(p),'.png'),'png')
%close(gcf)
%%
%%A.3.11 Save the statistics file: Identification of the pieces of paper
%save(strcat(path_A,'STATS_part',num2str(p)),'STATS');
%%
%save indices p path_A TL_corner_x TL_corner_y
%clear all
%close all
%load indices
%%
%end
