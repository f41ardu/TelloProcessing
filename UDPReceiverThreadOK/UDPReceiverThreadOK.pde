// Daniel Shiffman
// <http://www.shiffman.net>

// A Thread using receiving UDP to receive images


String ip       = "192.168.2.111";  // the fixed remote IP address
int sendtoport        = 9000;    // the destination port

ReceiverThread thread;
ReceiverThread thread2;

String received =""; 
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
      //received = "OK -> " + received;
      //received = "OK"; 
      thread.send("OK".getBytes(), ip, sendtoport );
    }
  }

  // Draw the image
  background(0);
  text("Received:" + received, 30, 80, width, height);
}
