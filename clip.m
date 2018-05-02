function img_out=clip(img_in)
%Return the values of an array within a given range 
%finds the elements with nonzero values and crops the image to contain only
%the text
[f c]=find(img_in);
img_out=img_in(min(f):max(f),min(c):max(c));
end