function ocrbuiltin(image)
figure,imshow(image);
im=ocr(image);
fid = fopen('text.txt', 'wt');
fprintf(fid,'%s\n',im.Text);
fclose(fid);
winopen('text.txt')
end