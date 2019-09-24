%HDB3 Scrambling

clc;
bits = [1 1 1 0 0 0 0 0 0 0 0];
bitrate = 1;
amplitude = 2;

%Convert to HDB3
Pooov = '000+';
Nooov = '000-';
Pboov = '+00+';
Nboov = '-00-';

hdb3 = '';
lastState = '+';

i = 1;
while i<=length(bits)
  if(bits(i) == 1)
    if(lastState == '+')
      hdb3 = strcat(hdb3,'-');
      lastState = '-';
    else
      hdb3 = strcat(hdb3,'+');
      lastState = '+';
    end
  
  else
    cnt = 0;
    needScrambling = 0;
    for j=i:length(bits)
      if(bits(j) == 0)
          cnt = cnt + 1;
      else
          break;
      end
      if(cnt == 4)
        needScrambling =  1;
        break;
      end
    end
    
    if(needScrambling == 1)
      numberOfNonZeroBits = 0;
      for i=1:length(hdb3)
        if(hdb3(i) ~= '0')
            numberOfNonZeroBits = numberOfNonZeroBits + 1;
        end
      end
      
      if(mod(numberOfNonZeroBits,2) == 1)
        if lastState == '+'
          hdb3 = strcat(hdb3,Pooov);
          lastState = '+';
        else
          hdb3 = strcat(hdb3,Nooov);
          lastState = '-';
        end
        
      else
        if lastState == '+'
          hdb3 = strcat(hdb3,Nboov);
          lastState = '-';
        else
          hdb3 = strcat(hdb3,Pboov);
          lastState = '+';
        end
      end
      i = i+3;
    else
      hdb3 = strcat(hdb3,'0');
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

for k = 0:length(hdb3)-2
  if(hdb3(k+1) == '+') 
      y((k*n)+1 : (k+1)*n) = amplitude;
  elseif(hdb3(k+1) == '-') 
      y((k*n)+1 : (k+1)*n) = -amplitude;
  else
      y((k*n)+1 : (k+1)*n) = 0;
  end
end


plot(x,y, 'Linewidth', 3);
grid on;
axis([0 T -amplitude-2 amplitude+2]);
title("HDB3 Scrambling");

%Decoding
data = zeros(1,length(bits));
lastState = amplitude;
k = 0;
while k<=length(bits)-1
  if(y((k*n)+1 : (k+1)*n) == 0)
    data(k+1)=0;
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
