clear all; close all; clc;

% Fdp con SNRdB=10dB (elijo esa), condicionando a X1=A %

N=50000;
A=10;

  SNRdB=10; 
  SNR=10^(SNRdB/10);
  sigma=A/(sqrt(SNR));
  G=sqrt(SNR/(SNR+1));
  Densidad=[];
  for j=1:N
    X1=A;
    X=X1;
    for i=1:8 % 8 repetidores para que sea n=9 %
      W=(sigma)*randn(1);
      Y=X+W;
      X=G*Y;       
    end
    
    W=(sigma)*randn(1);
    Y=X+W;
    Densidad(j)=Y;
  end
  
  
  % Genero los parametros para obtener la varianza del ruido %
Sum=1;

 for j=1:8
     Gprod=1;
     for i=(j+1):9
         Gprod=Gprod*G;
     end
     Gprod=Gprod^2;
     Sum=Sum+Gprod;
 end
 
 VarRuido=Sum*sigma^2;
 
 % Grafico histograma %
 xHist=-25.5:1:40.5;
 
 figure;
 
 xHistErr=xHist(1:26);   % Corto en x=0 parar graficar con distinto color %
 xHistOk=xHist(27:67);
 
 [Histo,c]=hist(Densidad,xHist); 
 dif=c(2)-c(1);
 HistoErr=Histo(1:26)/(N*dif);
 HistoOk=Histo(27:67)/(N*dif);
 
 hold on;
 
  HErr=bar(xHistErr,HistoErr);
  HOk=bar(xHistOk,HistoOk);
  
  set(HErr,'Facecolor','r');
  set(HOk,'Facecolor','b');
  
 
 hold on;
 
 % Grafico la fdp teorica %
 
 x=-25.5:0.1:40.5;
 DesvioRuido=sqrt(VarRuido);
 Media1=A*G^8;
 
 FdpSalida1=normpdf(x,Media1,DesvioRuido);
 
 plot(x,FdpSalida1,'k','LineWidth',2);
 title('Fdp dado X = A');
 grid on;
 
 
 % Condiciono X1=-A %
 
 Densidad2=[];
  for j=1:N
    X1=-A;
    X=X1;
    for i=1:8 % 8 repetidores para que sea n=9 %
      W=(sigma)*randn(1);
      Y=X+W;
      X=G*Y;       
    end
    
    W=(sigma)*randn(1);
    Y=X+W;
    Densidad2(j)=Y;
  end
  
 Media2=-Media1;
 
 xHist2=-40.5:1:25.5;
 figure;
 
 xHist2Ok=xHist2(1:41);   % Corto en x=0 parar graficar con distinto color %
 xHist2Err=xHist2(42:67);
 
 [Histo2,b]=hist(Densidad2,xHist2);
 dif=b(2)-b(1);
 Histo2Ok=Histo2(1:41)/(N*dif);
 Histo2Err=Histo2(42:67)/(N*dif);
 
 hold on;
  
  H2Ok=bar(xHist2Ok,Histo2Ok);
  H2Err=bar(xHist2Err,Histo2Err);
  
  set(H2Ok,'Facecolor','b');
  set(H2Err,'Facecolor','r');
  
 
 hold on;
 
 x2=-40.5:0.1:25.5;
 
 FdpSalida2=normpdf(x2,Media2,DesvioRuido);
 
 plot(x2,FdpSalida2,'k','LineWidth',2);
 title('Fdp dado X = -A');
 grid on;
 
 