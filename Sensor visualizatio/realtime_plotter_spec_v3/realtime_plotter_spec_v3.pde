//========================================
// This is a software to enable realtime visualization of sensor data
// streamed from the serial port. The visualization include plotting data
// in the time and frequancy (spectrogram) domain. The user can control what is been
// plotted and the number of graphs using a text string
// "-" indicates new subgraph
// "." indicates new data stream to plot in the same subplot
//example:
// x.z-y
//plot x and z in the same subplot and y in a seprate subplot
//
//
//
//
//
// Kareem Bedri Dec 2018
//========================================
import java.util.Arrays;
import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.serial.*;
FFT fft;

int col=0;
int leftedge=0;
// Global veriables
Serial commPort;
int state = 0; 
String command=""; 
int noPlots; 
String[] items_list={"micros","cam","gx1","gy1","gz1","gx2","gy2","gz2","gx3","gy3","gz3","gx4","gy4","gz4","gx5","gy5","gz5","prox"};
int scale;
 
String[][] data= new String[1630][items_list.length];
String[][] dataAccele= new String[1640][80];
float[] dataAcceleVec= new float[1632*80];
int bufSize=512;
int colmax=dataAccele[0].length-1;
int lineCount=0;
color [] plotColor={color(255, 255, 255),color(255, 0, 0),color(0, 255, 0),color(0, 0, 255)};
int[][] sgram = new int[bufSize/2+1][dataAcceleVec.length/bufSize];

int dscale=5;
int offset;

void setup()
{
  fft = new FFT(bufSize, 400);
  fft.window(FFT.HAMMING);
  print(width,height);
  fullScreen();
  background(0);
  noStroke();
  fill(0);
  //serial port initialization
  commPort = new Serial(this, "/dev/cu.usbmodem3262241", 2000000);
  for(int i = 0; i<data.length; i++)
    for (int j = 0; j<items_list.length; j++)
     data[i][j] = "0";
     
   for(int i = 0; i<dataAccele.length; i++)
    for (int j = 0; j<dataAccele[0].length; j++)
     dataAccele[i][j] = "0";

  for(int i = 0; i<dataAcceleVec.length; i++)
    
     dataAcceleVec[i] = 0;

}

void draw()
{
 thread("readSerial"); // read searial data on a sperate thread 
 thread("spectrogram"); // run spectrogram of accel data on a sperate thread 

 background(0); //update background
 
 // check if the program in input or output mode
 switch (state) {
  case 0:
    fill(255,0,0); 
    text ("Command: "+command, 133, height-1); 
    break;
 
  case 1:
    fill(255); 
    text ("Command: "+command, 133, height-1);
    String[] list =  split(command, '-');
   
    
    //generate suplots
     noPlots=list.length;
    int wd=(height-30)/noPlots;
    for(int i=0; i<noPlots;i++)
    {
      stroke(255);
      fill(0);
      rect(20,i*wd+20,width-50,wd-10);
      String[] items= split(list[i],'.');
      plotData(items,i,wd);
    }
    break;
  }
}

void keyPressed() {
 
  if ((key==ENTER||key==RETURN)&&state==0) {
 
    state++;
   
  } else if ((key==ENTER||key==RETURN)&&state==1){
    state=0;
    command="";
  }
   else if ((key==DELETE||key==BACKSPACE)){
    
    command="";
  }
  else 
  command = command + key;
}


void plotData(String[] items,int i,int wd)
{
  for(int j=0;j<items.length;j++)
  {
    stroke(plotColor[j]);
    //if (items[j]=="spec")
    if(items[j].equals("accel"))
    {
      //float [] vData=vectorize(dataAccele);
      for (int k = dataAcceleVec.length-1630-160; k<dataAcceleVec.length-160; k++)
     {
      // print(dataAcceleVec[k-1]," ");
        int yy1=wd/2+(i*wd+20)-int((dataAcceleVec[k-1])/100);
        if (yy1<(i*wd+20))
        yy1=(i*wd+20);
        if (yy1>(i*wd+20)+wd-10)
        yy1=(i*wd+20)+wd-10;
        int yy2=wd/2+(i*wd+20)-int((dataAcceleVec[k])/100);
        if (yy2<(i*wd+20))
        yy2=(i*wd+20);
        if (yy2>(i*wd+20)+wd-10)
        yy2=(i*wd+20)+wd-10;
       line( 20+ k-((dataAcceleVec.length-1630-160)+2)-1, yy1 , 20+ k-(dataAcceleVec.length-1630-160)+2 ,yy2);
     }
    }
     else if(items[j].equals("spec")){
      
        wd=bufSize/2+1;
     
        int step=1;
        int d,c=0;
        for (int sc = 0; sc < (dataAcceleVec.length-160)/bufSize; sc++)
      {
        d=0;
        for (int sr = 0; sr< wd; sr++) 
        {
            stroke(sgram[sr][sc]);
            fill(sgram[sr][sc]);
            rect(sc+c*step,(i*wd+20)+sr+d*step,step,step);
            d++;
         }
         c++;
      }
        
       

    }
    
   else
    {
    int index=Arrays.asList(items_list).indexOf(items[j]);
    offset=data.length-(1630/dscale);

    if (index==items_list.length-1)
       scale=1;
    else
       scale=20;
       
       
    for (int k = offset; k<data.length; k++)
     {
        int y1=wd/2+(i*wd+20)-int(float(data[k-1][index])/scale);
        if (y1<(i*wd+20))
        y1=(i*wd+20);
        if (y1>(i*wd+20)+wd-10)
        y1=(i*wd+20)+wd-10;
        int y2=wd/2+(i*wd+20)-int(float(data[k][index])/scale);
        if (y2<(i*wd+20))
        y2=(i*wd+20);
        if (y2>(i*wd+20)+wd-10)
        y2=(i*wd+20)+wd-10;
        
       line( 20+( (k-offset)*dscale), y1 , 20+ ((k-offset+1 )*dscale),y2);

     }
    }
  }

}





int[] fixLowerByte(int[] input,int ref)
{ 
  String dBin;
  String lowByte;
  int[] returnData=new int[input.length];
  String refBin=Integer.toHexString(ref);
  String highByte =slice_range(refBin, 0, refBin.length()-2);
  for (int i=0; i<input.length;i++)
  {
    dBin=Integer.toHexString(input[i]);
    lowByte=slice_range(dBin, dBin.length()-4, dBin.length()-2);
    returnData[i]=(int) Long.parseLong(highByte+lowByte, 16);
  }
  return returnData;
}


void readSerial()
{
  int md=-15000;
  int dif,thr=1500;
   while (commPort.available() > 0 ) 
 {
   String dataLine = commPort.readStringUntil('\n');
   String[] tempData=split(dataLine," ");
   int[] buffer= new int[80];
   for (int i=0;i<dataAccele[0].length;i++)
   {
     buffer[i]=int(float(tempData[i+items_list.length]));
   }
   int zc=zeroCrossing(buffer);
   print(zc);
   if (zc>10){
      buffer=fixLowerByte(buffer,md);
   }
   dif=getMedian(buffer)-md;
   if(abs(dif)>thr)
   {
     for (int i=0;i<buffer.length;i++)
     {
       buffer[i]-=dif;
     } 
   
   }
   
     md=getMedian(buffer);
   for (int k = 1; k<data.length; k++)
     { 
       if(k == data.length-1){
       for(int c =0;c<items_list.length;c++)
         data[k][c]=tempData[c];
       for(int c =0;c<dataAccele[0].length;c++){
          
           dataAcceleVec[(k*dataAccele[0].length)+c]=float(buffer[c]);
           
         }
       } 
       else{
         for(int c =0;c<items_list.length;c++)
           data[k][c]=data[k+1][c];
          for(int c =0;c<dataAccele[0].length;c++)
           dataAcceleVec[(k*dataAccele[0].length)+c]=dataAcceleVec[((k+1)*dataAccele[0].length)+c];

       }
      }
 
 }
}



void spectrogram()
{
  int cc=0;
        for (int ind=0;ind<dataAcceleVec.length;ind=ind+bufSize){
        fft.forward(Arrays.copyOfRange((dataAcceleVec), ind,ind+bufSize ));
        for(int ii = 0; ii < fft.specSize() /* fft.specSize() */; ii++)
        {
          // fill in the new column of spectral values
         
            
            sgram[ii][cc] = (int)Math.round(Math.max(0,1*10*Math.log10(10000*fft.getBand(ii))));
           
        }
        cc++;
        }
}



float[] delta(float[] input)
{
  float[] newValueList = new float[input.length];
  float oldVal = input[0];
  for (int v=0;v<input.length;v++){
      newValueList[v]=((input[v])-(oldVal));
      oldVal = input[v];}
  return newValueList;
}


float[] vectorize(String [][]dataA)
{
  float[] returnData=new float[dataA.length*dataA[0].length];
  //float[] returnData=new float[131072];
  int count=0;
  for(int i=0;i<dataA.length;i++)
  {
    for(int j=0;j<dataA[0].length;j++)
    {
      
      returnData[count]=float(dataA[i][j]);

      count++;
    }

  }

  return(returnData);
}



public static  int zeroCrossing(int[] input)
{
  int zc=0;
  for (int i=0;i<input.length-1;i++)
  {
    if (input[i]*input[i+1]<0)
        zc++;
  } 
  

  return zc;
}
//by creating a copy array and sorting it, this function can take any data.
 public static int getMedian(int[] data) {
        int[] copy = Arrays.copyOf(data, data.length);
        Arrays.sort(copy);
        return (copy.length % 2 != 0) ? copy[copy.length / 2] : (copy[copy.length / 2] + copy[(copy.length / 2) - 1]) / 2;
    }
public String slice_range(String s, int startIndex, int endIndex) {
    if (startIndex < 0) startIndex = s.length() + startIndex;
    if (endIndex < 0) endIndex = s.length() + endIndex;
    return s.substring(startIndex, endIndex);
}

void mousePressed() {
  if (mouseButton == LEFT && dscale<30) {
    dscale+=1;
  } else if (mouseButton == RIGHT && dscale>1) {
    dscale-=1;
  } 
  
}