// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images


String ip       = "localhost";  // the fixed remote IP address
int sendtoport        = 9000;    // the destination port

ReceiverThread thread;
// ReceiverThread thread2;
int i = 0; 
String received = ""; 
String returned = ""; 
PFont font; 

void setup() {
  size(400, 300);  
  font = createFont("Arial", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);
  thread = new ReceiverThread();
  thread.start();
}

void draw() {
  if (thread.available()) {
    received = "";
    received = thread.getData();
    if (received != "") {
      i++; 
      returned = i + " OK -> " + received;
      //received = "OK"; 
      thread.send(returned.getBytes(), ip, sendtoport );
    }
  }

  // Draw the image
  background(0);
  text("Received:" + received, 30, 80, width, height);
}
