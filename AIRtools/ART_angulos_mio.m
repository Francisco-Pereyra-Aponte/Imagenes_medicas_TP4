%Angulos 

fprintf('Comenzando la iteración de angulos\n');

N = 246;
N_angles = round(linspace(10, 200, 10));
n_detect = 128;
niter = 10;
eta = 0.01;

for i = N_angles
    theta = linspace(0, 180, i);
    p = 128;
    fprintf('Proyección de %d ángulos\n', i);
    [A,b_ex,x_ex] = paralleltomo(N,theta,p);
    im_ex_angles = reshape(x_ex, N, N);
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/ANGLES/original_angles_%d.mat', i), 'im_ex_angles');

    delta = eta*norm(b_ex);

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

    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/ANGLES/kacz_angles_%d.mat', i), 'Xkacz');

    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/ANGLES/symk_angles_%d.mat', i), 'Xsymk');

    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/ANGLES/rand_angles_%d.mat', i), 'Xrand');

    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/ANGLES/sart_angles_%d.mat', i), 'Xsart');
end


