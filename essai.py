#from doopl.factory import *
#import os
#from os.path import dirname, abspath, join

#DATADIR=join(dirname(abspath(__file__)),'data')
#mod="test.mod"
#dat=join(DATADIR,"essai.dat")
#gen_dir=os.path.join(DATADIR,"generated")

#if not os.path.isdir(gen_dir):
   # os.makedirs(gen_dir)

#with create_opl_model(model=mod) as opl:
    #opl.run()

    #print(opl)
    #print(opl.objective_value)
    #print(opl.get_table("InVolumeThroughHubonTestRes"))
    #print(opl.get_table("OutVolumeThroughHubonTestRes"))
    #print(opl.report) 
#This example shows how to run an OPL model, get a post processing IloTupleSet as a pandas df and iterate on it.

from doopl.factory import *
import os
from os.path import dirname, abspath, join
import matplotlib.pyplot as plt
import numpy as np

DATADIR = join(dirname(abspath(__file__)), 'data')

mod = "test.mod"

with create_opl_model(model=mod) as opl:
   # opl.setExportExternalData("test.dat")
    opl.run()


    L1 = opl.get_table("AP")
    for t in L1.itertuples(index=False):
        print(t)
    L2=opl.get_table("users")
    for t in L2.itertuples(index=False):
        print(t)
    L3=opl.get_table("solution")
    for t in L3.itertuples(index=False):
        print(t)
     
        
print(L1)    
print(L2)  
print(L3)   
XA= np.array(L1['point.x'])
YA=np.array(L1['point.y'])
ZA=np.array(L1['point.z'])
XU=np.array(L2['point.x'])
YU=np.array(L2['point.y'])
ZU=np.array(L2['point.z'])
IDA=np.array(L1['ida'])
IDU=np.array(L2['idu'])



fig = plt.figure()
fig.suptitle('Associations ')
ax =plt.axes(projection='3d')
g1=ax.scatter3D(XA,YA,ZA,marker='^',c='r',label='Acess Points ')
for i in IDA[0:len(IDA)-1]:
   ax.annotate('$ida=%d$'%i,(XA[i-1],YA[i-1]))
   
g2=ax.scatter(XU,YU,ZU,marker='s',c='b', label='users')
ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.set_zlabel('Z Label')

ax.legend([g1, g2], ['Access Points', 'Users'],loc="upper right") 



for i,j in range (1,len (XA)):

  ax.plot3D([XA[i],XU[j]],[YA[i],YU[j]],[ZA[i],ZU[j]],c='g',alpha=0.3)



   
  
        
        
        
        
        
       