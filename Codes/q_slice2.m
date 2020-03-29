function q_slice2(x,y,z,fx,fy,fz,plane,cut_val,type,scale)


% Notes written on Jan 18, 2018
% x,y,z are 3D meshgrid
% fx,fy,fz are functions of x,y,z in 3D meshgrid format
% plane = x,y or z. cut_val = position of the sliced plane
% type = 'c' for color. Anything else will result in monochromatic quiver
% scale = size of the arrows

[Ny,Nx,Nz] = size(x);

if plane == 'z'
    z_cut = cut_val;
    tmp = abs(z-z_cut);
    
    ind = find(tmp == min(tmp(:)));
    ind2 = ind(1:Nx*Ny); % ind might find multiple non-unique cut planes. ind2 takes only the first plane.
    % Note that the size of a plane should is equal to the product of the of the lenght of
    % the dimensions that span that
    % plane.
    %     quiver(x(ind2),y(ind2),fx(ind2),fy(ind2),'linewidth',1,'color','red');
    
    if type == 'c'
        quiverc(x(ind2),y(ind2),fx(ind2),fy(ind2));
    else
        quiver(x(ind2),y(ind2),fx(ind2),fy(ind2),scale);
    end

    box on;
    axis tight;
    
    xlabel('x');  ylabel('y'); 
    title(['z = ' num2str(z_cut) ' plane'],'color','black');
    
elseif plane == 'x'
    x_cut = cut_val;
    tmp = abs(x-x_cut);
    
    ind = find(tmp == min(tmp(:)));
    ind2 = ind(1:Ny*Nz);
    
    % ind might find multiple non-unique cut planes. ind2 takes only the first plane.
    % Note that the size of a plane should is equal to the product of the of the lenght of
    % the dimensions that span that
    % plane.
    %     quiver(x(ind2),y(ind2),fx(ind2),fy(ind2),'linewidth',1,'color','red');
    
    if type == 'c'
        quiverc(y(ind2),z(ind2),fy(ind2),fz(ind2));
    else
        quiver(y(ind2),z(ind2),fy(ind2),fz(ind2),scale);
    end
    box on;
    axis tight;
    xlabel('y');  ylabel('z');
    title(['x = ' num2str(x_cut) ' plane'],'color','black');
    
else
    y_cut = cut_val;
    tmp = abs(y-y_cut);
    ind = find(tmp == min(tmp(:)));
    ind2 = ind(1:Nx*Nz); % ind might find multiple non-unique cut planes. ind2 takes only the first plane.
    % Note that the size of a plane should is equal to the product of the of the lenght of
    % the dimensions that span that
    % plane.
    %     quiver(x(ind2),y(ind2),fx(ind2),fy(ind2),'linewidth',1,'color','red');
    if type == 'c'
        quiverc(x(ind2),z(ind2),fx(ind2),fz(ind2));
    else
        quiver(x(ind2),z(ind2),fx(ind2),fz(ind2));
    end
    box on;
    axis tight;
    
    
    xlabel('x');  ylabel('z');
    title(['y = ' num2str(y_cut) ' plane'],'color','black');
end
set(gca,'fontsize',12)
