clear all; close all; clc;

% Probabilidad de error repetidor analógico - teórico %

SNRdB_vec=-5:30;


A=10;
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


 
 
 
semilogy(SNRdB_vec,PeAnalogTeorico(1,:),'b','LineWidth',2');
hold on;
semilogy(SNRdB_vec,PeAnalogTeorico(2,:),'r','LineWidth',2');
hold on;
semilogy(SNRdB_vec,PeAnalogTeorico(3,:),'g','LineWidth',2');
hold on;
semilogy(SNRdB_vec,PeAnalogTeorico(4,:),'k','LineWidth',2');
hold on;
semilogy(SNRdB_vec,PeAnalogTeorico(5,:),'c','LineWidth',2');
hold on;
semilogy(SNRdB_vec,PeAnalogTeorico(6,:),'m','LineWidth',2');
hold on;
semilogy(SNRdB_vec,PeAnalogTeorico(7,:),'b','LineWidth',2');
ylim([10^-6  1]);
 

