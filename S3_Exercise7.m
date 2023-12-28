%S3_Exercise7
%Analyse the Jump of a Show Jumper
clear
clc
close all

%% Load Data
load ('HourseJumpDataset.mat')

%% Calculate Tail, Neck and Atlas as mean values of the respective marker positions on the right and left side.
Tail = (TailR+TailL)/2;
Atlas = (AtlasR+AtlasL)/2;
Neck = (NeckR+NeckL)/2;

%% Calculate the torso length (torsoLength) and the neck length (neckLength)
TN = Neck - Tail;
AN = Neck - Atlas;
torsoLength = vecnorm(TN,2,2);
neckLength = vecnorm(AN,2,2);

%% Illustrate the courses in one figure each by plotting the variables over time.
t = (1:length(Tail)) / 100; %define a time vector
%plot torsolength
figure1
hold on
plot(t,torsoLength)
ylabel('torso_length')
xlabel('time')

%plot vertical line of time of jump and landing ??
figure
hold on
plot(t(idxJump),t(idxLanding))
%plot necklength
figure
hold on
plot(t,neckLength)
ylabel('neck_length')
xlabel('time')

%% Calculate the velocity of the CoM (vCoM) and determine the take-off velocity (vTakeOff).
step1 = diff(CoM);
step2 = vecnorm(step1,2,2);
dt = 1/100;
step3 = step2/dt;
vCoM = vecnorm(diff(CoM),2,2)/0.01;

%% Calculate the torso height (torsoHeight).
% To do this, calculate the shortest distance between the marker located at the saddle girth (Girth) and the connecting line between Tail and Neck.

%shortest distance = cross product
%cross product : |c| = |a| *|b|*sin(teta)
% c = a*b
a = Neck - Tail;
b = Girth - Tail;
mag_a = vecnorm(a,2,2);
c = cross(a,b);
mag_c = vecnorm(c,2,2);
torsoHeight = mag_c ./mag_a;


