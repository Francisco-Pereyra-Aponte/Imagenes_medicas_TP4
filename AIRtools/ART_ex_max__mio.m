%expectation_maximization

N=246; %
n_angles = 200; % 
n_detect = 128; % 
niter =10; % 10

fprintf('INICIO\n');

theta = linspace(0,180,n_angles);
p = n_detect;
[A,b_ex,x_ex] = paralleltomo(N,theta,p);
x_ex = reshape(x_ex,N,N);
figure,imagesc(x_ex), colormap gray, axis image, title('x original')

save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/EXPMAX/original.mat'), 'x_ex');

x_0 = zeros(size(x_ex));
it = round(linspace(1,niter,niter));

for K=it
    fprintf('Iteracion %d\n',K);
    tic
    [x_0,options] = ex_max(A,b_ex,K);
    toc
    x_0 = reshape(x_0,N,N);
    figure,
    imagesc(x_0), colormap gray, axis image, title('reconstruccion con iteraciones',K)

    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/EXPMAX/EM_%d',K), 'x_0');
end

fprintf('FIN\n');