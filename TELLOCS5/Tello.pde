//

public class Tello
{
/*
  private  int wifiStrength=0;
  public boolean connected = false;


  public  String picPath;//todo redo this. 
  public  String picFilePath;//todo redo this. 
  public  int picMode = 0;//pic or vid aspect ratio.

  public  int iFrameRate = 5;//How often to ask for iFrames in 50ms. Ie 2=10x 5=4x 10=2xSecond 5 = 4xSecond
*/
  private short sequence = 1;

  public Tello() {
  }


  public byte[] takeOff()
  {
    byte[] packet = { byte(0xcc), byte(0x58), byte(0x00), byte(0x7c), byte(0x68), byte(0x54), byte(0x00), byte(0xe4), byte(0x01), byte(0xc2), byte(0x16) };
    setPacketSequence(packet);
    setPacketCRCs(packet);
    return packet;
  }
  public byte[] throwTakeOff()
  {
    byte[] packet = { byte(0xcc), byte( 0x58), byte(0x00), byte(0x7c), byte(0x48), byte(0x5d), byte(0x00), byte(0xe4), byte(0x01), byte(0xc2), byte(0x16) };
    setPacketSequence(packet);
    setPacketCRCs(packet);
    return packet;
    
  }
  public  byte[] land()
  {
    byte[] packet =  { byte(0xcc), byte(0x60), byte(0x00), byte(0x27), byte(0x68), byte(0x55), byte(0x00), byte(0xe5), byte(0x01), byte(0x00), byte(0xba), byte(0xc7) };

    //payload
    packet[9] = 0x00;//todo. Find out what this is for.
    setPacketSequence(packet);
    setPacketCRCs(packet);
    return packet;
    
  }

  private  byte[] connect()
  {
    //Console.WriteLine("Connecting to tello.");

    byte[] connectPacket = ("conn_req:xx").getBytes();
    connectPacket[connectPacket.length - 2] = byte(0x96);
    connectPacket[connectPacket.length - 1] = byte(0x17);
    return connectPacket;
  }


  private void setPacketSequence(byte[] packet)
  {
    packet[7] = (byte)(sequence & 0xff);
    packet[8] = (byte)((sequence >> 8) & 0xff);
    sequence++;
  }
  private void setPacketCRCs(byte[] packet)
  {
    CRC UCRC = new CRC(); 
    CRC Crc = new CRC();
    UCRC.calcUCRC(packet, 4);
    Crc.calcCrc(packet, packet.length);
  }
  //Pause connections. Used by aTello when app paused.
}
