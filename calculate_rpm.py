import matplotlib
matplotlib.use('Pdf')               # We are just printing
import matplotlib.pyplot as plt
import numpy as np
from mod7_func import movingAvg

with open('data.txt', 'r') as file:
   data    = file.read().splitlines()  # split lines into an array 
data=data[1:]
MAXSIZE = len(data)
DEBUG   = False                     # For printing debug statements

time    = [0]*MAXSIZE
photo   = [0]*MAXSIZE

i=0
for dat in data:
    values   = dat.split()          # split on white space
    time[i]  = float(values[0])     # first item in file is time
    photo[i] = int(values[1])       # second is the value
    if DEBUG: print (f'{time[i]}\t{photo[i]}')
    i += 1
    
smoothed=[]
for i in range(3,len(photo),1):
   avgVal=movingAvg(photo,i)
   smoothed.append(avgVal)

difference=[]
for i in range(len(smoothed)-1):
   difference.append(smoothed[i+1]-smoothed[i])
   i=i+1

threshold=0.2
max=np.max(difference)*threshold
min=np.min(difference)*(threshold)

print(max)
print(min)
change=[]
changeTime=[]
lookingDark=True

for i in range(len(difference)):
   if lookingDark and difference[i]>max:
      change.append(1)
      changeTime.append(time[i])
      lookingDark=False
   elif ~lookingDark and difference[i]<min:
      change.append(-1)
      changeTime.append(time[i])
      lookingDark=True
   i += 1


# get tick marks for the x axis, in 4 regions
plt.figure()
xmarks = np.linspace(time[0], time[MAXSIZE - 1], 5) 
plt.xticks(xmarks)
plt.plot(time[0:997], smoothed)
plt.grid()                          # show the grid
plt.xlabel('time - sec')
plt.ylabel('bits for Photosensor')
plt.savefig('plot.png')

plt.figure()
xmarks = np.linspace(time[0], time[len(difference) - 1], 5) 

plt.xticks(xmarks)
plt.plot(time[0:996], difference)
plt.grid()                          # show the grid
plt.xlabel('time - sec')
plt.ylabel('difference in bits')
plt.savefig('difference.png')

plt.figure()
xmarks = np.linspace(changeTime[0], changeTime[-1], 5) 
plt.xticks(xmarks)
plt.plot(changeTime, change)
plt.grid()                          # show the grid
plt.xlabel('time - sec')
plt.ylabel('1 is light, -1 is dark')
plt.savefig('change.png')

