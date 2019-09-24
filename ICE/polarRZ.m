%Polar RZ
%If bit == 1 then y(from:mid) = +amplitude; y(mid+1:to) = 0
%If bit == 0 then y(from:mid) = -amplitude; y(mid+1:to) = 0

clc;

bits = [1 1 0 0 1 0 1 0 0 1 0];
bitrate = 1;
amplitude = 2;

%Encoding
T = length(bits)/bitrate;   %total time to transmit all bit
n = 1000;   %number of sample per bit
N = length(bits)*n; %number of total sample for all bit
dt = T/N;   %difference between adjecent two sample

x = 0:dt:T;
y = zeros(1,length(x));

for i=0 : length(bits)-1
  from = (i*n)+1;
  to = (i+1)*n;
  mid = round((from+to)/2);
  if(bits(i+1)==1)
    y( from : mid ) = amplitude;
    y( mid+1 : to ) = 0;
  else
    y( from : mid ) = -amplitude;
    y( mid+1 : to ) = 0;
  end
end

plot(x,y, 'LineWidth', 3);
axis([0 T -amplitude-2 amplitude+2]);
grid on;
title("Polar RZ");
    
%Decoding
data = zeros(1, length(bits));
for i=0: length(bits)-1
  from = (i*n)+1;
  to = (i+1)*n;
  mid = round((from+to)/2);
  if(y( from : mid ) == amplitude)
      data(i+1) = 1;
  else
    data(i+1) = 0;
  end
end
disp(data);