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
// 12/01/2019 version 0.5.1 
// 

// New Tello object  
JTello myTello = new JTello();

// Keyboard handling
String textBuffer = "";
String input = textBuffer;
String output = ""; 
String received = ""; 

PFont font;

void setup() {
  size(640, 480);
  font = createFont("Sans Serif", 40);
  textFont(font, 20);
  textAlign(LEFT, CENTER);
  myTello.connect(); 
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
  received = myTello.sendCommand(input); 
  text("Received:" + received, 30, 300, width, height);

  
}
