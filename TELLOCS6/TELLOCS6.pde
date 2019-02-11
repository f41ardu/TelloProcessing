//
ReceiverThread telloThread;
FlightData flightData;

// String ip       = "localhost";  // the fixed remote IP address
String ip       = "192.168.10.1";
int port        = 8889;    // the destination port
String received = "";
byte[] bytesIn = new byte[2048]; 
boolean connected = false; 
color fillVal = color(126);

Tello myTello; 
PFont font; 
int cmdID; 

void setup() {
  size(400, 300);  
  font = createFont("Arial", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);
  telloThread = new ReceiverThread();


  telloThread.start();

  myTello = new Tello();
  telloThread.send(myTello.connect(), ip, port );
  flightData = new FlightData();
}


void draw() {


  if (telloThread.available()) {
    received = "";

    received = telloThread.getData();
    bytesIn = telloThread.getBytes();
    //    packet[5] = (byte)(height & 0xff);
    //    packet[6] = (byte)((height >>8) & 0xff);
    cmdID = ((int)bytesIn[5] & 0xff) | ((int)bytesIn[6] << 8); 
   // println(cmdID); 
    if (connected) {
      if (cmdID == 86) {
        flightData.set(bytesIn);
         println(flightData.droneBatteryLeft);
          println(flightData.batteryPercentage);
           println(flightData.qheight);
      } else { 
        println("....");
      } }
      if (received != "") {
        if ( received.contains("conn_ack") ) {
          println("Received conn_ack"); 
          connected = true;
        }
        received = "OK -> " + received;
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
        //   telloThread.send(myTello.takeOff(), ip, port );
      } else if (keyCode == DOWN) {
        fillVal = color(0, 255, 0);
        //   telloThread.send(myTello.land(), ip, port );
      }
    } else {
      fillVal = 126;
    }
  }
