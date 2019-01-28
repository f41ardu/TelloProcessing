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
  /* 
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
        
        
  public byte[]  setAttAngle(float angle)
        {
            //                                          crc    typ  cmdL  cmdH  seqL  seqH  ang1  ang2 ang3  ang4  crc   crc
            byte[] packet  { 0xcc, 0x78, 0x00, 0x27, 0x68, 0x58, 0x10, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x5b, 0xc5 };
            
            //payload
            packet[9] =  (byte) (i /*>> 0*/);
            packet[10] = (byte) (i >> 8);
            packet[11] = (byte) (i >> 16);
            packet[12] = (byte) (i >> 24);
            
            setPacketSequence(packet);
            setPacketCRCs(packet);

            return (packet);

            Tello.queryAttAngle();//refresh
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
    //Console.WriteLine("Connecting to tello.");

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
    CRC UCRC = new CRC(); 
    CRC Crc = new CRC();
    UCRC.calcUCRC(packet, 4);
    Crc.calcCrc(packet, packet.length);
  }
  //Pause connections. Used by aTello when app paused.
}
