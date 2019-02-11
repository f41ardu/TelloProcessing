// import UDP library
import hypermedia.net.*;

public class myUDP extends UDP { 

  //  public String received =""; 

  public myUDP(PApplet app, String ip, int port)
  {
    super(app, port, ip);   //super(this, ip, port)  this not allowed this should be the UDP constructor

   // super.setReceiveHandler("myreceiver");  //this does nothing

    //   super.log(true);
    super.listen( true);
  }
 
}
