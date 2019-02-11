//
public class Tello
{
  /** 
  /*
  /*  document me
   ** 
   
  /*
   private  int wifiStrength=0;
   public boolean connected = false;
   
   
   public  String picPath;//todo redo this. 
   public  String picFilePath;//todo redo this. 
   public  int picMode = 0;//pic or vid aspect ratio.
   
   public  int iFrameRate = 5;//How often to ask for iFrames in 50ms. Ie 2=10x 5=4x 10=2xSecond 5 = 4xSecond
   */
  private short sequence = 1;
  /** 
  /*
  /*  document me
  */  
   public Tello() {
   }
  /** 
  /*
  /*  document me
   */
  public byte[] takeOff()
  {
    byte[] packet = { byte(0xcc), byte(0x58), byte(0x00), byte(0x7c), byte(0x68), byte(0x54), byte(0x00), byte(0xe4), byte(0x01), byte(0xc2), byte(0x16) };
    setPacketSequence(packet);
    setPacketCRCs(packet);
    return packet;
  }
  /** 
  /*
  /*  document me
   */
  public byte[] throwTakeOff()
  {
    byte[] packet = { byte(0xcc), byte( 0x58), byte(0x00), byte(0x7c), byte(0x48), byte(0x5d), byte(0x00), byte(0xe4), byte(0x01), byte(0xc2), byte(0x16) };
    setPacketSequence(packet);
    setPacketCRCs(packet);
    return packet;
  }
  /** 
  /*
  /*  document me
   */
  public byte[] land()
  {
    byte[] packet =  { byte(0xcc), byte(0x60), byte(0x00), byte(0x27), byte(0x68), byte(0x55), byte(0x00), byte(0xe5), byte(0x01), byte(0x00), byte(0xba), byte(0xc7) };

    //payload
    packet[9] = 0x00;//todo. Find out what this is for.
    setPacketSequence(packet);
    setPacketCRCs(packet);
    return packet;
  }
  /** 
  /*
  /*  document me
  */
  public byte[] requestIframe()
  {
    byte[]  iframePacket = { byte(0xcc), byte(0x58), byte(0x00), byte(0x7c), byte(0x60), byte(0x25) , byte(0x00), byte(0x00), byte(0x00), byte(0x6c), byte(0x95) };
    return (iframePacket);
  }
  /** 
  /*
  /*  document me
  */
  public byte[]setMaxHeight(int height)
  {
     //                                                         crc         typ         cmdL        cmdH        seqL        seqH        heiL        heiH       crc          crc
     byte[] packet = { byte(0xcc), byte(0x68), byte(0x00), byte(0x27), byte(0x68), byte(0x58), byte(0x00), byte(0x00), byte(0x00), byte(0x00), byte(0x00),byte(0x5b) , byte(0xc5) };

     //payload
     packet[9] = (byte)(height & 0xff);
     packet[10] = (byte)((height >>8) & 0xff);

     setPacketSequence(packet);
     setPacketCRCs(packet);

     return (packet);
  }
  /** 
  /*
  /*  document me
  */
 public byte[] queryUnk(int cmd)
        {
            byte [] packet = { byte(0xcc), byte(0x58), byte(0x00), byte(0x7c), byte(0x48), byte(0xff), byte(0x00), byte(0x06), byte(0x00), byte(0xe9), byte(0xb3) };
            packet[5] = (byte)cmd;
            setPacketSequence(packet);
            setPacketCRCs(packet);
            return (packet);
        }
 /** 
  /*
  /*  document me
  */
  public byte[] queryAttAngle()
        {
            byte[] packet =   { byte(0xcc), byte(0x58), byte(0x00), byte(0x7c), byte(0x48), byte(0x59), byte(0x10), byte(0x06), byte(0x00), byte(0xe9), byte(0xb3) };
            setPacketSequence(packet);
            setPacketCRCs(packet);
            return (packet);
        }
 /** 
  /*
  /*  document me
  */ 
  public byte[] queryMaxHeight()
        {
            byte[] packet = { byte(0xcc), byte(0x58), byte(0x00), byte(0x7c), byte(0x48), byte(0x56), byte(0x10), byte(0x06), byte(0x00), byte(0xe9), byte(0xb3) }; 
            setPacketSequence(packet);
            setPacketCRCs(packet);
            return (packet);
        }
  /** 
  /*
  /*  document me
  */        
  public byte[]  setAttAngle(float angle) // better integert value, instead of float? 
        {
            //                                                          crc         typ         cmdL        cmdH        seqL        seqH        ang1        ang2        ang3        ang4        crc         crc
            byte[] packet  = { byte(0xcc), byte(0x78), byte(0x00), byte(0x27), byte(0x68), byte(0x58), byte(0x10), byte(0x00), byte(0x00), byte(0x00), byte(0x00), byte(0x00), byte(0x00), byte(0x5b), byte(0xc5) };
            
            //payload
            packet[9] =  (byte) ((int)angle /*>> 0*/);
            packet[10] = (byte) ((int)angle >> 8);
            packet[11] = (byte) ((int)angle >> 16);
            packet[12] = (byte) ((int)angle >> 24);
            
            setPacketSequence(packet);
            setPacketCRCs(packet);

            return (packet);
           //  queryAttAngle();//refresh -> wird vom thread.avalable in drwa gelesen, es ist eine neue Logik zum Empfangen der Daten notwendig

            
        }
  /** 
  /*
  /*  document me
  */
  
        
/**********************************************************************/  
  
  /** 
  /*
  /*  document me
  */
  private  byte[] connect()
  {
    // Console.WriteLine("Connecting to tello.");

    byte[] connectPacket = ("conn_req:xx").getBytes();
    connectPacket[connectPacket.length - 2] = byte(0x96);
    connectPacket[connectPacket.length - 1] = byte(0x17);
    return connectPacket;
  }
  /** 
  /*
  /*  document me
   */
  private void setPacketSequence(byte[] packet)
  {
    packet[7] = (byte)(sequence & 0xff);
    packet[8] = (byte)((sequence >> 8) & 0xff);
    sequence++;
  }
  /** 
  /*
  /*  document me
   */
  private void setPacketCRCs(byte[] packet)
  {
    calcUCRC(packet, 4);
    calcCrc(packet, packet.length);
  }
  //Pause connections. Used by aTello when app paused.
  
  public int poly = 13970;
  public int[] fcstab = { 0, 4489, 8978, 12955, 17956, 22445, 25910, 29887, 35912, 40385, 44890, 48851, 51820, 56293, 59774, 63735, 4225, 264, 13203, 8730, 22181, 18220, 30135, 25662, 40137, 36160, 49115, 44626, 56045, 52068, 63999, 59510, 8450, 12427, 528, 5017, 26406, 30383, 17460, 21949, 44362, 48323, 36440, 40913, 60270, 64231, 51324, 55797, 12675, 8202, 4753, 792, 30631, 26158, 21685, 17724, 48587, 44098, 40665, 36688, 64495, 60006, 55549, 51572, 16900, 21389, 24854, 28831, 1056, 5545, 10034, 14011, 52812, 57285, 60766, 64727, 34920, 39393, 43898, 47859, 21125, 17164, 29079, 24606, 5281, 1320, 14259, 9786, 57037, 53060, 64991, 60502, 39145, 35168, 48123, 43634, 25350, 29327, 16404, 20893, 9506, 13483, 1584, 6073, 61262, 65223, 52316, 56789, 43370, 47331, 35448, 39921, 29575, 25102, 20629, 16668, 13731, 9258, 5809, 1848, 65487, 60998, 56541, 52564, 47595, 43106, 39673, 35696, 33800, 38273, 42778, 46739, 49708, 54181, 57662, 61623, 2112, 6601, 11090, 15067, 20068, 24557, 28022, 31999, 38025, 34048, 47003, 42514, 53933, 49956, 61887, 57398, 6337, 2376, 15315, 10842, 24293, 20332, 32247, 27774, 42250, 46211, 34328, 38801, 58158, 62119, 49212, 53685, 10562, 14539, 2640, 7129, 28518, 32495, 19572, 24061, 46475, 41986, 38553, 34576, 62383, 57894, 53437, 49460, 14787, 10314, 6865, 2904, 32743, 28270, 23797, 19836, 50700, 55173, 58654, 62615, 32808, 37281, 41786, 45747, 19012, 23501, 26966, 30943, 3168, 7657, 12146, 16123, 54925, 50948, 62879, 58390, 37033, 33056, 46011, 41522, 23237, 19276, 31191, 26718, 7393, 3432, 16371, 11898, 59150, 63111, 50204, 54677, 41258, 45219, 33336, 37809, 27462, 31439, 18516, 23005, 11618, 15595, 3696, 8185, 63375, 58886, 54429, 50452, 45483, 40994, 37561, 33584, 31687, 27214, 22741, 18780, 15843, 11370, 7921, 3960 };

  private int fsc16(byte[] bytes, int len, int poly)
  {
    if (bytes == null)
    {
      return 65535;
    }
    int i = 0;
    int j = poly;
    poly = len;
    len = j;
    while (true)
    {
      j = len;
      if (poly == 0)
      {
        break;
      }
      j = bytes[i];
      len = fcstab[((len ^ j) & 0xFF)] ^ len >> 8;
      i += 1;
      poly -= 1;
    }
    return j;
  }
  //write fsc16 crc into the last 2 bytes of the array.
  private void calcCrc(byte[] bytes, int len)
  {
    if ((bytes == null) || (len <= 2))
    {
      return;
    }
    int i = fsc16(bytes, len - 2, poly);
    bytes[(len - 2)] = ((byte)(i & 0xFF));
    bytes[(len - 1)] = ((byte)(i >> 8 & 0xFF));
  }

  //uCRC
  public  short[] uCRCTable = { 0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65, 157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220, 35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98, 190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255, 70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7, 219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154, 101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36, 248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185, 140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205, 17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80, 175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238, 50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115, 202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139, 87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22, 233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168, 116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53 };
  public  int uCRC(byte[] bytes, int len, int poly)
  {
    int j = 0;
    int i = poly;
    poly = j;
    while (len != 0)
    {
      j = bytes[poly] ^ i;
      i = j;
      if (j < 0)
      {
        i = j + 256;
      }
      i = uCRCTable[i];
      poly += 1;
      len -= 1;
    }
    return i;
  }

  //write uCRC to bytes[len-1]
  public void calcUCRC(byte[] bytes, int len)
  {
    if ((bytes.length == 0) || (len <= 2))
    {
      return;
    }
    int i = uCRC(bytes, len - 1, 119);
    bytes[(len - 1)] = ((byte)(i & 0xFF));
  }
}
