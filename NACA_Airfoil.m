function [x, y] = NACA_Airfoil(m, p, t, c, N, varargin)
%NACA_AIRFOIL  takes in the specs of a NACA 4-digit airfoil and produces 
%  (x,y) coordinates depending on the number of panels desired...also 
%  produces a plot of the airfoil.
%  
%  
%  Inputs:		m	- max camber
%  				p	- location of max camber
%  				t	- thickness
%  				c	- chord length
%  				N	- number of panels to use
%
%  Outputs:		x	- vector of x-locations of boundary points
%  				y	- vector of y-locations of boundary points
%  
%  Example calls:	
%  		[x, y] = NACA_Airfoil(m, p, t, c, N)
%  		[x, y] = NACA_Airfoil(m, p, t, c, N, 'PlotsOff')
% 
%  
%  Created by:     Keith Covington
%  Created on:     10/12/2017
%  Last modified:  10/21/2017
% *************************************************************************

plotsOn = true;
if ~isempty(varargin)
	if any( strcmp('PlotsOff', varargin) )
		plotsOn = false;
	end
end

set(0, 'defaulttextInterpreter', 'latex') % plotting necessities

% Define x-coordinates
thetaCirc = linspace(pi, 0, N+1);
x = c/2 .* (1+cos(thetaCirc));

% Define NACA airfoil name from function inputs
airfoilName = ['NACA ' num2str(m*100) num2str(p*10) num2str(t*100)];

% Define thickness of NACA 4-digit series airfoil
y_thickness  = (0.12/0.2*c) .* ( 0.2969.*sqrt(x./c) - 0.1260.*(x./c) ... 
			- 0.3516.*(x./c).^2 + 0.2843.*(x./c).^3 - 0.1036.*(x./c).^4 );

% Define (x,y) coords--a piecewise function where the first piece goes from
% the LE to max camber and second piece goes from max camber to TE.
xFront = x(x>=0 & x<=p*c);	% find indices for first piece of camber line
xBack = x(x>p*c & x<=c);	% find indices for first piece of camber line

if m == 0 && p ==0
	y_camber = zeros(1, length(x));
	dy_camber = zeros(1, length(x));
else
	% Define camber line
	y_camber_front = m.*xFront./p^2 .* (2*p - xFront./c);
	y_camber_back = m .* (c-xBack)./(1-p)^2 .* (1 + xBack./c - 2*p);
	y_camber = [y_camber_front y_camber_back];

	% Define angle of camber line
	dy_camber_front = 2*m/(c*p^2) .* (c*p-xFront);
	dy_camber_back = 2*m/(c*(1-p)^2) .* (c*p-xBack);
	dy_camber = [dy_camber_front dy_camber_back];
end

% Define (x,y) coordinates
camberAngle = atan(dy_camber);
x_U = x - y_thickness .* sin(camberAngle);
x_L = x + y_thickness .* sin(camberAngle);
y_U = y_camber + y_thickness .* cos(camberAngle);
y_L = y_camber - y_thickness .* cos(camberAngle);

% Remove redundant LE point
x_U(1) = [];
y_U(1) = [];

% Concatenate upper and lower surfaces
x_surface = [ fliplr(x_L) x_U ];
y_surface = [ fliplr(y_L) y_U ];

% Plot airfoil
if plotsOn
	figure
	hold on
	grid on
	axis equal
	camberPlot = plot(x, y_camber);
	surfacePlot = plot(x_surface, y_surface, 'o-');
	title(['NACA ' num2str(m*100) num2str(p*10) num2str(t*100)])
	xlabel('x [m]')
	ylabel('y [m]')
	%axis([min(x_surface) max(x_surface) 1.1*min(y_surface) 1.1*max(y_surface)])
	for i = 1:length(thetaCirc)
		linesX_radial = linspace(-c/2, c/2) .* cos(thetaCirc(i)) + c/2;
		linesY_radial = linspace(-c/2, c/2) .* sin(thetaCirc(i));
		linesX_radial = [linesX_radial(1) linesX_radial linesX_radial(end)];
		linesY_radial = [0 linesY_radial 0];
		plot(linesX_radial,linesY_radial, '--','Color',[0 0 0]+0.7)
		% plot circle
		theta_circ = linspace(0, 2*pi);
		x_circ = c/2 .* cos(theta_circ) + c/2;
		y_circ = c/2 .* sin(theta_circ);
		plot(x_circ, y_circ, '--','Color',[0 0 0]+0.7)
	end
	legend([camberPlot surfacePlot], {'Camber line', 'Surface'})
end

% Return statement
x = x_surface;
y = y_surface;


