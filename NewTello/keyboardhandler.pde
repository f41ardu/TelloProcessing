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
// simple keyboard inport handler

void keyPressed() {

  if (keyCode == BACKSPACE) {
    if (textBuffer.length() > 0) {
      textBuffer = textBuffer.substring(0, textBuffer.length()-1);
    }
  } else if (keyCode == DELETE) {
    textBuffer = "";
  } else if (keyCode != SHIFT) {
    textBuffer = textBuffer + (key) ;
  }
  
  if (keyCode == ' ') {
   textBuffer = textBuffer.substring(0, textBuffer.length()-1);
   textBuffer = textBuffer + ' ';
   }  

  if (keyCode == ENTER) {
    // remove CR
    output = input = textBuffer = textBuffer.substring(0, textBuffer.length()-1);
    textBuffer = "";
  }
}
