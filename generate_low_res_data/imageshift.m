function LR2=imageshift(I,tx,ty)
[x y]=size(I);
xdata=[1 x];
ydata=[1 y];
H=fft2(I);
u=1:1:x;
v=1:1:y;
for u=1:x
    for v=1:y
H1(u,v)=H(u,v).*exp(-1i*2*pi*((tx*u)/x+(v*ty)/y));
    end
end
LR2=real(ifft2(H1));
%figure;imshow(LR2);
%{
B=[1 0 0; 0 1 0; tx ty 1];
tform = affine2d(B);
[Iout IRout] = imwarp(I,tform);
%}
%T=maketform('affine',[1 0 0; 0 1 0; tx ty 1]);
%Ishift=imtransform(I,T,'bicubic','XData',xdata,'YData',ydata);