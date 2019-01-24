// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP
import java.net.*;

class ReceiverThread extends Thread {

  // Port we are receiving.
  int port = 8889; 
  DatagramSocket ds; 
  // A byte array to read into (max size of 65536, could be smaller)
  byte[] buffer = new byte[65536]; 

  boolean running;    // Is the thread running?  Yes or no?
  boolean available;  // Are there new tweets available?

  // Start with something 
  String ireceived;

  ReceiverThread () {
    ireceived = "";
    running = false;
    available = true; // We start with "loading . . " being available

    try {
      ds = new DatagramSocket(port);
    } 
    catch (SocketException e) {
      e.printStackTrace();
    }
  }

  String getData() {
    // We set available equal to false now that we've gotten the data
    available = false;
    return ireceived;
  }

  boolean available() {
    return available;
  }

  // Overriding "start()"
  void start () {
    running = true;
    super.start();
  }

  // We must implement run, this gets triggered by start()
  void run () {
    while (running) {
      checkForData();
      // New data is available!
      available = true;
    }
  }

  void checkForData() {
    DatagramPacket p = new DatagramPacket(buffer, buffer.length); 
    try {
      ds.receive(p);
    } 
    catch (IOException e) {
      e.printStackTrace();
    } 

    // Read incoming data 
    byte[] data = new byte[ p.getLength() ];
    System.arraycopy( p.getData(), 0, data, 0, data.length );

    //println("Received datagram with " + data.length + " bytes." );

    // Update 
    ireceived= new String(data);
  }


  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // In case the thread is waiting. . .
    interrupt();
  }

  public boolean send( byte[] buffer, String ip, int port ) {

    boolean success  = false;
    // send
    try {
      ds.send(new DatagramPacket( buffer, buffer.length, InetAddress.getByName(ip), port ));
      success = true;
    }
    catch( IOException e ) {
      print( "could not send message!"+
        "\t\n> port:"+port+
        "\t\n> bufferlenght:"+buffer+
        ", ip:"+ip+
        "\t\n> "+e.getMessage()
        );
    }
    return success;
  }
}
