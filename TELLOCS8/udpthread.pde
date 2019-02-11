// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP
import java.net.*;

class ReceiverThread extends Thread {

  // Port we are receiving.
  int port = 9000; 
  DatagramSocket ds; 
  // A byte array to read into (max size of 65536, could be smaller)
  byte[] buffer = new byte[65536]; 

  boolean running;    // Is the thread running?  Yes or no?
  boolean available;  // Are there new tweets available?

  // Start with something 
  String ireceived;
  byte[] byteReceived = new byte[2048]; 

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

   byte[] getBytes() {
    // We set available equal to false now that we've gotten the data
    available = false;
    return byteReceived;
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
    byteReceived = data;
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

// non class implementation of bytehelper 
// todo - make a  class. 

/**
 *
 * Conctenate the given byte arrays into one array.
 * 
 * 
 * @param arraya The arrays to concatenate.
 * @return An array with all given arrays in the given order. 
 * 
 */ 
 
byte[] concatenate(byte[] ... arrays) 
{
  int inLenght = 0;  
  for (byte[] array : arrays) {
    inLenght += array.length;
  }

  byte[] retArray = new byte[inLenght];
  int indx = 0; 
  for (byte[] array : arrays) {
    System.arraycopy(array, 0, retArray, indx, array.length); 
    indx += array.length;
  }

  return retArray;
}

/**
 * 
 * returns a new array that is subarray of the given array. 
 * The subarray begins with the byte at the given index and 
 * extend to the end of the given array. 
 *
 * @param source The source array. 
 * @param srcBegin Starting position in the sourcing array.
 * qretunr The specified subarray. 
 *
 */ 
 byte[] skip (byte[] source, int srcBegin) {
   return subarray(source, srcBegin, source.length); 
 }
 
 /**
 * 
 * returns a new array that is subarray of the given array. 
 * The subarray begins at the specified srcBegin and 
 * extend to the array position at srcEnd -1. with the byte at the given index and 
 * extend to the end of the given array. 
 *
 * @param source The source array. 
 * @param srcBegin Starting position in the sourcing array.
 * @param srcEnd The ending index
 * @return The specified subarray. 
 *
 */ 
 byte[] subarray (byte[] source, int srcBegin, int srcEnd) {
   byte[] result = new byte[srcEnd - srcBegin];
   getBytes(source, srcBegin, srcEnd, result, 0); 
   return result; 
 }
 void getBytes(byte[] source, int srcBegin, int srcEnd, byte[] destination, int dstBegin) {
   System.arraycopy(source, srcBegin, destination, dstBegin, srcEnd - srcBegin); 
 }
 
