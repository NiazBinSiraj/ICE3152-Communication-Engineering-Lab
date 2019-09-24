clc;
bits = [0 0 1 0 1 0 1];
bitrate = 1;
T = length(bits)/bitrate;
n = 1000;
N = length(bits)*n;
dt = T/N;
A = 2;
x = [0:dt:T];
y = zeros(1,length(x));
lastState = -A;
for i=0:length(bits)-1
  low = (i*n)+1;
  high = (i+1)*n;
  mid = round((low+high)/2);
  if(bits(i+1)==1)
  y(low:mid)=lastState;
  y(mid+1:high)=-lastState;
  lastState=-lastState;
  else 
  y(low:mid)=-lastState;
  y(mid+1:high)=lastState;
  end
end

plot(x,y,'lineWidth',3);
grid on;
axis([0 T -A-2 A+2]);
%decoding

data = zeros(1,length(bits));
lastState = -A;
for i=0:length(bits)-1
  low = (i*n)+1;
  high = (i+1)*n;
  mid = round((low+high)/2);
  if(y(low:mid)==lastState )
    data(i+1)=1;
    lastState=-lastState;
  else data(i+1)=0;
  end
end
disp(data);
  