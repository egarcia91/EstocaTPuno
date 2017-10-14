clear all; close all;clc;

SNRdB=(-5):30;
SNR=10.^(SNRdB/10);
k=1;
A=10;

for n=1:4:25
  Pe_digital(k,:)=(1/2)*(1-(1-(2*qfunc(sqrt(SNR)))).^n);
  k=k+1;
end


set(gca,'yscale','log');

plot(SNRdB,Pe_digital(1,:),'--ob');
hold on;
plot(SNRdB,Pe_digital(2,:),'--r');
hold on;
plot(SNRdB,Pe_digital(3,:),'--g');
hold on;
plot(SNRdB,Pe_digital(4,:),'--m');
hold on;
plot(SNRdB,Pe_digital(5,:),'--c');
hold on;
plot(SNRdB,Pe_digital(6,:),'--k');
hold on;
plot(SNRdB,Pe_digital(7,:),'--b');


%legend('n=1 digital', 'n=5 digital', 'n=9 digital', 'n=13 digital', 'n=17 digital', 'n=21 digital','Location','NorthEastOutside');

cont=1;
for m=1:4:25

 k=1; 
 for SNRprueba=-5:30
  
  SNRp=10^(SNRprueba/10);
  sigma=A/(sqrt(SNRp));
  G=sqrt(SNRp/(SNRp+1));
  Sum=1;

  for j=1:m-1
     Gprod=1;
     for i=(j+1):m
         Gprod=Gprod*G;
     end
     Gprod=Gprod^2;
     Sum=Sum+Gprod;
  end
 
  VarRuido=Sum*sigma^2;
  Gprod=1;
  for i=2:m
    Gprod=Gprod*G;
  end
  SNRn=((Gprod^2)*A^2)/VarRuido;
 
  PeAnalogTeorico(cont,k)=qfunc(sqrt(SNRn)); 
  k=k+1;
 end
 cont=cont+1;

end

set(gca,'yscale','log');

plot(SNRdB,PeAnalogTeorico(1,:),'b','LineWidth',2');
hold on;
plot(SNRdB,PeAnalogTeorico(2,:),'r','LineWidth',2');
hold on;
plot(SNRdB,PeAnalogTeorico(3,:),'g','LineWidth',2');
hold on;
plot(SNRdB,PeAnalogTeorico(4,:),'k','LineWidth',2');
hold on;
plot(SNRdB,PeAnalogTeorico(5,:),'c','LineWidth',2');
hold on;
plot(SNRdB,PeAnalogTeorico(6,:),'m','LineWidth',2');
hold on;
plot(SNRdB,PeAnalogTeorico(7,:),'b','LineWidth',2');

legend('n=1 digital','n=5 digital', 'n=9 digital', 'n=13 digital', 'n=17 digital', 'n=21 digital','n=25 digital','n=1 anal�gico', 'n=5 anal�gico', 'n=9 anal�gico', 'n=13 anal�gico', 'n=17 anal�gico', 'n=21 anal�gico','n=25 anal�gico','Location','NorthEastOutside');

ylim([10^-6  1]); 
grid minor; 
title('Probabilidad de error de los repetidores anal�gico y digital');
xlabel('SNR [dB]');
ylabel('Probabilidad de error');

 
 
