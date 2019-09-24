%Polar Differential Manchester
%If Next bit is 0 then Inversion

clc;

bits = [0 0 1 0 0 1 1 0 1 1 1 0 0 1 0 1 0];
bitrate = 1;
amplitude = 2;

%Encoding
T = length(bits)/bitrate;   %total time to transmit all bit
n = 1000;   %number of sample per bit
N = length(bits)*n; %number of total sample for all bit
dt = T/N;   %difference between adjecent two sample

x = 0:dt:T;
y = zeros(1,length(x));

lastState = -amplitude;

for i=0 : length(bits)-1
  from = (i*n)+1;
  to = (i+1)*n;
  mid = round((from+to)/2);
  
  if(bits(i+1)==1)
    lastState = -lastState;
    y( from : mid ) = lastState;
    y( mid+1 : to ) = -lastState;
  else
    y( from : mid ) = lastState;
    y( mid+1 : to ) = -lastState;
  end
end

plot(x,y, 'LineWidth', 3);
axis([0 T -amplitude-2 amplitude+2]);
grid on;
title("Differential Manchester");

%Decoding
data = zeros(1, length(bits));
lastState = -amplitude;
for i=0: length(data)-1
  from = (i*n)+1;
  to = (i+1)*n;
  mid = round((from+to)/2);
  if(y( from : mid ) == lastState)
    data(i+1) = 0;
  else
    data(i+1) = 1;
    lastState = -lastState;
  end
end
disp(data);
