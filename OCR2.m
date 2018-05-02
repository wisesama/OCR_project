%% OCR implementation
function  OCR2(image)
figure,imshow(image);
title('INPUT IMAGE ')
% Convert to gray 
  if size(image,3)==3 
     image=rgb2gray(image);
  end
% Convert to BW
threshold = graythresh(image);

image =~im2bw(image,threshold);

% Remove all object less than 10 pixels
image = bwareaopen(image,10);
%Storage matrix word from image 
word=[ ];
re=image;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% count the number of letters in template file
num_letters=size(templates,2);
while 1
    %Function 'lines_crop' separate lines in text
    [fl re]=lines_crop(re); %fl= first line, re= remaining image
    fline=fl;
    n=0;                   %scamcounting index 
    spacevector = [];      % to compute the total spaces between                    
    rc= fl;              
   
    while 1
        %Fcn 'letter_crop' separate letters in a line
       [fc rc space]=letter_crop(rc);  
       %fc =  first letter in the line
       %rc =  remaining cropped line
       %space = space between the letter
       %cropped and the next letter
       im_r = imresize(fc,[42 24]);   %resize letter so that correlation
                                       %can be performed
       n = n + 1;
       spacevector(n)=space;
       
       %Fcn 'read_letter' correlates the cropped letter with the images
       letter = read_letter(im_r,num_letters);
       
       %letter concatenation
       word = [word letter];
       
       if isempty(rc)  %breaks loop when there are no more characters
           break;
        end
    end
    
      
        
    max_space = max(spacevector);
    no_spaces = 0;
    
     for x= 1:n   %loop to introduce space at requisite locations
       if spacevector(x+no_spaces)> (0.75 * max_space)
          no_spaces = no_spaces + 1;
            for m = x:n
              word(n+x-m+no_spaces)=word(n+x-m+no_spaces-1);
            end
           word(x+no_spaces) = ' ';
           spacevector = [0 spacevector];
       end
     end
   
      
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end
end
fclose(fid);
%Open 'text.txt' file
winopen('text.txt')
clear all
end
