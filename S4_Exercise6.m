%S4_Exercise6
%Ergonomic Analysis of VDU Workplaces in 3D

clear
clc
close all

%% Load data
load( 'ErgonomicsExampledata.mat' )

%% Calculate the distance d between the head and the plane spanned by the screen.
 a = STR - STL;
 b = SBR - STR;
 c = cross(a,b);
 HS = SBR - H;
 d = dot(HS,c)/norm(c);

%% At which point P does the line from H to the screen intersect the screen plane?

P = H + d * c / norm(c);

%% Create a figure to check your results.
figure
hold on
plot3([H(1), SBR(1), SBL(1), STR(1), STL(1)], [H(2), SBR(2), SBL(2), STR(2), STL(2)], [H(3), SBR(3), SBL(3), STR(3), STL(3)], 'ok') %Plot screen and head positions
plot3([SBR(1), SBL(1), STL(1), STR(1), SBR(1)], [SBR(2), SBL(2), STL(2), STR(2), SBR(2)], [SBR(3), SBL(3), STL(3), STR(3), SBR(3)], '-k') %Plot the edges of the monitor 
plot3(P(1), P(2), P(3), 'or') %Plot P
plot3([P(1), H(1)], [P(2), H(2)], [P(3), H(3)], '-r') %Plot a line from H to P
set( gca, 'TickDir', 'out', 'FontSize', 15 )
axis equal
xlabel('X', 'FontSize', 30)
ylabel('Y', 'FontSize', 30)
zlabel('Z', 'FontSize', 30)

