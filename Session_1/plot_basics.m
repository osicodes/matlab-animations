%% Animated plot

%% *** 2D Plot ***
% Using equation of the response of a dynamiic system 

t = 0:0.1:10;

y_t = 1 - exp(-0.6*t).*cos(0.5*t) + exp(-0.6*t).*sin(0.5*t);

%% Plot the response of the system
figure('Name',"Response plot")

plot(t,y_t,'Color','r','LineWidth',2)
xlabel('time')
ylabel('y(t)')
legend('Response y(t)')

%% Animate 2D using the animatedline object

axis([0,10,0,1.5])
% h = animatedline;
h = animatedline('Color','r','LineWidth',3);

% Uncomment to use "getframe"
% loops = length(t);
% movieVector(loops) = struct('cdata',[],'colormap',[]);
for k = 1:length(t)
    addpoints(h,t(k),y_t(k));

    drawnow
    % pause(0.01);

    % Uncomment to use "getframe"
    % fig = gcf; % current figure handle
    % movieVector(k) = getframe(fig);
end

%% Animate 2D by plotting in for loop
loops = length(t);
movieVector(loops) = struct('cdata',[],'colormap',[]);
for k = 1:length(t)
    plot(t(k),y_t(k),"Marker","x",'LineWidth',3)
    hold on
    plot(t(1:k),y_t(1:k),'Color','r','LineWidth',3)

    axis([0,10,0,1.5])
    xlabel('time')
    ylabel('y(t)')
    legend('y(t) marker','Response y(t)')

    % drawnow
    % pause(0.01);
    fig = gcf; % current figure handle
    movieVector(k) = getframe(fig);


    if k ~= length(t)
        clf
    end
end

%% Create animation
myGif = VideoWriter('mygif');
myGif.FrameRate = 20;

open(myGif)
writeVideo(myGif, movieVector)
close(myGif)


%% *** 3D Plot ***
% Using Helix equation

t = 0:pi/12:2*pi;

x_t = 5 * cos(t);
y_t = 5 * sin(t);
z_t = 2 * t;

%% Animate 3D by plotting in for loop

loops = length(t);
movieVector(loops) = struct('cdata',[],'colormap',[]);
for k = 1:length(t)
    plot3(x_t(k),y_t(k),z_t(k),'bo','MarkerSize', 10, ...
        'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b')
    hold on
    plot3(x_t(1:k),y_t(1:k),z_t(1:k),'Color','r','LineWidth',2)

    axis([-5, 10, -10, 10, 0, 15])
    xlabel('x(t)')
    ylabel('y(t)')
    ylabel('z(t)')
    angle = t(k);
    title(['Time: ', num2str(angle), ' seconds'])
    legend('marker','Helix')
    % view([220 40])
    view([220+5*angle 40]) % Rotates the camera line of sight
    grid on

    fig = gcf; % current figure handle
    movieVector(k) = getframe(fig);

    if k ~= length(t)
        clf
    end
end

%% Create animation
myGif = VideoWriter('mygif3dRot');
myGif.FrameRate = 10;

open(myGif)
writeVideo(myGif, movieVector)
close(myGif)