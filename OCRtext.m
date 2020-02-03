I = imread('download-1.jpg');
%imshow(I);
I = rgb2gray(I);
I = imbinarize(I);
I = imtophat(I,strel('cube',6));

 
 %% 
  p = imread('download-1.jpg');
 blob = vision.BlobAnalysis('MaximumCount',500);
 [area,centroids,roi] = step(blob,I);
 %imshow(insertShape(p,'rectangle',roi));
 
 %% 
 areaConstraint = area>300;
 
 roi = double(roi(areaConstraint,:));
 
 %img = insertShape(p,'rectangle',roi);
 %imshow(img);
 
 %%
 width = roi(:,1);
 height = roi(:,2);
 aspectRatio = width ./ height;
 
 roi = roi(aspectRatio > 0.2 & aspectRatio <1,:);
 %roi = roi-4;
 %roi = roi+6;
 
 img = insertShape(p,'rectangle',roi);
 ocrRes = ocr(img,roi);
 
 imshow(insertObjectAnnotation(p,'rectangle',ocrRes.WordBoundingBoxes,ocrRes.Words));

 