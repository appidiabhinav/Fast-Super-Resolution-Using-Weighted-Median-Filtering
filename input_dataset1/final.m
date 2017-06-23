 up1 = im2double(imread('a1.jpg'));
 up2 = im2double(imread('a2.jpg'));
 up3=  im2double(imread('a3.jpg'));
 up4 = im2double(imread('a4.jpg'));
 up5 = im2double(imread('a5.jpg'));
 up6 = im2double(imread('a6.jpg'));
 up7 = im2double(imread('a7.jpg'));
  
up1=imresize(up1,0.5);
up2=imresize(up2,0.5);
up3=imresize(up3,0.5);
up4=imresize(up4,0.5);
up5=imresize(up5,0.5);
up6=imresize(up6,0.5);
up7=imresize(up7,0.5);

R=1;
[rows cols]=size(up1);
fin=zeros([rows cols]);
for x=1:rows
    for y=1:cols
        [rr cc]=meshgrid(1:rows,1:cols);
        C=((rr-x).^2+(cc-y).^2)<= R^2;
        pts = [rr(C) cc(C)]; 
        N = size(pts,1);
        sigma = 0.1;
        for k=1:N
            weight(k) = exp((-1*((x - pts(k,1))^2 + (y - pts(k,2))^2 ))/(2*(sigma^2)));
            d1(k)=up1(pts(k,1),pts(k,2));
            d2(k)=up2(pts(k,1),pts(k,2));
            d3(k)=up3(pts(k,1),pts(k,2));
            d4(k)=up4(pts(k,1),pts(k,2));
            d5(k)=up5(pts(k,1),pts(k,2));
            d6(k)=up6(pts(k,1),pts(k,2));
            d7(k)=up7(pts(k,1),pts(k,2));
        end
        d=[d1 d2 d3 d4 d5 d6 d7];
        [q1 q2]=size(d);
        [Y,I]=sort(d); %Y gives sorted d i.e w
        t=zeros(1,q2);
        for e=1:q2
            if mod(I(e),N)==0
                t(e)=weight(N);
            else
                t(e)=weight(mod(I(e),N));%t gives sorted weights i.e c
            end
        end
        u=cumsum(t);
        S=u(q2);
         for p=1:q2
            if u(p)>S/2
                break;
            end
        end
        fin(x,y)=Y(p);
    end
end
PSF = fspecial('gaussian',[3 3],0.5);
output = deconvwnr(fin,PSF,0);
figure;imshow(output);
figure;subplot(3,3,1);imshow(output);title('output image');subplot(3,3,2);imshow(up1);title('low res 1');subplot(3,3,3);imshow(up2);title('low res 2');subplot(3,3,4);imshow(up3);title('low res 3');subplot(3,3,5);imshow(up4);title('low res 4');subplot(3,3,6);imshow(up5);title('low res 5');subplot(3,3,7);imshow(up6);title('low res 6');subplot(3,3,8);imshow(up7);title('low res 7');
