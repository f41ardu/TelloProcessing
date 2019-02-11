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
// 12/01/2019 version 0.3 (experimental)
// 
// udp receive handler

void receive( byte[] data ) {          // <-- default handler
  //void MYreceive( byte[] data, String ip, int port ) {   // <-- extended handler
  received = ""; 
  /* for (int i=0; i < data.length; i++) {
    received+=char(data[i]); 
// Debug will be removed later
    print(char(data[i]));
  } */ 
  received = new String(data);
  // Debug will be removed later
  receivedData = true;
 // println();
  println( "Sender receive: \""+received); 
}

// void receive( byte[] data ) {          // <-- default handler
void myownhandle( byte[] data, String ip, int port ) {   // <-- extended handler
  received = ""; 
  /* for (int i=0; i < data.length; i++) {
    received+=char(data[i]); 
// Debug will be removed later
    print(char(data[i]));
  } */ 
  received = new String(data);
  // Debug will be removed later
  receivedData = true;
 // println();
  println( "MyOwn Sender receive: \""+received); 
}
