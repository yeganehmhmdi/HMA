%S9_Exercise7
%Analysis of Ankle Joint Angle
clear
clc

%% Load data
load( 'AnkleJointDataset.mat' );

%% Calculation of the device angle (phiDeviceVicon) using the four markers attached to the device and captured with Vicon
%Determine the two vectors for all frames
a = data.vicon.device2 - data.vicon.device1;
b = data.vicon.device4 - data.vicon.device3;
%Calculate the angle in a for-loop
nFrames = (length(data.vicon.device1));
phiDeviceVicon = zeros(nFrames,1);
for i = 1:nFrames
    phiDeviceVicon(i) = 90 - acosd(dot(a(i,:),b(i,:))/norm(a(i,:)*norm(b(i,:))));
end



%% Calculate the ankle joint angle (phiAnkle) using the six markers attached to the leg and captured with Vicon

%Calculate the knee and ankle joint centers
ankle = ( data.vicon.leg3 + data.vicon.leg4 ) / 2;  %Midpoint between the two ankle markers.
knee = ( data.vicon.leg1 + data.vicon.leg2 ) / 2;

%Determine the two direction vectors
c = knee - ankle;
d = data.vicon.leg6 - data.vicon.leg5;

%Calculate the angle in a for-loop
phiAnkle = zeros( nFrames, 1 );
for i = 1 : nFrames    
    phiAnkle( i ) = 90 - acosd( dot(c(i,:),d(i,:)) / ( norm( c(i,:) ) * norm( d(i,:) ) ) );
end

%% Create a figure that plots the two angle curves (phiDeviceVicon, phiAnkle) against each other.
figure
plot( phiDeviceVicon, phiAnkle, '-k', 'LineWidth', 1.5 )
set( gca, 'TickDir', 'out', 'FontSize', 15 )
box off %Delete box
axis equal %Equal scaling of the axes
xlabel( 'Device Angle (deg)', 'FontSize', 25 )  
ylabel( 'Joint Angle (deg)', 'FontSize', 25 ) 
hold on 
plot( [-20,30], [-20,30], '--k', 'LineWidth', 0.5 ) %Add reference line for the main diagonal y = x
axis( [-20,30,-20,30] ) %Set minimum and maximum values of x- and y-axis.


%% Linear regression (use the device angle for x and the joint angle for y)
p = polyfit( phiDeviceVicon, phiAnkle, 1 );

%Interpretation:

