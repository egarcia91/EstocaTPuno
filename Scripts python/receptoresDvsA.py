# -*- coding: utf-8 -*-
"""
Created on Sat Sep 30 18:17:07 2017

@author: Nicolas Russo
"""

# Fdp con SNRdB=10dB (elijo esa), condicionando a X1=A

import matplotlib
matplotlib.use('Agg')

import math
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

N=50000
A=10

SNRdB=10
SNR=10**(SNRdB/10)
sigma=A/(math.sqrt(SNR))
G=math.sqrt(SNR/(SNR+1))
Densidad=np.zeros(N)
for j in range (1,N):
   X1=A
   X=X1
   for i in range (1,8): # 8 repetidores para que sea n=9 #
     W=(sigma)*np.random.randn(1)
     Y=X+W
     X=G*Y
   W=(sigma)*np.random.randn(1)
   Y=X+W
   Densidad[j] = Y

# Genero los parametros para obtener la varianza del ruido
Sum=1

for j in range (1,8):
    Gprod=1
    for i in range ((j+1),9):
        Gprod=Gprod*G
    Gprod=Gprod**2
    Sum=Sum+Gprod

VarRuido=Sum*sigma**2

# Grafico histograma #
xHist=np.arange(-25.5,41.5,1)

#xHistErr=xHist(0,25);   # Corto en x=0 parar graficar con distinto color
xHistErr=np.arange(-25.5,0.5,1)
#xHistOk=xHist(26,66);
xHistOk=np.arange(0.5,41.5,1)

[Histo,c]=np.histogram(Densidad,xHist)
dif=c[1]-c[0]
HistoErr=Histo[0:26]/(N*dif)
HistoOk=Histo[25:66]/(N*dif)

x=np.arange(-25.5,41.5,0.1)
DesvioRuido=math.sqrt(VarRuido)
Media1=A*G**8

FdpSalida1=norm.pdf(x,Media1,DesvioRuido)

# Grafico la fdp teorica

plt.ioff()
plt.figure('Fdp dado X = A')
plt.bar(xHistErr,HistoErr, color = "r", width = 0.25)
plt.hold(True)
plt.bar(xHistOk, HistoOk, color = "b", width = 0.25)
plt.hold(True)
plt.plot(x, FdpSalida1,'k--', lw = 2)
plt.grid(True)
plt.show()
plt.savefig("figure.png")

# Condiciono X1=-A #

Densidad2=np.zeros(N)
for j in range (1,N):
  X1=-A
  X=X1
  for i in range (1,8): # 8 repetidores para que sea n=9
    W=(sigma)*np.random.randn(1)
    Y=X+W
    X=G*Y
  W=(sigma)*np.random.randn(1)
  Y=X+W
  Densidad2[j] = Y

Media2=-Media1;

xHist2=np.arange(-40.5,26.5,1)

xHist2Ok=xHist2[0:40]   # Corto en x=0 parar graficar con distinto color
xHist2Err=xHist2[41:66]

[Histo2,b]=np.histogram(Densidad2,xHist2)
dif=b[1]-b[0]
Histo2Ok=Histo2[0:40]/(N*dif)
Histo2Err=Histo2[41:66]/(N*dif)
x2=np.arange(-40.5,26.5,0.1)
FdpSalida2=norm.pdf(x2,Media2,DesvioRuido)

plt.figure('Fdp dado X = -A')
plt.bar(xHist2Ok, Histo2Ok, color = "b", width = 0.25)
plt.hold(True)
plt.bar(xHist2Err,Histo2Err, color = "r", width = 0.25)
plt.hold(True)
plt.plot(x2, FdpSalida2,'k--', lw = 2)
plt.grid(True)
plt.show()
plt.savefig("figure2.png")
