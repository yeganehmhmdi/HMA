%S9_Exercise4
%Generate Time-Dependent Harmonic Oscillations
clear
clc
close all

%% Set the parameters d, dt, f, A, and phi.

A = 3;      % Amplitude of the oscillation
f = 2;      % Frequency of the oscillation = 1/t
d = 1; % Duration of the oscillation in seconds
dt = 0.01; % Temporal spacing between samples in seconds

T = 1 / f;
num_samples_per_cycle = T / dt;  %Number of samples per cycle
phase_shift = 2 * pi / num_samples_per_cycle;  %Phase shift in radians
phase_shift_rad = deg2rad(phase_shift);

%% Generate a time vector t and calculate the time-dependent harmonic oscillation.

% Generate time vector
t = 0:dt:1;

% Calculate oscillation
oscillation = A * sin(2 * pi * f * t + phase_shift_rad);

% Plot the oscillation
plot(t, oscillation)
xlabel('Time (s)')
ylabel('Amplitude')
title('Time-Dependent Harmonic Oscillation')
grid on