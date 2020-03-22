% Mohammad Asif Zaman
% Original version: 2017-2018
% Current version: March, 2020
% Code for plotting functions of 3 independent variables
% 
% Input arguments:
%   x,y,z       : Independent variables
%   f           : Function/dependent variable
%   Nx, Ny, Nz  : No. of slice planes (along x, y and z axes)
%   str         : String, label of the colorbar
%   cax         : 2 x 1 array, limit of colorbar

function yout = z_slice2(x,y,z,f,str,cax,Nx,Ny,Nz,varargin)



%  Default values
if nargin < 7
    Nx = 1;
    Ny = 1;
    Nz = 7;
end

% Minimum and maxium range of the independent variables
% ======================================================================>>>
xmin = min(x(:));
ymin = min(y(:));
zmin = min(z(:));

xmax = max(x(:));
ymax = max(y(:));
zmax = max(z(:));
% <<<======================================================================



% Position of the slice planes
% ======================================================================>>>
if Nx > 0
    xslice = linspace(xmin,xmax,Nx + 2);
    xslice = xslice(2:end-1);
else
    xslice = [];
end

if Ny > 0
    yslice = linspace(ymin,ymax,Ny + 2);
    yslice = yslice(2:end-1);
else
    yslice = [];
end
% Turn the following two lines to make the z slices in the middle
% zslice = linspace(zmin,zmax,Nz + 2);
% zslice = zslice(2:end-1);

zslice = linspace(zmin,zmax,Nz);

% <<<======================================================================




% Plotting the slice planes
h = slice(x,y,z,f,xslice,yslice,zslice);
% set(h,'linestyle','none');

set(h,'EdgeColor','none',...
'FaceColor','interp',...
'FaceAlpha','interp')

alpha(.3)  % set transparency

% alphamap('rampdown')
% alphamap('increase',.1)


% colorbar and colormap
hb = colorbar('northoutside');
colormap hot;

%  Axis labels
xlabel(hb,str);
xlabel('x'); ylabel('y'); zlabel('z');

if nargin > 5;
    caxis(cax);
end

% View angle
view([-37.5 12]);  


