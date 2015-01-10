# sc-robonova-archive
A resource area for the Hitec Robonova RN-1 humanoid robot


## Index

 - 01_robobasic_v2.5 ..... the original software suite that was supplied with Robonova. It includes RoboBASIC, RoboMaker, RoboRemocon and RoboScript.

 - 02_robobasic_v2.72 ..... if you are upgrading from RoboBASIC v2.5 then the first time you perform a download using v2.72, it will ask if you want to upgrade the MR-C3024 firmware. This new firmware supports both EEPROM and flash storage of the code. A new controller type will appear in the menu: MR-C3024F. You can then determine whether subsequent downloads will go to EEPROM or flash by selecting either the MR-C3024 or the MR-C3024F options.

 - 03_roboBASIC+MF+v2.80K ..... I'll include this for completeness but I'm not sure if it has any advantages over v2.72. It is the version of RoboBASIC for a robot called Metal Fighter, but this appears to just be a reincarnation of Robonova.

 - 04_images ..... some images and circuit diagrams.

 - 05_c3024i2c ..... this is a revised firmware from i-Bot that adds a second I2C port on the C3024 board. 

 - 06_c3024ozz ..... hopefully you'll never need this one! It is a special firmware written for me by i-Bot to rescue my Robonova when I managed to put a looping program into flash and make the robot unusable.

 - 07_roboflash ..... to reflash the firmware with a revised code you will need to use this small program.

 - 08_fix ..... this is a batch file you will need to use for Windows 7 compability of RoboBASIC v2.72. Right click on fix.bat and choose "Run as administrator". It should go through a series of steps with no errors. Now right click the Robobasic program icon and select the "Troubleshoot compatability" option. Select "Try recommended settings" and this will open RoboBASIC with Windows XP settings. This should now run properly and if you follow through the steps it will save the settings and remember them for next time. Note, the program does take a quite a few seconds to open so be patient! 

 - 09_windows_vista_7_fix ..... a similar fix file that was made available at minirobot.co.kr, but their version includes an extra line for CMCS21.OCX registration. Note that this download has both 32 bit and 64 bit versions of the files.

 - 10_mech-puppeter ..... MECH Puppeteer is a small application written by Matt Bauer that was intended to be used simply as a testing tool in relation to a bluetooth module. Its capabilities are similar to the Remocon software supplied with the Robonova.

 - 11_simrobot ..... SimROBOT for Robonova - I haven't really explored the capabilities of this software but it does have a really cool Robonova "assistant" that can run all over your screen. Right click on him to view the menu and start the program.

###### These are some of the files that came with the original disk that was supplied with Robonova RN-1:

 - 12_template_program_for_robobasic ..... Template program for RoboBASIC

 - 13_robobasic_instruction_manual ..... roboBASIC Command Instruction Manual V2.10

 - 14_user_manual ..... ROBONOVA-I User Manual V1.00

###### Below are various RoboBASIC program files. They have been collected from different sources and may not have been tested by me, so no guarantees:

 - 15_movement_templates ..... movement templates - a collection of various movement routines.

 - 16_walking_with_distance_sensor ..... this is my modification to allow independent walking using a 'head' made from a Sharp distance sensor mounted onto a servo.

 - 17_walker ..... a different "walking with sensor" program that I found after I had done mine. It's probably better.

 - 18_compass ..... compass is the I2C routine for the CMPS03 compass module.

 - 19_vrbot ..... this is the initial code to support the VRbot voice recognition module from Veear. Modify as required.

 - 20_sp03 ..... the code for the Devantech SP03 Speech Synthesizer module

 - 21_wireless_controller ..... 2.4GHz Wireless Controller Template

 - 22_bluetooth ..... these are the files and documents to support the Robonova Bluetooth module. It includes a RoboBASIC template that should work with the Multiplex unit. Some modifications may be required for other brands.

 - 23_rc_template ..... 4 Channel R/C Receiver and Transmitter - this is a RoboBASIC template and associated documentation that shows how to control Robonova with a four channel R/C receiver and transmitter

