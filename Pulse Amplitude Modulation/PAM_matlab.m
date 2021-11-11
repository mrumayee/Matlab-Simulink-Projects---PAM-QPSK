% clc;
% close all;
% clear all;
% a = input("Enter amplitude : ");
% f = input("Enter the frequency : ");
% t = 0 : 0.02 : 2;
% x1 = 1;
% x2 = a*sin(2*pi*f*t);
% y = x1.*x2;
% subplot(3,1,1);
% stem(x1);
% title('Impulse Signal')
% ylabel('Amplitude')
% subplot(3,1,2)
% plot(t,x2);
% title('Sine wave');
% 
% subplot(3,1,3)
% stem(t,y);
% title('PAM Wave');
% xlabel('Time');
% ylabel('Amplitude')


fc= 5
fm= 1
fs= 100*fc
t=0:1/fs:4/fm;
Msg_sgl= cos(2*pi*fm*t);
Carr_sgl= 0.5*square(2*pi*fc*t)+0.5
Mod_sgl= Msg_sgl.*Carr_sgl;
tt= [];
for i=1:length(Mod_sgl);
    if Mod_sgl(i)==0;
        tt=[tt,Mod_sgl(i)];
    else
        tt=[tt,Mod_sgl(i)+2];
    end
end
figure(1)
subplot(4,1,1);
plot(t,Msg_sgl);
title('Message Signal');
xlabel('Time Period');
ylabel('Amplitude');
subplot(4,1,2);
plot(t,Carr_sgl);
title('Carrier Signal')
xlabel('Time Period');
ylabel('Amplitude');
subplot(4,1,3);
plot(t,Mod_sgl);
title('PAM Modulated signal')
xlabel('Time Period');
ylabel('Amplitude');
for i = 2:length(t)%samples under t
    if Carr_sgl(i)== 1&&Carr_sgl(i-1) ==0 % if the rising edge id detected
        Mod_sgl(i)==Carr_sgl(i)* Msg_sgl(i);%sampling occures
%no change in level
    elseif Carr_sgl(i)==1 && Carr_sgl(i-1)==1%and while the carrier signal is 1
        Mod_sgl(i)=Mod_sgl(i-1);% the value of y1 remains constant
    else
       Mod_sgl(i)=0;%otherwise zero
    end
end
subplot(4,1,4),plot(t,Mod_sgl) %flat top pam
xlabel('t');
ylabel('y(t)');
title('Flat top PAM');