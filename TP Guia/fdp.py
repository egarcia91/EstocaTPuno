# -*- coding: utf-8 -*-
"""
Created on Sat Sep 30 18:17:07 2017

@author: Nicolas Russo
"""

# Fdp con SNRdB=10dB (elijo esa), condicionando a X1=A

N=50000;
A=10;

SNRdB=10; 
SNR=10**(SNRdB/10);
sigma=A/(sqrt(SNR));
G=sqrt(SNR/(SNR+1));
Densidad=[];
for j in range (1,N):
   X1=A;
   X=X1;
   for i in range (1,8): # 8 repetidores para que sea n=9 #
     W=(sigma)*randn(1);
     Y=X+W;
     X=G*Y;       
   W=(sigma)*randn(1);
   Y=X+W;
   Densidad(j)=Y;
  
# Genero los parametros para obtener la varianza del ruido 
Sum=1;

for j in range (1,8):
    Gprod=1;
    for i in range ((j+1),9):
        Gprod=Gprod*G;
    Gprod=Gprod^2;
    Sum=Sum+Gprod;
 
VarRuido=Sum*sigma^2;
 
# Grafico histograma #
xHist=arange(-25.5,41.5,1);
 
figure;
 
xHistErr=xHist(0,25);   # Corto en x=0 parar graficar con distinto color #
xHistOk=xHist(26,66);
 
[Histo,c]=hist(Densidad,xHist); 
dif=c(1)-c(0);
HistoErr=Histo(0,25)/(N*dif);
HistoOk=Histo(26,66)/(N*dif);
 
# hold on;
 
HErr=bar(xHistErr,HistoErr);
HOk=bar(xHistOk,HistoOk);
  
set(HErr,'Facecolor','r');
set(HOk,'Facecolor','b');
  
 
# hold on;
 
# Grafico la fdp teorica
 
x=arange(-25.5,41.5,0.1);
DesvioRuido=sqrt(VarRuido);
Media1=A*G^8;

FdpSalida1=normpdf(x,Media1,DesvioRuido);

plot(x,FdpSalida1,'k','LineWidth',2);
title('Fdp dado X = A');
#grid on;
 
 
# Condiciono X1=-A #
 
Densidad2=[none];
for j in range (1,N):  
  X1=-A;
  X=X1;
  for i in range (1,8): # 8 repetidores para que sea n=9 #
    W=(sigma)*randn(1);
    Y=X+W;
    X=G*Y;       
  W=(sigma)*randn(1);
  Y=X+W;
  Densidad2[j]=Y;
  
Media2=-Media1;
 
xHist2=arange(-40.5,26.5,1);
figure;
 
xHist2Ok=xHist2(0,40);   # Corto en x=0 parar graficar con distinto color #
xHist2Err=xHist2(41,66);
 
[Histo2,b]=hist(Densidad2,xHist2);
dif=b(1)-b(0);
Histo2Ok=Histo2(0,40)/(N*dif);
Histo2Err=Histo2(41,66)/(N*dif);
 
#hold on;
  
H2Ok=bar(xHist2Ok,Histo2Ok);
H2Err=bar(xHist2Err,Histo2Err);
  
set(H2Ok,'Facecolor','b');
set(H2Err,'Facecolor','r');
  
 
#hold on;
 
x2=arange(-40.5,26.5,0.1);
 
FdpSalida2=normpdf(x2,Media2,DesvioRuido);
 
plot(x2,FdpSalida2,'k','LineWidth',2);
title('Fdp dado X = -A');
#grid on;
 
 