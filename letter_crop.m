%function lines%

%function letter_in_a_line
function [fl re space]=letter_crop(im_text)
% Divide letters in lines
im_text=clip(im_text);

index_num=size(im_text,2);

for s=1:index_num
    sum_col = sum(im_text(:,s));
    if sum_col==0
        fltm=im_text(:,1:s-1); % First letter matrix
        rm=im_text(:,s:end);% Remaining line matrix
        fl = clip(fltm);
        re=clip(rm);
        space = size(rm,2)-size(re,2);
       break
    else
        fl=im_text;%Only one line.
        re=[ ];
        space = 0;
    end
end





