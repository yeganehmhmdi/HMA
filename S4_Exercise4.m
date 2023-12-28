%S4_Exercise4
%Calculate the Thorax CoM 
clear
clc

%% Load data
load('ThoraxDataset.mat');

%% Calculate m_CLAV_C7, m_STRN_T10 and m_STRN_CLAV
m_CLAV_C7 = (CLAV(1,:)+C7(1,:)) / 2; %because it should be in the first frame
m_STRN_T10 = (STRN(1,:)+T10(1,:)) / 2;
m_STRN_CLAV = (STRN(1,:)+CLAV(1,:)) / 2;


%% Determine the z-axis (zAxis)
%The z-axis points upwards from m_STRN_T10 to m_CLAV_C7.
%we normalized it because we only need its direction 
zAxis = (m_CLAV_C7 - m_STRN_T10) / norm(m_CLAV_C7 - m_STRN_T10);

%% Determine the (yAxis)
%The y-axis is orthogonal to zAxis and the vector from m_STRN_T10 to m_STRN_CLAV.
a = zAxis;
b = (m_STRN_CLAV - m_STRN_T10) / norm(m_STRN_CLAV - m_STRN_T10);
yAxis = cross(a,b)/ norm(cross(a,b));
%we use norm because mikhaim hamono enteghal bedim va faghat bordar yekash
%baramon moheme
%% Determine the x-axis (yAxis)
%The x-axis is orthogonal to the other two axes and aligned to the front.
xAxis = cross(yAxis,zAxis);

%% Checking the orthogonality and normality of the vectors
XdotY = dot(xAxis,yAxis);
XdotZ = dot(xAxis,zAxis);
ZdotY = dot(zAxis,yAxis);

normX = norm(xAxis);
normY = norm(yAxis);
normZ = norm(zAxis);




%% Form the matrix B to define the thorax coordinate system.  
B = [xAxis' , yAxis' , zAxis'];


%% Define the origin as midpoint between CLAV and C7
O = m_CLAV_C7;

%% Calculate the thorax CoM in the thorax segment (CoM_ThoraxSegment)
m_LPSI_PRSI = (LPSI(1,:) + RPSI(1,:)) / 2;
ThoraxLength = norm(O - m_LPSI_PRSI);
CoM_ThoraxSegment = [0;0;-0.63*ThoraxLength];

%% Transfer CoM_ThoraxSegment to the standard coordinate system (CoM_ThoraxStandard)
%x(A) = B−1∗ x(B) − O(A)
CoM_ThoraxStandard = B * CoM_ThoraxSegment + O';


%% Optional: Create control figure for the first frame to check the position of the CoM relative to the markers
figure
hold on
plot3(C7(1,1), C7(1,2), C7(1,3), 'ok', 'MarkerFaceColor', 'k')
plot3(T10(1,1), T10(1,2), T10(1,3), 'ok', 'MarkerFaceColor', 'k')
plot3(CLAV(1,1), CLAV(1,2), CLAV(1,3), 'ok', 'MarkerFaceColor', 'b')
plot3(STRN(1,1), STRN(1,2), STRN(1,3), 'ok', 'MarkerFaceColor', 'k')
plot3(LPSI(1,1), LPSI(1,2), LPSI(1,3), 'ok', 'MarkerFaceColor', 'g')
plot3(RPSI(1,1), RPSI(1,2), RPSI(1,3), 'ok', 'MarkerFaceColor', 'g')
plot3(CoM_ThoraxStandard(1), CoM_ThoraxStandard(2), CoM_ThoraxStandard(3), 'or', 'MarkerFaceColor', 'r')
axis equal
xlabel( 'X', 'FontSize', 30 )