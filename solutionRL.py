#les biblios
import random, math
import matplotlib.pyplot as plt
import numpy as np
rnd=np.random
n=range(1,10)
#les paramétres Physiques
#bande passante 
B=10 #MHZ
#variance de bruit de canal optique 
segma2=8
#puissance d'intérference 
PI=5
#puissance réçu
PR=20

#nombre des APs
M=30
#nombre des tours de décision 
K=300
#probabilité de distributiion uniforme 
p=1/M
#Les Probablités des APs
prob=[p for i in range(1,M+1) ]
#Les débits fournies par les APs au user
Q=[0 for j in range (1,M+1)]
#les nombres de users supportés par chaque AP
U={k :rnd.randint(1,30) for k in range (1,M+1)}
T_pos=[]
from math import *
#Les Tours de décision (fait par un user :agent)
for l in range(1,K+1):
 #la séquence gama(k)
    gama(l)=sqrt((2*log(M)/(l*M))
#la probabilité maximale 
    pmax=max(prob)
    #la position 
    pos=pr.index(pmax)
    T_pos[l]+=pos
    #identifier l'AP
    ap=pos+1
    #mise à jour de débit 
    U[ap]+=1 #mise à jour de nombre de service
    for i in range(0,M):
      if pos==i:
          Q[i]=(B/U[ap])*log2(1+(PR/((segma2*B)/U[ap])+PI))
                 
                 
                 
          prob[i]=
                 
print("le point d'accés choisi par le user est", ap)
   
