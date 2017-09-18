`timescale 1ns / 1ps
//*****************************************************************************//
//    This document contains information proprietary to the                    //
//    CSULB student that created the file - any reuse without                  //
//    adequate approval and documentation is prohibited                        //
//                                                                             //
//    Class:         CECS360 Integrated Circuits Design                        //
//    Project name:  Counter on 7-segment display                              //
//    File name:     PED.v                                                     //
//                                                                             //
//    Created by Chanartip Soonthornwan on September 17, 2017.                 //
//    Copyright @ 2017 Chanartip Soonthornwan. All rights reserved.            //
//                                                                             //
//    Abstract:      A module to detect Positive Edge input then               //
//                   returns one-shot pulse output.                            //
//                   If the input is HIGH at the first clock and               //
//                   second clock period, PED would detect this                //
//                   and output HIGH for one clock period.                     //
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
module PED(clk, rst, d_in, pulse);

   input       clk, rst;                // on-board clock, and AISO reset signal
   input           d_in;                // input signal
   output  wire   pulse;                // one-shot pulse 

   reg            q1,q2;                // registers
   
   always@(posedge clk, posedge rst)
      if(rst)  {q1, q2} <= 2'b0;        // reset
      else     {q1, q2} <= {d_in, q1};  // q2 gets q1, and q1 get new signal
               
   // output at the moment of input change
   // q1    ____------------_________
   // q2    ________------------_____
   // pulse ____----_________________
   assign   pulse = q1 & ~q2;           
   
   
endmodule
