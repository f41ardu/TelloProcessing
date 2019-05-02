
/*
Copyright (c) 2019 f41ardu(at)arcor.de
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
//
// Simple UDP based Processing application for Tello  
// 
// 
// 12/01/2019 version 0.3 
// 

/* 
Video 
ffplay -probesize 32 -i udp://0.0.0.0:11111 -framerate 30
ffmpeg -i udp://0.0.0.0:11111 -f sdl "Tello"
*/

import hypermedia.net.*;

UDP udp;  // define UDP object one

// Tello UDP communication  
String ip       = "192.168.10.1";  // the fixed remote IP address
int port        = 8889;    // the destination port

int retry = 10; 
// Keyboard handling
String textBuffer = "command";
String input = textBuffer;
String output = ""; 
String received = ""; 
Boolean receivedData = false;

PFont font;

void setup() {
  size(640, 480);
  font = createFont("Sans Serif", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);

  // UDP setup using default handler receive
  udp = new UDP(this ,9000 );  // create a new datagram connection on port 6000
  // udp.setBuffer( 1518 );
  udp.log( true );     // <-- printout the connection activity
  udp.listen( true );           // and wait for incoming message

}

// Processing main loop
void draw() {
 
  background(0);
  // show help 
  text("Tello Processing Demo", 30, -140, width, height);
  text("Press <ENTER> to start", 30, -110, width, height);
  text("Tello command tested so far are:\ncommand takeoff land flip forward back left right", 30, -70, width, height);
  // show input 
  text("Tello:" + textBuffer, 30, 0, width, height);
  // show buffer send 
  text("Send:" + output, 30, 40, width, height);
  // show what Tello tell us 
  text("Received:" + received, 30, 80, width, height);

// send command as long as no response is received and input is not empty  
  if ( receivedData != true && input != "" ) { 
    sendData();   
  } else {
    // reset to input and receivedData to accept new command
    input =""; 
    receivedData = false;
  } 
}

void sendData() {
  if (input != "") { 
    // udp send require byteArray
    byte[] byteBuffer = input.getBytes();
    udp.send(byteBuffer, ip, port );   // the message to send
  }
}
