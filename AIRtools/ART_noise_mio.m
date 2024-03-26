%Noise

N=256;
N_noise = 10;
aux = round(linspace(1,10,N_noise));
eta = aux/100;
n_angles = 100;
n_detect = 128;
niter =10;

for i=eta
    theta = linspace(0,180,n_angles);
    p = n_detect;
    i_aux = round(i*100);
    fprintf('Noise level: %d /100\n',i_aux);
    [A,b_ex,x_ex] = paralleltomo(N,theta,p);
    im_ex_noise = reshape(x_ex, N, N);
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/NOISE/original_noise_%d.mat',i_aux),'im_ex_noise');

    delta = i*norm(b_ex);
    % Add noise to the rhs.
    randn('state',0);
    e = randn(size(b_ex));
    e = delta*e/norm(e);
    b = b_ex + e;

    Xkacz = kaczmarz(A,b,niter);
    Xsymk = symkaczmarz(A,b,niter);
    Xrand = randkaczmarz(A,b,niter);
    Xsart = sart(A,b,niter);

    Xkacz = reshape(Xkacz, N, N);
    Xsymk = reshape(Xsymk, N, N);
    Xrand = reshape(Xrand, N, N);
    Xsart = reshape(Xsart, N, N);

    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/NOISE/kacz_noise_%d.mat',i_aux),'Xkacz');
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/NOISE/symk_noise_%d.mat',i_aux),'Xsymk');
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/NOISE/rand_noise_%d.mat',i_aux),'Xrand');
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/NOISE/sart_noise_%d.mat',i_aux),'Xsart');
end
