// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images


String ip       = "localhost";  // the fixed remote IP address
int sendtoport        = 9000;    // the destination port

myUDP myUDP; 

String received = ""; 
String newreceived = ""; 
String returned = ""; 
PFont font; 
int i = 0; 
void setup() {
  size(400, 300);  
  font = createFont("Arial", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);
  myUDP = new myUDP(this, "localhost", 8889 );
  myUDP.setReceiveHandler("myreceiver");
}

void draw() {
  

  if (received != "") {
    i++; 
    returned = i + " OK -> " + received;
    newreceived = received; 
    myUDP.send(returned.getBytes(), ip, sendtoport );
    
  }

  // Draw the image
  background(0);
  text("Received:" + newreceived, 30, 80, width, height);
  received = ""; 
}

 void myreceiver( byte[] data, String ip, int port) { // <– default handler
    {
     
      //void MYreceive( byte[] data, String ip, int port ) {   // <-- extended handler
      received= new String(data);
      println("handle 1: "+ received +" "+ ip + " " + " " + port);
    }
  }
