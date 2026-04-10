% To animate the Flight of Butterfly
%-------------------------------------------------------------------------
% Code written by : Siva Srinivas Kolukula                                |
%                   Senior Research Fellow                                |
%                   Structural Mechanics Laboratory                       |
%                   Indira Gandhi Center for Atomic Research              |
%                   India                                                 |
% E-mail : allwayzitzme@gmail.com                                         |
%          http://sites.google.com/site/kolukulasivasrinivas/             |
%-------------------------------------------------------------------------
clear all ;clc ;
N = 5000 ;
t = linspace(0,20*pi,N);
% Parametric Equations for Butterfly Curve
x = sin(t).*(exp(cos(t))-2*cos(4*t)+sin(t/12).^5);
y = cos(t).*(exp(cos(t))-2*cos(4*t)+sin(t/12).^5);
% Normalizing the Parametric Equations
x = x./max(abs(x)) ;
y = y./max(abs(y)) ;
% Show Butterfly
h = figure ;
set(h,'color', 'k','Menubar','none') ;
plot(x,y,'r') ;
title('Butterfly','Color','w','Fontsize',10);
axis([-1.3 1.3 -1.3 1.3])
axis off ;
% Seperating positive and negative numbers in x and y 
ppos = 0 ;
npos = 0 ;
for i = 1:N
    if sign(x(i)) == 1
        ppos = ppos+1 ;
        px(ppos) = x(i) ;
        py(ppos) = y(i) ;
    elseif sign(x(i)) == -1
        npos = npos+1 ;
        nx(npos) = x(i) ;
        ny(npos) = y(i) ;
    end
end
pz = ones(1,length(px)) ;
nz = ones(1,length(nx)) ;
% Plot starts
fh = figure ;
set(fh,'name','Butterfly','numbertitle','off','color', 'k','Menubar','none') ;
Rwing = plot3(px,py,pz,'Color','r','Linewidth',1) ; % Right Wing
hold on
Lwing = plot3(nx,ny,nz,'Color','r','Linewidth',1) ; % Left Wing
title('Butterfly Flight','Color','w','Fontsize',10);
range = 3 ;
axis([-10*range 20*range -range range -range range])
axis off ;
stop = uicontrol('style','toggle','string','stop','background','white');
% Wing Flapping Properties
amp = 70 ;                  % Amplitude of Wing Flapping
frequency = 500. ;          % Frequency of Wing Flapping
time = linspace(0,10,N) ;   % Duration of Flight (Simulation time)
% Transformation Functions for Wing Flapping
% For Right Wing
Tp = @(time) [amp*cos(frequency*time) 0  -sin(frequency*time) ;
                       0              1            0          ;
              sin(frequency*time)     0   cos(frequency*time)] ; 
% For Left Wing
Tn = @(time) [cos(frequency*time)  0  sin(frequency*time) ;
                     0             1         0             ;
              -sin(frequency*time) 0  cos(frequency*time)] ; 
% Animation for flight of Butterfly starts

for i = 1:N
      pp = Tp(time(i))*[px ;py; pz] ;
      pp = pp' ;
      npx = px + t(i)*ones(1,length(px)) ;
      npy = py+py.*cos(t(i)) ;
      npz = pp(:,3)+pp(:,3).*sin(t(i)) ;
      set(Rwing,'XData',npx,'YData',npy,'ZData',npz) ;
      nn = Tn(time(i))*[nx ;ny; nz] ;
      nn = nn' ;
      nnx = nx+t(i)*ones(1,length(nx)) ;
      nny = ny+ny.*cos(t(i)) ;
      nnz = nn(:,3)+nn(:,3).*sin(t(i)) ;
      set(Lwing,'XData',nnx,'YData',nny,'ZData',nnz) ; 
      if get(stop,'value')==0
      drawnow ;
      elseif get(stop,'value')==1
          break
      end
end 
set(stop,'style','pushbutton','string','close','callback','close(fh)');
    