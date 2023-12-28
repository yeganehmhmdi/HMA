%S5_Exercise4
%Transfer IMU Data Into a Stationary Coordinate System
clear
clc
close all

%% Load data
load( 'DatasetIMU.mat' )

%% Transfer the acceleration data into a stationary coordinate system.
nFrames = length( o );
accStationary = zeros( nFrames, 3 );

for i = 1 : nFrames
    B = rotationmatrix3d( o(i,1), o(i,2), o(i,3) );
    accStationary(i,:) = ( B \ acc(i,:)' )';
    %accStationary(i,:) = ( B^-1 * acc(i,:)' )';     %Alternative syntax
    %accStationary(i,:) = ( inv( B ) * acc(i,:)' )'; %Alternative syntax
end

%% Create two plots with the raw data and the acceleration data in the stationary coordinate system.
%Acceleration raw data
hf1 = figure;
set( hf1, 'units', 'normalized', 'outerposition', [0 0 1 1] );
hold on
h = zeros(3,1);
h(1) = plot( t, acc(:,1), '-k', 'LineWidth', 2 );
h(2) = plot( t, acc(:,2), '-r', 'LineWidth', 2 );
h(3) = plot( t, acc(:,3), '-b', 'LineWidth', 2 );
legend(h, {'ACCx_{raw}','ACCy_{raw}','ACCz_{raw}'}, 'FontSize', 14);
set( gca, 'TickDir', 'out', 'FontSize', 15 )
xlabel('Time (s)', 'FontSize', 30);
ylabel('Acceleration (m/s^2)', 'FontSize', 30);
box off

%Acceleration rotated data
hf2 = figure;
set( hf2, 'units', 'normalized', 'outerposition', [0 0 1 1] );
hold on
h = zeros(3,1);
h(1) = plot( t, accStationary(:,1), '-k', 'LineWidth', 2 );
h(2) = plot( t, accStationary(:,2), '-r', 'LineWidth', 2 );
h(3) = plot( t, accStationary(:,3), '-b', 'LineWidth', 2 );
legend(h, {'ACCx_{stationary}','ACCy_{stationary}','ACCz_{stationary}'}, 'FontSize', 14);
set( gca, 'TickDir', 'out', 'FontSize', 15 )
xlabel('Time (s)', 'FontSize', 30);
ylabel('Acceleration (m/s^2)', 'FontSize', 30);
box off


