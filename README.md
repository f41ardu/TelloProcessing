# Tello-Processing

## Introduction

This is the seed to a collection of Processing-based sample code that interact with the Ryze Tello drone.

If you are not familar with Processing check https://processing.org first. 

"Processing is a flexible software sketchbook and a language for 
learning how to code within the context of the visual arts."

This package is devloped on an Raspberry 3+.

## Project Description

You will find different sample programs based on the tello sdk Tello SDK Documentation EN_1.3_1122.pdf 
and Processing.  

We will start with a simple proof of concept. 

- **TelloTest**

 In TelloTest,You can send a couple of wellknow commands from the keyboar like command, takeoff, land, and so on.  

- **TelloVideoCapture** 
  
 Demonstrate to receive a video stream from a TELLO. (Raspberry PI only) 

- **TelloSDKVideo**

 Combine TelloTest and TelloVideoCapture (Raspberry PI only)

## Environmental configuration

 The sample code above is based on Processing 3.4. 
 Required Libraries: 

 UDP library for Processing http://www.ubaa.net/shared/processing/udp/

 OpenGL video playback for Processing https://github.com/gohai/processing-glvideo

 Specific to the content and description of each package, you can refer to the readme file in the related folder.

## Restriction

 Video streaming only available on Raspberry PI. UDP streaming
 support is not implemented in the Processing Standard Video library for PC and MAC. 

## Video information
                                                                                                                                                                                                               
   Final caps: video/x-raw(memory:GLMemory), width=(int)960, height=(int)720, 
   interlace-mode=(string)progressive, pixel-aspect-ratio=(fraction)1/1, 
   framerate=(fraction)0/1, format=(string)RGBA, texture-target=(string)2D, 
   colorimetry=(string)sRGB                                                                                                                                                                                  

## Contact Information

 If you have any questions about this sample code and the installation, please feel free to contact me. 
 Just contact me at https://tellopilots.com/members/f41ardu.5317/

