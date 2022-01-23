# FitNibble
This is an open-source repo of the codes and hardware schematics used in the FitNibble paper:
FitNibble: A Field Study to Evaluate the Utility and Usability of Automatic Diet Monitoring in Food Journaling using an Eyeglasses-based Wearable

### This repo contains:
1. Firmware: which runs on a Rigado 350 nRf52 BLE module. This code is responsible for sensor data acquisition and feature extraction.
2. HW Schematics: for BLE module boards and the proximity sensor (VCLN4040) breakout board.
3. iOS App: used to communicate with the BLE module and the server running real-time ML classification.
4. ML Pipeline: the pipeline used to build DNN eating detection models.
5. Server script: running real-time activity classification and collecting app activity data. 
6. Sensor visualization: A Processing script for real-time sensing data visualization  + firmware streaming sensors' data via the serial UART protocol. 
