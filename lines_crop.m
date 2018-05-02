%function lines%

function [fl re]=lines_crop(im_text)
% Divide text into lines
% im_text->input image; fl->first line; re->remain line

im_text=clip(im_text);
index_num=size(im_text,1);

for s=1:index_num
    if sum(im_text(s,:))==0
        flm=im_text(1:s-1, :); % First line matrix
        rm=im_text(s:end, :);% Remain line matrix
        fl = clip(flm);
        re=clip(rm);
        break
    else
        fl=im_text;%Only one line.
        re=[ ];
    end
end

