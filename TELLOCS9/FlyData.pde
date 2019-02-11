
public class FlightData
{
  public int flyMode;
  public int qheight;
  public int verticalSpeed;
  public int flySpeed;
  public int eastSpeed;
  public int northSpeed;
  public int flyTime;

  public boolean flying;//

  public boolean downVisualState;
  public boolean droneHover;
  public boolean eMOpen;
  public boolean onGround;
  public boolean pressureState;

  public int batteryPercentage;//
  public boolean batteryLow;
  public boolean batteryLower;
  public boolean batteryState;
  public boolean powerState;
  public int droneBatteryLeft;
  public int droneFlyTimeLeft;


  public int cameraState;//
  public int electricalMachineryState;
  public boolean factoryMode;
  public boolean frontIn;
  public boolean frontLSC;
  public boolean frontOut;
  public boolean gravityState;
  public int imuCalibrationState;
  public boolean imuState;
  public int lightStrength;//
  public boolean outageRecording;
  public int smartVideoExitMode;
  public int temperatureHeight;
  public int throwFlyTimer;
  public int wifiDisturb;//
  public int wifiStrength;// = 100;//
  public boolean windState;//

  //From log
  public float velX;
  public float velY;
  public float velZ;

  public float posX;
  public float posY;
  public float posZ;
  public float posUncertainty;

  public float velN;
  public float velE;
  public float velD;

  public float quatX;
  public float quatY;
  public float quatZ;
  public float quatW;

  public void set(byte[] data)
  {
    // skip the first <skip> elements 
    // byte[] data = new byte[ datain.length - 9 ]; 
    // System.arraycopy( datain, 9, data, 0, data.length );

    int index = 0;
    qheight = (int)((data[index] & 0xff ) | (data[index + 1] << 8)); 
    index += 2;
    northSpeed = (int)((data[index] & 0xff ) | (data[index + 1] << 8)); 
    index += 2;
    eastSpeed = (int)((data[index] & 0xff ) | (data[index + 1] << 8)); 
    index += 2;
    flySpeed = ((int)Math.sqrt(Math.pow(northSpeed, 2.0) + Math.pow(eastSpeed, 2.0)));
    verticalSpeed = (int)((data[index] & 0xff ) | (data[index + 1] << 8)); 
    index += 2;// ah.a(paramArrayOfByte[6], paramArrayOfByte[7]);
    flyTime = data[index] & 0xff  | (data[index + 1] << 8); 
    index += 2;// ah.a(paramArrayOfByte[8], paramArrayOfByte[9]);

    imuState = (data[index] >> 0 & 0x1) == 1 ? true : false;
    pressureState = (data[index] >> 1 & 0x1) == 1 ? true : false;
    downVisualState = (data[index] >> 2 & 0x1) == 1 ? true : false;
    powerState = (data[index] >> 3 & 0x1) == 1 ? true : false;
    batteryState = (data[index] >> 4 & 0x1) == 1 ? true : false;
    gravityState = (data[index] >> 5 & 0x1) == 1 ? true : false;
    windState = (data[index] >> 7 & 0x1) == 1 ? true : false;
    index += 1;

    //if (paramArrayOfByte.length < 19) { }
    imuCalibrationState = data[index]; 
    index += 1;
    batteryPercentage = data[index]; 
    index += 1;
    droneFlyTimeLeft = data[index] & 0xff| (data[index + 1] << 8); 
    index += 2;
    droneBatteryLeft = data[index] & 0xff | (data[index + 1] << 8); 
    index += 2;

    //index 17
    flying = (data[index] >> 0 & 0x1)==1?true:false;
    onGround = (data[index] >> 1 & 0x1) == 1 ? true : false;
    eMOpen = (data[index] >> 2 & 0x1) == 1 ? true : false;
    droneHover = (data[index] >> 3 & 0x1) == 1 ? true : false;
    outageRecording = (data[index] >> 4 & 0x1) == 1 ? true : false;
    batteryLow = (data[index] >> 5 & 0x1) == 1 ? true : false;
    batteryLower = (data[index] >> 6 & 0x1) == 1 ? true : false;
    factoryMode = (data[index] >> 7 & 0x1) == 1 ? true : false;
    index += 1;

    flyMode = data[index]; 
    index += 1;
    throwFlyTimer = data[index]; 
    index += 1;
    cameraState = data[index]; 
    index += 1;

    //if (paramArrayOfByte.length >= 22)
    electricalMachineryState = data[index]; 
    index += 1; //(paramArrayOfByte[21] & 0xFF);

    //if (paramArrayOfByte.length >= 23)
    frontIn = (data[index] >> 0 & 0x1) == 1 ? true : false;//22
    frontOut = (data[index] >> 1 & 0x1) == 1 ? true : false;
    frontLSC = (data[index] >> 2 & 0x1) == 1 ? true : false;
    index += 1;
    temperatureHeight = (data[index] >> 0 & 0x1);//23

    //  wifiStrength = Tello.wifiStrength;//Wifi str comes in a cmd.
  }
}


/*  class FlyData
 {
 int flyMode;
 int height;
 int verticalSpeed;
 int flySpeed;
 int eastSpeed;
 int northSpeed;
 int flyTime;
 
 boolean flying;//
 
 boolean downVisualState;
 boolean droneHover;
 boolean eMOpen;
 boolean onGround;
 boolean pressureState;
 
 int batteryPercentage;//
 boolean batteryLow;
 boolean batteryLower;
 boolean batteryState;
 boolean powerState;
 int droneBatteryLeft;
 int droneFlyTimeLeft;
 
 
 int cameraState;//
 int electricalMachineryState;
 boolean factoryMode;
 boolean frontIn;
 boolean frontLSC;
 boolean frontOut;
 boolean gravityState;
 int imuCalibrationState;
 boolean imuState;
 int lightStrength;//
 boolean outageRecording;
 int smartVideoExitMode;
 int temperatureHeight;
 int throwFlyTimer;
 int wifiDisturb;//
 int wifiStrength;// = 100;//
 boolean windState;//
 
 //From log
 float velX;
 float velY;
 float velZ;
 
 float posX;
 float posY;
 float posZ;
 float posUncertainty;
 
 float velN;
 float velE;
 float velD;
 
 float quatX;
 float quatY;
 float quatZ;
 float quatW;
 
 void set(byte[] data)
 {
 var index = 0;
 height = (int)(data[index] | (data[index + 1] << 8)); index += 2;
 northSpeed = (int)(data[index] | (data[index + 1] << 8)); index += 2;
 eastSpeed = (int)(data[index] | (data[index + 1] << 8)); index += 2;
 flySpeed = ((int)Math.Sqrt(Math.Pow(northSpeed, 2.0D) + Math.Pow(eastSpeed, 2.0D)));
 verticalSpeed = (int)(data[index] | (data[index + 1] << 8)); index += 2;// ah.a(paramArrayOfByte[6], paramArrayOfByte[7]);
 flyTime = data[index] | (data[index + 1] << 8); index += 2;// ah.a(paramArrayOfByte[8], paramArrayOfByte[9]);
 
 imuState = (data[index] >> 0 & 0x1) == 1 ? true : false;
 pressureState = (data[index] >> 1 & 0x1) == 1 ? true : false;
 downVisualState = (data[index] >> 2 & 0x1) == 1 ? true : false;
 powerState = (data[index] >> 3 & 0x1) == 1 ? true : false;
 batteryState = (data[index] >> 4 & 0x1) == 1 ? true : false;
 gravityState = (data[index] >> 5 & 0x1) == 1 ? true : false;
 windState = (data[index] >> 7 & 0x1) == 1 ? true : false;
 index += 1;
 
 //if (paramArrayOfByte.length < 19) { }
 imuCalibrationState = data[index]; index += 1;
 batteryPercentage = data[index]; index += 1;
 droneFlyTimeLeft = data[index] | (data[index + 1] << 8); index += 2;
 droneBatteryLeft = data[index] | (data[index + 1] << 8); index += 2;
 
 //index 17
 flying = (data[index] >> 0 & 0x1)==1?true:false;
 onGround = (data[index] >> 1 & 0x1) == 1 ? true : false;
 eMOpen = (data[index] >> 2 & 0x1) == 1 ? true : false;
 droneHover = (data[index] >> 3 & 0x1) == 1 ? true : false;
 outageRecording = (data[index] >> 4 & 0x1) == 1 ? true : false;
 batteryLow = (data[index] >> 5 & 0x1) == 1 ? true : false;
 batteryLower = (data[index] >> 6 & 0x1) == 1 ? true : false;
 factoryMode = (data[index] >> 7 & 0x1) == 1 ? true : false;
 index += 1;
 
 flyMode = data[index]; index += 1;
 throwFlyTimer = data[index]; index += 1;
 cameraState = data[index]; index += 1;
 
 //if (paramArrayOfByte.length >= 22)
 electricalMachineryState = data[index]; index += 1; //(paramArrayOfByte[21] & 0xFF);
 
 //if (paramArrayOfByte.length >= 23)
 frontIn = (data[index] >> 0 & 0x1) == 1 ? true : false;//22
 frontOut = (data[index] >> 1 & 0x1) == 1 ? true : false;
 frontLSC = (data[index] >> 2 & 0x1) == 1 ? true : false;
 index += 1;
 temperatureHeight = (data[index] >> 0 & 0x1);//23
 
 wifiStrength = Tello.wifiStrength;//Wifi str comes in a cmd.
 }
 
 //Parse some of the interesting info from the tello log stream
 void parseLog(byte[] data)
 {
 int pos = 0; 
 
 //A packet can contain more than one record.
 while (pos < data.Length-2)//-2 for CRC bytes at end of packet.
 {
 if (data[pos] != 'U')//Check magic byte
 {
 //Console.WriteLine("PARSE ERROR!!!");
 break;
 }
 var len = data[pos + 1];
 if (data[pos + 2] != 0)//Should always be zero (so far)
 {
 //Console.WriteLine("SIZE OVERFLOW!!!");
 break;
 }
 var crc = data[pos + 3];
 var id = BitConverter.ToUint(data, pos + 4);
 var xorBuf = new byte[256];
 byte xorValue = data[pos + 6];
 switch (id)
 {
 case 0x1d://29 new_mvo
 for (var i = 0; i < len; i++)//Decrypt payload.
 xorBuf[i] = (byte)(data[pos + i] ^ xorValue);
 var index = 10;//start of the velocity and pos data.
 var observationCount = BitConverter.ToUint(xorBuf, index); index += 2;
 velX = BitConverter.Toint(xorBuf, index); index += 2;
 velY = BitConverter.Toint(xorBuf, index); index += 2;
 velZ = BitConverter.Toint(xorBuf, index); index += 2;
 posX = BitConverter.ToSingle(xorBuf, index); index += 4;
 posY = BitConverter.ToSingle(xorBuf, index); index += 4;
 posZ = BitConverter.ToSingle(xorBuf, index); index += 4;
 posUncertainty = BitConverter.ToSingle(xorBuf, index)*10000.0f; index += 4;
 //Console.WriteLine(observationCount + " " + posX + " " + posY + " " + posZ);
 break;
 case 0x0800://2048 imu
 for (var i = 0; i < len; i++)//Decrypt payload.
 xorBuf[i] = (byte)(data[pos + i] ^ xorValue);
 var index2 = 10 + 48;//44 is the start of the quat data.
 quatW = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 quatX = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 quatY = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 quatZ = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 //Console.WriteLine("qx:" + qX + " qy:" + qY+ "qz:" + qZ);
 
 //var eular = toEuler(quatX, quatY, quatZ, quatW);
 //Console.WriteLine(" Pitch:"+eular[0] * (180 / 3.141592) + " Roll:" + eular[1] * (180 / 3.141592) + " Yaw:" + eular[2] * (180 / 3.141592));
 
 index2 = 10 + 76;//Start of relative velocity
 velN = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 velE = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 velD = BitConverter.ToSingle(xorBuf, index2); index2 += 4;
 //Console.WriteLine(vN + " " + vE + " " + vD);
 
 break;
 
 }
 pos += len;
 }
 }
 double[] toEuler()
 {
 float qX = quatX;
 float qY = quatY;
 float qZ = quatZ;
 float qW = quatW;
 
 double sqW = qW * qW;
 double sqX = qX * qX;
 double sqY = qY * qY;
 double sqZ = qZ * qZ;
 double yaw = 0.0;
 double roll = 0.0;
 double pitch = 0.0;
 double[] retv = new double[3];
 double unit = sqX + sqY + sqZ + sqW; // if normalised is one, otherwise
 // is correction factor
 double test = qW * qX + qY * qZ;
 if (test > 0.499 * unit)
 { // singularity at north pole
 yaw = 2 * Math.Atan2(qY, qW);
 pitch = Math.PI / 2;
 roll = 0;
 }
 else if (test < -0.499 * unit)
 { // singularity at south pole
 yaw = -2 * Math.Atan2(qY, qW);
 pitch = -Math.PI / 2;
 roll = 0;
 }
 else
 {
 yaw = Math.Atan2(2.0 * (qW * qZ - qX * qY),
 1.0 - 2.0 * (sqZ + sqX));
 roll = Math.Asin(2.0 * test / unit);
 pitch = Math.Atan2(2.0 * (qW * qY - qX * qZ),
 1.0 - 2.0 * (sqY + sqX));
 }
 retv[0] = pitch;
 retv[1] = roll;
 retv[2] = yaw;
 return retv;
 }
 
 //For saving out state info.
 string getLogHeader()
 {
 String property;  
 StringBuilder sb = new StringBuilder();
 for (property : this.GetType().GetFields())
 {
 sb.Append(property.Name);
 sb.Append(",");
 }
 sb.AppendLine();
 return sb.ToString();
 }
 string getLogLine()
 {
 StringBuilder sb = new StringBuilder();
 foreach (System.Reflection.FieldInfo property in this.GetType().GetFields())
 {
 if(property.FieldType==typeof(booleanean))
 {
 if((booleanean)property.GetValue(this)==true)
 sb.Append("1");
 else
 sb.Append("0");
 }
 else
 sb.Append(property.GetValue(this));
 sb.Append(",");
 }
 sb.AppendLine();
 return sb.ToString();
 }
 
 override string ToString()
 {
 StringBuilder sb = new StringBuilder();
 var count = 0;
 foreach (System.Reflection.FieldInfo property in this.GetType().GetFields())
 {
 sb.Append(property.Name);
 sb.Append(": ");
 sb.Append(property.GetValue(this));
 if(count++%2==1)
 sb.Append(System.Environment.NewLine);
 else
 sb.Append("      ");
 
 }
 
 return sb.ToString();
 }
 }
 
 }
 }
 
 */
