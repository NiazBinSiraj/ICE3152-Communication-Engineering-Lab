clc
clear all
close all
t = 0:0.001:1; %upto 1000 samples
%vm = input('Enter Amplitude (Message) = ');
%vc = input('Enter Amplitude (Carrier) = ');
%fM = input('Enter Message frequency = ');
%fc = input('Enter Carrier frequency = ');
%m = input('Enter Modulation Index = ');
vm = 5;
vc = 5;
fM = 10;
fc = 30;
m = 10;
msg = vm*sin(2*pi*fM*t);
subplot(3,1,1); %plotting message signal
plot(t,msg);
xlabel('Time');
ylabel('Amplitude');
title('Message ');

carrier = vc*sin(2*pi*fc*t);
subplot(3,1,2); %plotting carrier signal
plot(t,carrier);
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal');

y = vc*sin(2*pi*fc*t+m.*cos(2*pi*fM*t));
subplot(3,1,3);%plotting FM (Frequency Modulated) signal
plot(t,y);
xlabel('Time');
ylabel('Amplitude');
title('FM Signal');


%Sample MATLAB Input:
%Enter Amplitude (Message) = 5
%Enter Amplitude (Carrier) = 5
%Enter Message frequency = 8
%Enter Carrier frequency = 100
%Enter Modulation Index = 10