`timescale 1ns / 1ps
//*****************************************************************************//
//    This document contains information proprietary to the                    //
//    CSULB student that created the file - any reuse without                  //
//    adequate approval and documentation is prohibited                        //
//                                                                             //
//    Class:         CECS360 Integrated Circuits Design                        //
//    Project name:  Counter on 7-segment display                              //
//    File name:     Counter.v                                                 //
//                                                                             //
//    Created by Chanartip Soonthornwan on September 17, 2017.                 //
//    Copyright @ 2017 Chanartip Soonthornwan. All rights reserved.            //
//                                                                             //
//    Abstract:      A 16-bit counter counting up or down base on              //
//                   uphdl signal which HIGH means counting up and             //
//                   LOW means counting down, then return the couting          //
//                   number to 7-segment display                               //
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
module Counter(clk, rst, uphdl, pulse, count);

   input       clk, rst;  // on-board clock, and AISO reset signal
   input          uphdl;  // switch input(if HIGH, increment. if LOW, decrement)      
   input          pulse;  // one-shot signal from PED
   output [15:0]  count;  // 16-bit counter for hex in 7-segment display
   reg    [15:0]  count;
   
   always@(posedge clk, posedge rst)
      if(rst) count <= 16'h0;                     else   // Reset
      if(pulse &&  uphdl) count <= count + 16'h1; else   // Increment
      if(pulse && !uphdl) count <= count - 16'h1;        // Decrement
      else    count <= count;                            // No change

endmodule
