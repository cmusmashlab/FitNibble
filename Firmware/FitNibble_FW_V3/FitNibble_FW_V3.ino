#include <Wire.h>  
#include <SPI.h>
#include <BLEPeripheral.h>
#include "BLESerial.h"
#include <stdio.h>

//Magnetometer Registers
#define AK8963_ADDRESS   0x0C                                                                                                                                                       
#define AK8963_WHO_AM_I  0x00 // should return 0x48
#define AK8963_INFO      0x01
#define AK8963_ST1       0x02  // data ready status bit 0
#define AK8963_XOUT_L   0x03  // data
#define AK8963_XOUT_H  0x04
#define AK8963_YOUT_L  0x05
#define AK8963_YOUT_H  0x06
#define AK8963_ZOUT_L  0x07
#define AK8963_ZOUT_H  0x08
#define AK8963_ST2       0x09  // Data overflow bit 3 and data read error status bit 2
#define AK8963_CNTL      0x0A  // Power down (0000), single-measurement (0001), self-test (1000) and Fuse ROM (1111) modes on bits 3:0
#define AK8963_ASTC      0x0C  // Self test control
#define AK8963_I2CDIS    0x0F  // I2C disable
#define AK8963_ASAX      0x10  // Fuse ROM x-axis sensitivity adjustment value
#define AK8963_ASAY      0x11  // Fuse ROM y-axis sensitivity adjustment value
#define AK8963_ASAZ      0x12  // Fuse ROM z-axis sensitivity adjustment value

#define SELF_TEST_X_GYRO 0x00                  
#define SELF_TEST_Y_GYRO 0x01                                                                          
#define SELF_TEST_Z_GYRO 0x02

#define SELF_TEST_X_ACCEL 0x0D
#define SELF_TEST_Y_ACCEL 0x0E    
#define SELF_TEST_Z_ACCEL 0x0F

#define SELF_TEST_A      0x10

#define XG_OFFSET_H      0x13  // User-defined trim values for gyroscope
#define XG_OFFSET_L      0x14
#define YG_OFFSET_H      0x15
#define YG_OFFSET_L      0x16
#define ZG_OFFSET_H      0x17
#define ZG_OFFSET_L      0x18
#define SMPLRT_DIV       0x19
//#define CONFIG           0x1A
#define GYRO_CONFIG      0x1B
#define ACCEL_CONFIG     0x1C
#define ACCEL_CONFIG2    0x1D
#define LP_ACCEL_ODR     0x1E   
#define WOM_THR          0x1F   

#define MOT_DUR          0x20  // Duration counter threshold for motion interrupt generation, 1 kHz rate, LSB = 1 ms
#define ZMOT_THR         0x21  // Zero-motion detection threshold bits [7:0]
#define ZRMOT_DUR        0x22  // Duration counter threshold for zero motion interrupt generation, 16 Hz rate, LSB = 64 ms

#define FIFO_EN          0x23
#define I2C_MST_CTRL     0x24   
#define I2C_SLV0_ADDR    0x25
#define I2C_SLV0_REG     0x26
#define I2C_SLV0_CTRL    0x27
#define I2C_SLV1_ADDR    0x28
#define I2C_SLV1_REG     0x29
#define I2C_SLV1_CTRL    0x2A
#define I2C_SLV2_ADDR    0x2B
#define I2C_SLV2_REG     0x2C
#define I2C_SLV2_CTRL    0x2D
#define I2C_SLV3_ADDR    0x2E
#define I2C_SLV3_REG     0x2F
#define I2C_SLV3_CTRL    0x30
#define I2C_SLV4_ADDR    0x31
#define I2C_SLV4_REG     0x32
#define I2C_SLV4_DO      0x33
#define I2C_SLV4_CTRL    0x34
#define I2C_SLV4_DI      0x35
#define I2C_MST_STATUS   0x36
#define INT_PIN_CFG      0x37
#define INT_ENABLE       0x38
#define DMP_INT_STATUS   0x39  // Check DMP interrupt
#define INT_STATUS       0x3A
#define ACCEL_XOUT_H     0x3B
#define ACCEL_XOUT_L     0x3C
#define ACCEL_YOUT_H     0x3D
#define ACCEL_YOUT_L     0x3E
#define ACCEL_ZOUT_H     0x3F
#define ACCEL_ZOUT_L     0x40
#define TEMP_OUT_H       0x41
#define TEMP_OUT_L       0x42
#define GYRO_XOUT_H      0x43
#define GYRO_XOUT_L      0x44
#define GYRO_YOUT_H      0x45
#define GYRO_YOUT_L      0x46
#define GYRO_ZOUT_H      0x47
#define GYRO_ZOUT_L      0x48
#define EXT_SENS_DATA_00 0x49
#define EXT_SENS_DATA_01 0x4A
#define EXT_SENS_DATA_02 0x4B
#define EXT_SENS_DATA_03 0x4C
#define EXT_SENS_DATA_04 0x4D
#define EXT_SENS_DATA_05 0x4E
#define EXT_SENS_DATA_06 0x4F
#define EXT_SENS_DATA_07 0x50
#define EXT_SENS_DATA_08 0x51
#define EXT_SENS_DATA_09 0x52
#define EXT_SENS_DATA_10 0x53
#define EXT_SENS_DATA_11 0x54
#define EXT_SENS_DATA_12 0x55
#define EXT_SENS_DATA_13 0x56
#define EXT_SENS_DATA_14 0x57
#define EXT_SENS_DATA_15 0x58
#define EXT_SENS_DATA_16 0x59
#define EXT_SENS_DATA_17 0x5A
#define EXT_SENS_DATA_18 0x5B
#define EXT_SENS_DATA_19 0x5C
#define EXT_SENS_DATA_20 0x5D
#define EXT_SENS_DATA_21 0x5E
#define EXT_SENS_DATA_22 0x5F
#define EXT_SENS_DATA_23 0x60
#define MOT_DETECT_STATUS 0x61
#define I2C_SLV0_DO      0x63
#define I2C_SLV1_DO      0x64
#define I2C_SLV2_DO      0x65
#define I2C_SLV3_DO      0x66
#define I2C_MST_DELAY_CTRL 0x67
#define SIGNAL_PATH_RESET  0x68
#define MOT_DETECT_CTRL  0x69
#define USER_CTRL        0x6A  // Bit 7 enable DMP, bit 3 reset DMP
#define PWR_MGMT_1       0x6B // Device defaults to the SLEEP mode
#define PWR_MGMT_2       0x6C
#define DMP_BANK         0x6D  // Activates a specific bank in the DMP
#define DMP_RW_PNT       0x6E  // Set read/write pointer to a specific start address in specified DMP bank
#define DMP_REG          0x6F  // Register in DMP from which to read or to which to write
#define DMP_REG_1        0x70
#define DMP_REG_2        0x71 
#define FIFO_COUNTH      0x72
#define FIFO_COUNTL      0x73
#define FIFO_R_W         0x74
#define WHO_AM_I_MPU9250 0x75 // Should return 0x71
#define XA_OFFSET_H      0x77
#define XA_OFFSET_L      0x78
#define YA_OFFSET_H      0x7A
#define YA_OFFSET_L      0x7B
#define ZA_OFFSET_H      0x7D
#define ZA_OFFSET_L      0x7E

#define MPU9250_ADDRESS2 0x69  // Device address when ADO = 1
#define MPU9250_ADDRESS 0x68  // Device address when ADO = 0
#define AK8963_ADDRESS 0x0C   //  Address of magnetometer
  


// The VCNL Prox Sensor Config
#define VCNL4040_ADDR 0x60 //7-bit unshifted I2C address of VCNL4040
//Command Registers have an upper byte and lower byte.
#define PS_CONF1 0x03
//#define PS_CONF2 //High byte of PS_CONF1
#define PS_CONF3 0x04
//#define PS_MS //High byte of PS_CONF3
#define PS_DATA_L 0x08
//#define PS_DATA_M //High byte of PS_DATA_L
#define PROX_ID  0x0C
#define ALS_DATA_L 0x09
#define ALS_CON 0x00

int16_t accelCount[3];  // Stores the 16-bit signed accelerometer sensor output
int16_t gyroCount[3];   // Stores the 16-bit signed gyro sensor output
int16_t gyroCount2[3];   // Stores the 16-bit signed gyro sensor output

int16_t magCount[3];    // Stores the 16-bit signed magnetometer sensor output


int16_t ax, ay, az, gx, gy, gz, mx, my, mz,mag1, mag2; // variables to hold latest sensor data values 

/////////////////////////////////// wire init //////////////////////////////////////////////
TwoWire wire0(NRF_TWIM0, NRF_TWIS0, SPIM0_SPIS0_TWIM0_TWIS0_SPI0_TWI0_IRQn, 23, 25);

int i=0;
// define pins (varies per shield/board)
#define BLE_REQ   10
#define BLE_RDY   2
#define BLE_RST   9

// create ble serial instance, see pinouts above
BLESerial BLESerial(BLE_REQ, BLE_RDY, BLE_RST);

int16_t beginTime=millis();
int64_t tempTime;
bool bufferFull=false;
/////////////////////////////////////////////////////
//buffers
const int len=50;
float gx1[len],gy1[len],gz1[len],gx2[len],gy2[len],gz2[len],prox[len];
float old_gx1=0,old_gy1=0,old_gz1=0,old_gx2=0,old_gy2=0,old_gz2=0;
long counter=0;
const int bins[]={-10000000000, -50, -40, -30, -20, -10, 0, 10, 20, 30, 40, 50, 10000000000};
const int numberBins=13;
const int numchannleFeatuers=6;
const int totalNumFeatuers=42;
float featuers[totalNumFeatuers];
bool serial=false;
bool ble=false;
int hist[numberBins-1];
float zcResult[2];
int fCount=0;
int bleSentCount=0;
const int fs=10;
int readCount=0;
long t0=millis();
long cameraTimer=0;
int BLELED=0;//15;
int PWRLED=3;//14;
int RELAYP=11;
int RELAYN=6;
#define DOWN_TIME 5000 //30*60*1000 //should be half an hour
#define RECORD_TIME 5000 //6*60*1000
#define CHECK_SD_TIME 5000 //30*60*1000

/////////////////////////////////////////////////////
void setup()
{
//  intialize I2C, UART and BT UARDT
  wire0.begin();
  Serial.begin(115200);
  BLESerial.begin();
//Setup prox data
 int deviceID = readFromCommandRegister(PROX_ID,wire0);
if (deviceID != 0x186)
  {
    Serial.println("Device not found. Check wiring.");
    Serial.print("Expected: 0x186. Heard: 0x");
    Serial.println(deviceID, HEX);
    while (1); //Freeze!
  }
  Serial.println("VCNL4040 detected!");
//
  initVCNL4040(wire0); //Configure sensor
  
//  initiate featuers vector
  for (int i; i<totalNumFeatuers;i++)
  {
    featuers[i]=0;
  } 


  pinMode(BLELED,OUTPUT);
  digitalWrite(BLELED,HIGH); //BLE running indicator 


}

void loop()
{ 
  BLESerial.poll(); // initiate BLE send 

  // read sensor data and send featuer segments via BLE
  while(readCount<fs)
  {  

    if (millis()-t0 >= 100)
    { 
      t0=millis();
      
      readSensors(); // read data every 100 ms
      
      //send featuers
      if (readCount<fs-1) //send 4 numbers from the featuer vecto every 100ms to deal with BLE Serial latancy 
      {
          sendBLE(bleSentCount,bleSentCount+4);
          bleSentCount=bleSentCount+4;
      }
      else //send the last 4 numbers 
      {
        sendBLE(bleSentCount,totalNumFeatuers); 
        BLESerial.println(); 
      }
      readCount++;
    }  
  }
  
  readCount = 0; // reset read counter 
  bleSentCount = 0; // reset BLE sending counter 

  
  if (!bufferFull && millis() - beginTime > 5000) // start computing featuers from data buffer after 5 seconds 
  {
    bufferFull = true;
    tempTime=millis();
    featuerExtractionALL();
  }
  
  // check for millis() rest (the millis function relays on 8 bit counter that get rested after it reaches the final count)
  if (millis()-tempTime<0)
  {
    tempTime=millis();
   
   }
  
  if (bufferFull && millis()-tempTime>500) // keep computing featuers from data buffer every 0.5 seconds 
  {
    tempTime=millis();

    featuerExtractionALL();

   }
    
}
//======================= functions ============================================================================

//send data via BLESerial
void sendBLE(int start,int end)
{
  for (int i=start; i<end;i++) 
    {
      BLESerial.print(featuers[i]);BLESerial.print(" ");
      
    }
}


//Read all sensors  data
void readSensors()
{
  // Read Refrence Gyro at the back
   if (readByte(MPU9250_ADDRESS, INT_STATUS,wire0) & 0x01) 
   {  // On interrupt, check if data ready interrupt
      readGyroData(gyroCount,wire0,MPU9250_ADDRESS);
    //perform delta function on the readings 
      gx1[counter] = (float)gyroCount[0]-old_gx1;  
      gy1[counter] = (float)gyroCount[1]-old_gy1;  
      gz1[counter] = (float)gyroCount[2]-old_gz1;
      old_gx1=(float)gyroCount[0];
      old_gy1=(float)gyroCount[1];
      old_gz1=(float)gyroCount[2];   
    }
  
  // Read Ear Gyro 
   if (readByte(MPU9250_ADDRESS2, INT_STATUS,wire0) & 0x01) 
   {  // On interrupt, check if data ready interrupt
    readGyroData(gyroCount2,wire0,MPU9250_ADDRESS2);
     //perform delta function on the readings 
     gx2[counter] = (float)gyroCount2[0]-old_gx2;
     gy2[counter] = (float)gyroCount2[1]-old_gy2; 
     gz2[counter] = (float)gyroCount2[2]-old_gz2;
     old_gx2=(float)gyroCount2[0];
     old_gy2=(float)gyroCount2[1];
     old_gz2=(float)gyroCount2[2];

   }
  
    // Read proximity senors data
    prox[counter] = (float)readFromCommandRegister(PS_DATA_L,wire0);
    counter++;

    //Shift values inside the data buffer 
    if (counter >= len)
      { 
        counter=len-1;
        for (int i=0;i<len-1;i++)
        {gx1[i]=gx1[i+1];gy1[i]=gy1[i+1];gz1[i]=gz1[i+1];gx2[i]=gx2[i+1];gy2[i]=gy2[i+1];gz2[i]=gz2[i+1];prox[i]=prox[i+1];}
      
      }
        
 }


//===================================================================================================================
//====== Featuer Extractio
//===================================================================================================================
void featuerExtractionALL(void)
{  fCount=0;

  featuerExtraction(gx2,len);
  featuerExtraction(gy2,len);
  featuerExtraction(gz2,len);
  featuerExtraction(gx1,len);
  featuerExtraction(gy1,len);
  featuerExtraction(gz1,len);
  featuerExtraction(prox,len);
}
  
void  featuerExtraction(float data[],int l)
  { 

    // absMedian

     featuers[fCount]= absMedian(data,l);
     fCount+=7;
     // EntropyBins
     featuers[fCount]= entropy(data,l);
     fCount+=7;
     // Var
     featuers[fCount]= variance(data,l);
     fCount+=7;
     // RMS
     featuers[fCount]= rms(data,l);
     fCount+=7;
      
     zeroCrossing(data,l);
     // ZeroCrossingVar
     featuers[fCount]=zcResult[0];
     fCount+=7;
     // ZeroCrossing
     featuers[fCount]=zcResult[1];
     fCount=fCount-(7*5)+1;

     }

void swap(float *p,float *q) {
   int t;
   
   t=*p; 
   *p=*q; 
   *q=t;
}

void sort(float a[],int n) { 
   int i,j,temp;

   for(i = 0;i < n-1;i++) {
      for(j = 0;j < n-i-1;j++) {
         if(a[j] > a[j+1])
            swap(&a[j],&a[j+1]);
      }
   }
}

// Function for calculating variance
float variance(float a[], int n)
{
    // Compute mean (average of elements)
    int sum = 0;
    for (int i = 0; i < n; i++)
        sum += a[i];
    double mean = (double)sum /(double)n;
  
    // Compute sum squared 
    // differences with mean.
    double sqDiff = 0;
    for (int i = 0; i < n; i++) 
        sqDiff += (a[i] - mean) * 
                  (a[i] - mean);
    return (float)((float)sqDiff / (float)(n-1));
}


float absMedian(float data[],int l) {
  float temp[l];
  for (int i=0; i<l;i++){temp[i]=abs(data[i]);}
   sort(temp,l);
   int n = int((l+1) / 2 )- 1;      // -1 as array indexing in C starts from 0

   return temp[n];
}

void zeroCrossing(float data[],int l)
   { int zc=0;
    float zcTemp[l];
    float zcTemp2[l];
   
    for (int i=0; i<l-1;i++)
      {
        if (data[i]*data[i+1]<0)
        {    
          zcTemp[zc]=i;
          zc++;
        }
      }

      if (zc >1)
      {
        for (int j=0;j<zc-1;j++)
        {
          zcTemp2[j]=zcTemp[j+1]-zcTemp[j];
          }
        zcResult[0]= (float)variance(zcTemp2, zc-1);
        }
        else
        {
          zcResult[0]=0.0;
          }
        zcResult[1]=(float)zc;
   }

// Function that Calculate Root Mean Square
float rms(float arr[], int n)
{
    int square = 0;
    float mean = 0.0, root = 0.0;
  
    // Calculate square.
    for (int i = 0; i < n; i++) {
        square += pow(arr[i], 2);
    }
  
    // Calculate Mean.
    mean = (square / (float)(n));
  
    // Calculate Root.
    root = sqrt(mean);
  
    return root;
}
 
 void histogram(float* data,int l )
 {
//  int hist[numberBins-1];
// intialize hist
 for(int t=0;t<numberBins-1;t++){hist[t]=0;}
  
  for(int i=0;i<l;i++)
  {
    for (int b=0;b<numberBins-1;b++)
    {
      if (data[i]>= bins[b] &&  data[i]< bins[b+1])
      {
        hist[b]++;
      }

    }
  }

  
  }

  float entropy(float data[],int l )
  {

    histogram(data,l);

    float ent=0.0;
   for (int p=0;p<numberBins-1;p++) 
    {
      if( hist[p]!=0)
      {
      ent=ent+(hist[p]*log(hist[p]));
      }
    
    }
    
    return ent*-1;
   }


   
//===================================================================================================================
//====== Set of useful function to access acceleration. gyroscope, magnetometer, and temperature data
//===================================================================================================================

        uint8_t readByte(uint8_t address, uint8_t subAddress,TwoWire wire)
{
  uint8_t data; // `data` will store the register data   
  wire.beginTransmission(address);         // Initialize the Tx buffer
  wire.write(subAddress);                  // Put slave register address in Tx buffer
  wire.endTransmission();        //                                                                             Send the Tx buffer, but send a restart to keep connection alive
//  Wire.endTransmission(false);             // Send the Tx buffer, but send a restart to keep connection alive
//  Wire.requestFrom(address, 1);  // Read one byte from slave register address 
  wire.requestFrom(address, (size_t) 1);  // Read one byte from slave register address 
  data = wire.read();                      // Fill Rx buffer with result
  return data;                             // Return data read from slave register
}

        void readBytes(uint8_t address, uint8_t subAddress, uint8_t count, uint8_t * dest, TwoWire wire)
{  
  wire.beginTransmission(address);   // Initialize the Tx buffer
  wire.write(subAddress);            // Put slave register address in Tx buffer
  wire.endTransmission();  // Send the Tx buffer, but send a restart to keep connection alive
//  Wire.endTransmission(false);       // Send the Tx buffer, but send a restart to keep connection alive
  uint8_t i = 0;
//        Wire.requestFrom(address, count);  // Read bytes from slave register address 
        wire.requestFrom(address, (size_t) count);  // Read bytes from slave register address 
  while (wire.available()) {
        dest[i++] = wire.read(); }         // Put read results in the Rx buffer
}

void readAccelData(int16_t * destination, TwoWire wire,uint8_t address)
{
  uint8_t rawData[6];  // x/y/z accel register data stored here
  readBytes(address, ACCEL_XOUT_H, 6, &rawData[0],wire);  // Read the six raw data registers into data array
  destination[0] = ((int16_t)rawData[0] << 8) | rawData[1] ;  // Turn the MSB and LSB into a signed 16-bit value
  destination[1] = ((int16_t)rawData[2] << 8) | rawData[3] ;  
  destination[2] = ((int16_t)rawData[4] << 8) | rawData[5] ; 
}
void readGyroData(int16_t * destination,TwoWire wire, uint8_t address)
{
  uint8_t rawData[6];  // x/y/z gyro register data stored here
  readBytes(address, GYRO_XOUT_H, 6, &rawData[0],wire);  // Read the six raw data registers sequentially into data array
  destination[0] = ((int16_t)rawData[0] << 8) | rawData[1] ;  // Turn the MSB and LSB into a signed 16-bit value
  destination[1] = ((int16_t)rawData[2] << 8) | rawData[3] ;  
  destination[2] = ((int16_t)rawData[4] << 8) | rawData[5] ; 
}
void readMagData(int16_t * destination,TwoWire wire)
{
  uint8_t rawData[7];  // x/y/z gyro register data, ST2 register stored here, must read ST2 at end of data acquisition
  if(readByte(AK8963_ADDRESS, AK8963_ST1,wire) & 0x01) { // wait for magnetometer data ready bit to be set
  readBytes(AK8963_ADDRESS, AK8963_XOUT_L, 7, &rawData[0],wire);  // Read the six raw data and ST2 registers sequentially into data array
  uint8_t c = rawData[6]; // End data read by reading ST2 register
    if(!(c & 0x08)) { // Check if magnetic sensor overflow set, if not then report data
    destination[0] = ((int16_t)rawData[1] << 8) | rawData[0] ;  // Turn the MSB and LSB into a signed 16-bit value
    destination[1] = ((int16_t)rawData[3] << 8) | rawData[2] ;  // Data stored as little Endian
    destination[2] = ((int16_t)rawData[5] << 8) | rawData[4] ; 
   }
  }
}


  //Reads a two byte value from a command register
unsigned int readFromCommandRegister(byte commandCode,TwoWire wire)
{
  wire.beginTransmission(VCNL4040_ADDR);
  wire.write(commandCode);
  wire.endTransmission(false); //Send a restart command. Do not release bus.

  wire.requestFrom(VCNL4040_ADDR, 2); //Command codes have two bytes stored in them

  unsigned int data = wire.read();
  data |= wire.read() << 8;

  return (data);
}

//Configure the various parts of the VCNL Prox Sensor
void initVCNL4040(TwoWire wire)
{
  //Clear PS_SD to turn on proximity sensing
  //byte conf1 = 0b00000000; //Clear PS_SD bit to begin reading
  byte conf1 = 0b00001110; //Integrate 8T, Clear PS_SD bit to begin reading
  byte conf2 = 0b00001000; //Set PS to 16-bit
  //byte conf2 = 0b00000000; //Clear PS to 12-bit
  writeToCommandRegister(PS_CONF1, conf1, conf2,wire); //Command register, low byte, high byte

  //Set the options for PS_CONF3 and PS_MS bytes
  byte conf3 = 0x00;
  //byte ms = 0b00000010; //Set IR LED current to 100mA
  //byte ms = 0b00000110; //Set IR LED current to 180mA
  byte ms = 0b00000111; //Set IR LED current to 200mA
  writeToCommandRegister(PS_CONF3, conf3, ms,wire);

  //enabl ALS
// writeToCommandRegister( ALS_CON, 0b11000000, 0x00,wire);
} 

void writeToCommandRegister(byte commandCode, byte lowVal, byte highVal,TwoWire wire)
{
  wire.beginTransmission(VCNL4040_ADDR);
  wire.write(commandCode);
  wire.write(lowVal); //Low byte of command
  wire.write(highVal); //High byte of command
  wire.endTransmission(); //Release bus
}

 
