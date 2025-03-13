import RPi.GPIO as GPIO
import Adafruit_MCP3008
from Adafruit_GPIO.GPIO import RPiGPIOAdapter as Adafruit_GPIO_Adapter
import time
import argparse
import mod7_func as motor

in1 = 33
in2 = 35
en  = 37

GPIO.cleanup()
GPIO.setwarnings(False)     # Ignore warning for now
GPIO.setmode(GPIO.BOARD)    # Use physical pin numberin

# Software SPI configuration:
CLK = 23  # pin 13 on MCP3008
MISO = 21  # pin 12 on MCP3008
MOSI = 19  # pin 11 on MCP3008
CS = 24  # pin 10 on MCP3008

gpio_adapter = Adafruit_GPIO_Adapter(GPIO, mode=GPIO.BOARD)
mcp = Adafruit_MCP3008.MCP3008(clk=CLK, cs=CS, miso=MISO, mosi=MOSI, gpio=gpio_adapter)


parser = argparse.ArgumentParser(description="read and resize image")
parser.add_argument('--looptime', type=float, default=5, help='time for program to run')
parser.add_argument('--delay', type=int, default=200, help='delay between samples(Hz)')
parser.add_argument('--debug',type=bool, default=False, help='debugstatements to track errors')
parser.add_argument('--dutycycle',type=float, default=50, help='duty cycle for the DC motor')

args = parser.parse_args()


pwm_pin   = motor.motor_init(in1, in2, en, 1000, args.dutycycle)
time.sleep(1)

cur_time=time.time()

AD_pin=0
i=0
data=[]
time_array=[]

sampling=1/args.delay

while cur_time+args.looptime>time.time():
  delay_time=time.time()-cur_time
  
  while delay_time>i*sampling:
   pwm_pin.ChangeDutyCycle(args.dutycycle)
   motor.motor_direction(in1, in2, 1)

   adcval=mcp.read_adc(AD_pin)

   if args.debug==True:
      print(f'adc val: {adcval}')
   data.append(adcval)
   elapsedtime=time.time()-cur_time
   time_array.append(elapsedtime)
   if args.debug==True:
      print(f'time: {elapsedtime:.2f}')
   i+=1
motor.motor_direction(in1, in2, 0)

with open ("data.txt","w") as file:
  file.write(f'time\t ADC val\t')
  file.write(f'\n')
  for idx in range(len(time_array)):
    file.write(f"{time_array[idx]:.2f}\t")
    file.write(f'{data[idx]}\t')
    file.write(f'\n')


