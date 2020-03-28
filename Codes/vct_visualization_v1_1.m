% Mohammad Asif Zaman
% Oct. 22, 2018 (Comments + integration)
% Plots the force profile data from mat file (from comsol data write)
% also plots the potential profile from mat file (from HHD)
% calculates the 1D potential profile from HHD data and direct integration
% and compares them.
%
% March 21, 2020
% Version v1
% Plotting 1D cutline, 2D contours and 3D surface slice plots

% ======================================================================>>>
% <<<======================================================================

clear all;
close all;
clc; clf;


% ======================================================================>>>
% <<<======================================================================


load test_field.mat;  % Loading data file

% Defining slice planes and slice lines


xref = 0;
yref = 0;
zref = 15;


% Sweeping variables. Data are plotted using the sweep variables. To change
% the plotting range, these variables must be adjusted. Any offsets to the
% coordinate system can be included here.

xsweep = squeeze(x_data(1,:,1))';
ysweep = squeeze(y_data(:,1,1));
zsweep = squeeze(z_data(1,1,:));


% Comparing the 1D potential
% ======================================================================>>>




F_y = interp3(x_data,y_data,z_data,Fy_data,xref,ysweep,zref,'spline',0);
F_x = interp3(x_data,y_data,z_data,Fx_data,xsweep,yref,zref,'spline',0);


F_y = squeeze(F_y);
F_x = squeeze(F_x);

% figure,
% plot(ysweep,F_y);
% hold on;
plot(xsweep,F_x,'r');
xlabel('x(\mum)'); ylabel('F(pN)');
legend('F_x');



% =========================================================================
% Visualizing the Field
% =========================================================================

% ======================================================================>>>

% XY, XZ, and YZ plane
% ======================================================================>>>

for fig_no = 1:3
    
    switch fig_no
        case 1
            x1 = xsweep; y1 = ysweep; z1 = zref;
        case 2
            x1 = xsweep; y1 = yref; z1 = zsweep;
        case 3
            x1 = xref; y1 = ysweep; z1 = zsweep;
    end
    
    
    
    [Xs Ys Zs] = meshgrid(x1,y1,z1);
    Xs = squeeze(Xs);
    Ys = squeeze(Ys);
    Zs = squeeze(Zs);
    
    switch fig_no
        case 1
            V1 = Xs; V2 = Ys; xlbl = 'x (\mum)'; ylbl = 'y (\mum)';
        case 2
            V1 = Xs; V2 = Zs; xlbl = 'x (\mum)'; ylbl = 'z (\mum)';
        case 3
            V1 = Ys; V2 = Zs; xlbl = 'y (\mum)'; ylbl = 'z (\mum)';
    end
    
    
    % The 'cubic' method only works for uniform grids.
    % So, spline is used for non-uniform grids. Otherwise, you would get a
    % MATLAB warning.
    
    Fsx = interp3(x_data,y_data,z_data,Fx_data,Xs,Ys,Zs,'spline',0);
    Fsy = interp3(x_data,y_data,z_data,Fy_data,Xs,Ys,Zs,'spline',0);
    Fsz = interp3(x_data,y_data,z_data,Fz_data,Xs,Ys,Zs,'spline',0);
    % us = interp3(x_data,y_data,z_data,u,Xs,Ys,Zs,'spline',0);
    
    % us = us.*1e-9*1e-12./(kB*T);
    
    figure;
    set(gcf,'units','normalized','outerposition',[.1 .1  .8 .8])
    
    subplot(311),contourf(V1,V2,Fsx,40,'linestyle','none');
    colorbar; title('Fx'); xlabel(xlbl); ylabel(ylbl);
    axis equal;
    % colormap(Cm);
    % caxis([-.2 .2]);
    
    
    subplot(312),contourf(V1,V2,Fsy,40,'linestyle','none');
    axis equal;
    colorbar;
    title('Fy');xlabel(xlbl); ylabel(ylbl);
    % colormap(Cm);
    % caxis([-.2 .2]);
    
    
    subplot(313),contourf(V1,V2,Fsz,40,'linestyle','none');
    axis equal;
    colorbar;
    title('Fz');xlabel(xlbl); ylabel(ylbl);
    
    colormap jet;
    
end

% <<<======================================================================

% 3D slice plots
% ======================================================================>>>

figure;
set(gcf,'units','normalized','outerposition',[.1 .1  .8 .8])

subplot(131);
z_slice2(x_data,y_data,z_data,Fx_data,'F_x');


subplot(132);
z_slice2(x_data,y_data,z_data,Fy_data,'F_y');


subplot(133);
z_slice2(x_data,y_data,z_data,Fz_data,'F_z');

colormap jet;



% <<<======================================================================
% <<<======================================================================





% 2D Quiver/arrow plots
% ======================================================================>>>

figure,
q_slice2(x_data,y_data,z_data,Fx_data,Fy_data,Fz_data,'y',0,'b',1);

% <<<======================================================================
