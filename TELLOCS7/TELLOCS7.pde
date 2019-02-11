//

import hypermedia.net.*;

ReceiverThread telloThread;
FlightData flightData;

// String ip       = "localhost";  // the fixed remote IP address
String ip       = "192.168.10.1";
int port        = 8889;    // the destination port
String received = "";
byte[] bytesIn = new byte[65507]; 

boolean connected = false; 
color fillVal = color(126);

UDP udp;  // define UDP object one
Tello myTello; 
PFont font; 
int cmdID; 

void setup() {
  size(400, 300);  
  font = createFont("Arial", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);
  udp = new UDP(this, 9000 );  // create a new datagram connection on port 6000
 // udp.setBuffer( 1518 );
  udp.log( false );     // <-- printout the connection activity
  udp.listen( true );           // and wait for incoming message

  myTello = new Tello();
  udp.send(myTello.connect(), ip, port );
  flightData = new FlightData();
}


void draw() {



  //    packet[5] = (byte)(height & 0xff);
  //    packet[6] = (byte)((height >>8) & 0xff);
  if (received != "") {
    if ( received.contains("conn_ack") ) {
      println("Received conn_ack"); 
      connected = true;
    }
    received = "OK -> " + received;
  }
 
  cmdID = ((int)bytesIn[5] & 0xff) | ((int)bytesIn[6] << 8); 
  println(cmdID); 
  if (connected) {
    if (cmdID == 86) {
      
      flightData.set(bytesIn);

      println(flightData.droneBatteryLeft);
      println(flightData.batteryPercentage);
      println(flightData.qheight);
      saveBytes("flightdata.dat", bytesIn);
    } else { 
      println("....");
    }
  }





  // Draw the image
  background(0);
  fill(fillVal);
  rect(20, 20, 50, 50);
  text("Received:" + received, 30, 80, width, height);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      fillVal = color(255, 0, 0);
      udp.send(myTello.takeOff(), ip, port );
      saveBytes("takeoff.dat", myTello.takeOff());
    } else if (keyCode == DOWN) {
      fillVal = color(0, 255, 0);
      udp.send(myTello.land(), ip, port );
      saveBytes("land.dat", myTello.land());
    }
  } else {
    fillVal = 126;
  }
}

void receive( byte[] data ) {          // <-- default handler
  //void MYreceive( byte[] data, String ip, int port ) {   // <-- extended handler
  received= new String(data);
  bytesIn = data;
  
}
