/*
Copyright (c) 2019,2020 f41ardu(at)arcor.de
 
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
// 03/01/2020 version 1.1  
// 
// udp receive handler and upd sender

void receive( byte[] data ) {          // <-- default handler
  //void MYreceive( byte[] data, String ip, int port ) {   // <-- extended handler
  received = ""; 
//  received = data.toString(); 

  for (int i=0; i < data.length; i++) {
    received+=char(data[i]); 
// Debug will be removed later
    if (debug) print(received);
  }
   
  receivedData = true;
}

void sendData() {
  if (input != "") { 
    // udp send require byteArray
    byte[] byteBuffer = input.getBytes();
    udp.send(byteBuffer, ip, port );   // the message to send
  }
}

void stayConnect() { 
    // udp send require byteArray
    byte[] byteBuffer = "command".getBytes();
    udp.send(byteBuffer, ip, port );   // the message to send
}
