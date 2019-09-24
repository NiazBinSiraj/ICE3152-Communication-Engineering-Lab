%Bipolar AMI
%IF bit=1 y(from:to) = opposit of previous state for non zero bit
%IF bit=0 y(from:to) = 0

clc;

bits = [1 1 0 0 1 0 1 0 0 1 1 0];
bitrate = 1;
amplitude = 2;

%Encoding
T = length(bits)/bitrate;   %total time to transmit all bit
n = 1000;   %number of sample per bit
N = length(bits)*n; %number of total sample for all bit
dt = T/N;   %difference between adjecent two sample

x =  0:dt:T;
y = zeros(1,length(x));

lastState = amplitude;

for i=0: length(bits)-1
  from = (i*n)+1;
  to = (i+1)*n;
  
  if(bits(i+1) == 1)
    y(from : to) = -lastState;
    lastState = -lastState;
  else
    y(from : to) = 0;
  end
end

plot(x,y, 'LineWidth', 3);
grid on;
axis([0 T -amplitude-2 amplitude+2]);
title("Bipolar AMI");

%Decoding
data = zeros(1,length(bits));
for i=0: length(data)-1
  from = (i*n)+1;
  to = (i+1)*n;
  
  if(y(from : to) == 0)
      data(i+1) = 0;
  else
      data(i+1) = 1;
  end
end
disp(data);