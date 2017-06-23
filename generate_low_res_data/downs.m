function Il=downs(Ir,dfact);
Ir=downsample(Ir,dfact);
 Ir=Ir';
 Ir = downsample(Ir,dfact);
 Il=Ir';
