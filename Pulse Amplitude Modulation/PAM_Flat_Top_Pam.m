clc;
close all;
t = 0:0.001 :1; %time
%Input values from user
fm = input('Enter the frequency of message signal : ');%10
fc = input('Enter the frequency of carrier signal : ');%50
vm = 5*sin(2*pi*fm*t);%Message Signal
vc = 5*square(2*pi*fc*t);%Carrier Signal consist of square wave
%Flat top requires train of pulses
n = length(vc);%no.of samples in Vc
for i = 1:n
    if vc(i)<=0;%when carrier signal has negative value it will make it zero
    vc(i)=0;%square wave changes to pulse wave
    else
    vc(i)=1;
    end
end
y = vc .*vm;%generaion of FTP- Prouct -Modulation Step
subplot(4,1,1),plot(t,vm);
xlabel('t');
ylabel('vm(t)');
title('Message Signal');
subplot(4,1,2),plot(t,vc);
xlabel('t');
ylabel('vc(t)');
title('Carrier signal');

%Natural PAM
subplot(4,1,3),plot(t,y)
xlabel('t');
ylabel('y(t)');
title('Message Signal');
    
%Flat Top PAM
for i = 2:length(t)%samples under t
    if vc(i)== 1&&vc(i-1) ==0 % if the rising edge id detected
        y(i)==vc(i)* vm(i);%sampling occures
%no change in level
    elseif vc(i)==1 && vc(i-1)==1%and while the carrier signal is 1
        y(i)=y(i-1);% the value of y1 remains constant
    else
        y(i)=0;%otherwise zero
    end
end
subplot(4,1,4),plot(t,y) %Flat top PAM
xlabel('t');
ylabel('y(t)');
title('Flat top PAM');% Plotting flat Top PAM