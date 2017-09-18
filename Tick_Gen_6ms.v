`timescale 1ns / 1ps
//*****************************************************************************//
//    This document contains information proprietary to the                    //
//    CSULB student that created the file - any reuse without                  //
//    adequate approval and documentation is prohibited                        //
//                                                                             //
//    Class:         CECS360 Integrated Circuits Design                        //
//    Project name:  Counter on 7-segment display                              //
//    File name:     Tick_Gen_6ms.v                                            //
//                                                                             //
//    Created by Chanartip Soonthornwan on September 17, 2017.                 //
//    Copyright @ 2017 Chanartip Soonthornwan. All rights reserved.            //
//                                                                             //
//    Abstract:       Generating 6 milliseconds clock from on-board            //
//                    clock(100MHz)                                            //
//                                                                             //
//    In submitting this file for class work at CSULB                          //
//    I am confirming that this is my work and the work                        //
//    of no one else.                                                          //
//                                                                             //
//    In the event other code sources are utilized I will                      //
//    document which portion of code and who is the author                     //
//                                                                             //
//    In submitting this code I acknowledge that plagiarism                    //
//    in student project work is subject to dismissal from the class           //
//                                                                             //
//*****************************************************************************//
module Tick_Gen_6ms(clk, rst, tick);

   input       clk, rst;   // on-board clock, and AISO reset signal
   output  wire    tick;   // slowed clock signal
   
   reg    [18:0]  count;   // count up from 0 to 599,999 (ie. 600,000)
   
   // Tick is HIGH if count reaches 600,000
   assign tick = (count == 19'd599999);

   always@(posedge clk, posedge rst) 
      if(rst)  count <= 19'b0;   else  // Reset
      if(tick) count <= 19'b0;         // Reset count after Tick
      else     count <= count+19'b1;   // count up

endmodule
