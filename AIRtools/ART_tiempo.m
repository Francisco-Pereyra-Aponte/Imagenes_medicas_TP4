N=240; %512
n_angles = 360; % 360
n_detect = 512; % 512
niter =5; % 10

fprintf('Kaczmarz\n');
theta = linspace(0,180,n_angles);
p = n_detect;
[A,b_ex,x_ex] = paralleltomo(N,theta,p);
x0_tiempo = reshape(x_ex, N, N);
save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /Again/original_timepo.mat'), 'x0_tiempo');
fprintf('tic');
tic;
Xkacz = kaczmarz(A,b_ex,niter);
toc;