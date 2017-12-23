function varargout = Vortex_Panel(x, y, V_inf, alpha, varargin)
%VORTEX_PANEL  applies the vortex panel method for an arbitrary 2D body 
%  defined by a set of (x,y) coordinates that defines its surface.
%  
%  This function:
%  	- Reads in the list of points
%  	- Reads in necessary flow conditions (e.g., the free-stream flow speed 
%  	  and angle of attack)
%  	- Forms the system of equations
%  	- Solves the system of equations
%  	- Plots the coefficient of pressure resulting from calculations
%  	- Returns the sectional coefficient of lift resulting from calculations
%  
%  Inputs:		x 		- vector containing x-positions of coordinates
%  				y		- vector containing x-positions of coordinates
% 						(first and last entriesofxandycorrespond to the 
%  						trailing edge)
%  				V_inf	- freestream velocity
%  				alpha	- angle of attack
%
%  Outputs:		c_l 	- sectional coefficient of lift
%  
%  Example calls:	
%    c_l = Vortex_Panel(x, y, V_inf, alpha)
%    c_l = Vortex_Panel(x, y, V_inf, alpha, 'PlotsOff')
%    [c_l, cp] = Vortex_Panel(x, y, V_inf, alpha)
%    [c_l, cp, x_c_pc] = Vortex_Panel(x, y, V_inf, alpha, 'PlotsOff');
%    [c_l, cp, x_c_pc, S] = Vortex_Panel(x, y, V_inf, alpha, 'PlotsOff');
%  
%  Created by:     Keith Covington
%  Created on:     10/12/2017
%  Last modified:  10/25/2017
% *************************************************************************

plotsOn = true;
if ~isempty(varargin)
	if any( strcmp('PlotsOff', varargin) )
		plotsOn = false;
	end
end


set(0, 'defaulttextInterpreter', 'latex') % plotting necessities

c = max(x(:));			% chord length
alpha = alpha*pi/180;	% convert angle of attack to radians

% Preallocate
m 			= length(x)-1; % number of panels
x_control 	= NaN(1,m);
y_control 	= NaN(1,m);
S 			= NaN(1,m);
sine 		= NaN(1,m);
cosine 		= NaN(1,m);
theta 		= NaN(1,m);
V 			= NaN(1,m);
cp 			= NaN(1,m);
gamma		= NaN(1,m+1);
rhs			= NaN(1,m);
cn1			= NaN(m);
cn2			= NaN(m);
ct1			= NaN(m);
ct2			= NaN(m);
an			= NaN(m+1);
at			= NaN(m+1);


% Coordinates of control points, (x_control, y_control)
% Panel lengths, S
for i = 1:m
	x_control(i) 	= 0.5 * ( x(i) + x(i+1) );
	y_control(i) 	= 0.5 * ( y(i) + y(i+1) );
	S(i) 			= sqrt( (x(i+1)-x(i))^2 + (y(i+1)-y(i))^2 );
	theta(i)		= atan2( y(i+1)-y(i), x(i+1)-x(i) );
	sine(i) 		= sin(theta(i));
	cosine(i) 		= cos(theta(i));
	rhs(i)  		= sin(theta(i)-alpha);
end

for i = 1:m
	for j = 1:m
		% Add diag instead
		if i==j
			cn1(i,j) = -1;
			cn2(i,j) = 1;
			ct1(i,j) = 0.5*pi;
			ct2(i,j) = 0.5*pi;
		else
			A = -(x_control(i)-x(j))*cosine(j) - (y_control(i)-y(j))*sine(j);
			B = (x_control(i)-x(j))^2 + (y_control(i)-y(j))^2;
			C = sin( theta(i)-theta(j) );
			D = cos( theta(i)-theta(j) );
			E = (x_control(i)-x(j))*sine(j) - (y_control(i)-y(j))*cosine(j);
			F = log(1 + S(j)*( S(j) + 2.*A )/B);
			G = atan2( E*S(j), B+A*S(j) );
			P = (x_control(i)-x(j)) * sin( theta(i)-2.*theta(j) ) ...
			  + (y_control(i)-y(j)) * cos( theta(i)-2.*theta(j) );
			Q = (x_control(i)-x(j)) * cos( theta(i)-2.*theta(j) ) ...
			  - (y_control(i)-y(j)) * sin( theta(i)-2.*theta(j) );
			cn2(i,j) = D + 0.5*Q*F/S(j) - (A*C+D*E)*G/S(j);
			cn1(i,j) = 0.5*D*F + C*G - cn2(i,j);
			ct2(i,j) = C + 0.5*P*F/S(j) + (A*D-C*E)*G/S(j);
			ct1(i,j) = 0.5*C*F - D*G - ct2(i,j);
		end
	end
end

% Compute the influence coefficients
for i = 1:m
	an(i,1)		= cn1(i,1);
	an(i,m+1)	= cn2(i,m);
	at(i,1)		= ct1(i,1);
	at(i,m+1)	= ct2(i,m);
	for j = 2:m
		an(i,j) = cn1(i,j) + cn2(i,j-1);
		at(i,j) = ct1(i,j) + ct2(i,j-1);
	end
end
an(m+1,1)	= 1;
an(m+1,m+1)	= 1;
for j = 2:m
	an(m+1,j) = 0;
end
rhs(m+1) = 0;

% Solve for dimensionless strengths gamma using Cramer's rule. Then compute 
% and print dimensionless velocity and pressure coef at control points.

gamma = an\(rhs');

for i = 1:m
	V(i) = cos( theta(i)-alpha );
	for j = 1:m+1
		V(i) = V(i) + at(i,j)*gamma(j);
		cp(i) = 1 - V(i)^2;
	end
end

% Plot Cp over airfoil
x_control_perCord = x_control./c;
if plotsOn
	figure
	plot(x_control_perCord, cp, '*-')
	set(gca,'Ydir','reverse')
	title('$C_p$ Distribution')
	xlabel('x/c [\%]')
	ylabel('$C_p$')
end

%gamma_control = gamma(1:end-1) + diff(gamma)/2; % strength of gamma at control points
%Gamma = sum(gamma_control' .* S);
%c_l = 2*Gamma / (V_inf*c);
Gamma = sum(V .* S);
c_l = 2*Gamma / (c);


%% Return statement
varargout{1} = c_l;
varargout{2} = cp;
varargout{3} = x_control_perCord;
varargout{4} = S;
