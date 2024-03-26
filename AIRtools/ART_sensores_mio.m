% Definir la función ART
% Creo los vectores a iterar


% DETECTORES

fprintf('Comenzando la iteración de detectores\n');

N = 240; % imagen de salida
N_deetct = 10; % cantidad de pasos de detectores 
niter = 10; 
n_angles_fijo = 100; % numeor angulos
n_detects = round(linspace(60, 300, N_deetct));
eta = 0.01;

for i = 1:N_deetct
    fprintf('Iteración %d de %d\n', i, N_deetct);
    theta = linspace(0, 180, n_angles_fijo);
    p = n_detects(i);
    fprintf('Detectores: %d\n', p);
    [A,b_ex,x_ex] = paralleltomo(N,theta,p);
    img_ex_detects = reshape(x_ex, N, N);
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/DETECTORES/original_detectores_%d.mat',p), 'img_ex_detects');

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

    %SAVES
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/DETECTORES/kacz_detectores_%d.mat', p), 'Xkacz');
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/DETECTORES/symk_detectores_%d.mat', p), 'Xsymk');
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/DETECTORES/rand_detectores_%d.mat', p), 'Xrand');
    save(sprintf('/Users/franpereyraaponte/Library/CloudStorage/OneDrive-UTNSanFrancisco/I. BALSEIRO/4to Cuatrimestre 2024/Imagenes Médicas/Práctica 4 /MATLAB/DETECTORES/sart_detectores_%d.mat', p), 'Xsart');

end 

