clc;
bits = [1 1 1 0 0 0 0 0 0 0 0];
bitrate = 1;
amplitude = 2;

%Convert To B8ZS
Pscramble = '000+-0-+'; %will be replaced if laststate is +
Nscramble = '000-+0+-'; %will be replaced if laststate is -

b8zs = ''; %converted string
lastState = '+';
i=1;
while i <= length(bits)
  if(bits(i) == 1)
    if(lastState == '+')
      b8zs = strcat(b8zs,'-');
      lastState = '-';
    else
      b8zs = strcat(b8zs,'+');
      lastState = '+';
    end
      
  else %If bit = 0, Checking wether scrambling is needed or not by counting consecutive zeros 
    cnt = 0;
    needScrambling = 0;
    for j=i:length(bits)
      if(bits(j) == 0)
          cnt = cnt + 1;
      else
          break;
      end
      if(cnt == 8)
        needScrambling =  1;
        break;
      end
    end
    
    
    if(needScrambling == 1) %If scrambling is needed
      if lastState == '+'
        b8zs = strcat(b8zs,Pscramble);
        lastState = '+';
      else
        b8zs = strcat(b8zs,Nscramble);
        lastState = '-';
      end
      i = i+7;
      
    else %if scrambling is not needed
      b8zs = strcat(b8zs,'0');
    end
    
  end
  i = i+1;
end


%Encoding
T = length(bits)/bitrate;
n = 1000;
N = length(bits)*n;
dt = T/N;

x = 0:dt:T;
y = zeros(1,length(x));

for k = 0:length(b8zs)-1
  if(b8zs(k+1) == '+') y((k*n)+1 : (k+1)*n) = amplitude;
  elseif(b8zs(k+1) == '-') y((k*n)+1 : (k+1)*n) = -amplitude;
  else y((k*n)+1 : (k+1)*n) = 0;
  end
end

plot(x,y, 'Linewidth', 3);
grid on;
axis([0 T -amplitude-2 amplitude+2]);
title("B8ZS Scrambling");

%Decoding
data = zeros(1,length(bits));
lastState = amplitude;
k = 0;
while k<=length(bits)-1
  if(y((k*n)+1 : (k+1)*n) == 0) data(k+1)=0;
  elseif(y((k*n)+1 : (k+1)*n) == -lastState)
    data(k+1)=1;
    lastState = -lastState;
  else
    for j=k-3 : k+4
      data(j+1) = 0;
    end
    k = k + 4;
  end
  k = k+1;
end
disp(data);