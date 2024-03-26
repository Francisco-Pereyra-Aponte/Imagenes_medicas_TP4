%ARTdemo (script) Demonstrates the use of, and the results from, the ART methods.
%
% This script illustrates the use of the ART methods kaczmarz, symmetric
% kaczmarz, and randomized kaczmarz.
%
% The script creates a parallel-beam test problem, adds noise, and solves
% the problems with the ART methods.  The exact solution and the results
% from the methods are shown.
%
% See also: nonnegdemo, SIRTdemo, trainingdemo.

% Maria Saxild-Hansen and Per Chr. Hansen, Mar 11, 2011, DTU Compute.

close all
fprintf(1,'\nStarting ARTdemo:\n\n');

% Set the parameters for the test problem.
N = 50;           % The discretization points. imagen salida grande
theta = 0:5:179;  % No. of used angles. cantida de proyecciones 
p = 75;           % No. of parallel rays. cantidad de sensores
eta = 0.05;       % Relative noise level. nivel de ruido

fprintf(1,'Creating a parallel-bema tomography test problem\n');
fprintf(1,'with N = %2.0f, theta = %1.0f:%1.0f:%3.0f, and p = %2.0f.',[N,theta(1),theta(2)-theta(1),theta(end),p]);

% Create the test problem.
[A,b_ex,x_ex] = paralleltomo(N,theta,p); % A: matriz de proyecciones, b_ex: proyecciones, x_ex: imagen original

% Noise level.
delta = eta*norm(b_ex);

% Add noise to the rhs.
randn('state',0);
e = randn(size(b_ex));
e = delta*e/norm(e);
b = b_ex + e;

% Show the exact solution.
figure
imagesc(reshape(x_ex,N,N)), colormap gray, % imagen original muestra con un shape de NxN 
axis image off
c = caxis;
title('Exact phantom')

% No. of iterations.
k = 10;

fprintf(1,'\n\n');
fprintf(1,'Perform k = %2.0f iterations with Kaczmarz''s method.',k);
fprintf(1,'\nThis takes a moment ...');

% Perform the kaczmarz iterations.
Xkacz = kaczmarz(A,b,k); % A: matriz de proyecciones, b: proyecciones, k: numero de iteraciones, devuelve la imagen reconstruida

% Show the kaczmarz solution.
figure
imagesc(reshape(Xkacz,N,N)), colormap gray,
axis image off
caxis(c);
title('Kaczmarz reconstruction')

fprintf(1,'\n\n');
fprintf(1,'Perform k = %2.0f iterations with the symmetric Kaczmarz method.',k);
fprintf(1,'\nThis takes a moment ...');

% Perform the EM iterations.
XEm = ex_max(A,b,k);

% Show the EM solution.
figure
imagesc(reshape(XEm,N,N)), colormap gray,
axis image off
caxis(c);
title('EM reconstruction')

fprintf(1,'\n\n');
fprintf(1,'Perform k = %2.0f iterations with the EM method.',k);
fprintf(1,'\nThis takes a moment ...\n');

% Perform the symmetric kaczmarz iterations.
Xsymk = symkaczmarz(A,b,k); % simetrico

% Show the symmetric kaczmarz solution.
figure
imagesc(reshape(Xsymk,N,N)), colormap gray,
axis image off
caxis(c);
title('Symmetric Kaczmarz reconstruction')

fprintf(1,'\n\n');
fprintf(1,'Perform k = %2.0f iterations with the randomized Kaczmarz method.',k);
fprintf(1,'\nThis takes a moment ...\n');

% Perform the randomized kaczmarz iterations.
Xrand = randkaczmarz(A,b,k); % aleatorio 

% Show the randomized kaczmarz solution.
figure
imagesc(reshape(Xrand,N,N)), colormap gray,
axis image off
caxis(c);
title('Randomized Kaczmarz reconstruction')

% Hacer sart

