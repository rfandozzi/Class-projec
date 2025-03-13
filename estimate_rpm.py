from scipy import signal
from scipy.fftpack import fft
import matplotlib

matplotlib.use('Agg')       # to avoid warnings if using ssh
import matplotlib.pyplot as plt
import numpy as np

file = "data_DC_80.txt" 

with open(file, "r") as f:
    data = f.readlines()[1:]  #skip the first row

t = []
photo = []

for dat in data:
    values = dat.split()  
    t.append(float(values[0]))  
    photo.append(int(values[1]))    

Fs=200

N = 2 ** int(np.floor(np.log2(len(data))))  # finds the largest power of 2 the data matches
photo = photo[:N] #trims teh data to the length determined above

photoNoDC = photo - np.mean(photo)
fft_values = fft(photoNoDC)
freqs = np.linspace(0, Fs / 2, N // 2)
mag = 2 / N * np.abs(fft_values[:N//2])

dominantFreq= freqs[np.argmax(mag)]
rpmEst=dominantFreq*60
print(rpmEst)

plt.plot(freqs, mag)
plt.grid(True)
plt.xlabel("freq - Hz")
plt.savefig("fft_80.png")

plt.clf()
plt.plot(t[:N//4], photo[:N//4])
plt.grid(True)
plt.ylim(-1.5, 1.5)
plt.xlabel("time - sec")
plt.savefig("timeSignals.png")



