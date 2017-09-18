`timescale 1ns / 1ps
//*****************************************************************************//
//    This document contains information proprietary to the                    //
//    CSULB student that created the file - any reuse without                  //
//    adequate approval and documentation is prohibited                        //
//                                                                             //
//    Class:         CECS360 Integrated Circuits Design                        //
//    Project name:  Counter on 7-segment display                              //
//    File name:     SSG_Driver.v                                              //
//                                                                             //
//    Created by Chanartip Soonthornwan on September 17, 2017.                 //
//    Copyright @ 2017 Chanartip Soonthornwan. All rights reserved.            //
//                                                                             //
//    Abstract:      The top level of 7-segment display on Nexys3              //
//                   displays interconnection between modules.                 //
//                   Receiving 16-bit input(Count) then LED_control            //
//                   will select which anode to display and which              //
//                   part of Count to Multiplexer, then Multiplexer            //
//                   choose bits on Count to convert into 7-bit hex            //
//                   output at hex_to7segment before output to on board        //
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
module SSG_Driver(clk, rst, count, anode, sseg);

   input         clk, rst;                // 200Hz clock and reset signal
   input  [15:0]    count;                // 16-bit data input
   output [ 3:0]    anode;                // anode selected output
   output [ 6:0]     sseg;                // 7-segment selected output
   
   wire   [ 1:0]  mux_sel;                // multiplex 4-bit from count selection
   wire   [ 3:0]      hex;                // 4-bit from mux to decode to 7-seg
   
   // 4 to 7 bit hex decoder
   //    Recieves 4 bit input in binary from Mux4to1
   //    and converts to 7-bit output for displaying
   //    on 7-segment display
   hex_to7segment ssg0 (.hex(hex),        // 4-bit data input
                        .sseg(sseg)       // 7-bit output represent each segment
                        );
                        
   // LED controler
   //    A finite state machine(FSM) to select
   //    an Anode to display and what segment 
   //    7-segment of each anode to display
   led_controller ssg1(.clk(clk),         // 200Hz clock
                       .reset(rst),       // AISO reset
                       .anode(anode),     // Selected anode output
                       .seg_sel(mux_sel)  // Selected 4-bit to convert
                       );
                       
   // 4 to 1 Multiplexer         
   //    Selecting which 4-bit input from count
   //    to be converted and display on 7-segment
   Mux4to1 ssg2 (.D(count),               // 16-bit input
                 .sel(mux_sel),           // input selection
                 .Q(hex)                  // 7-bit output for 7-segment display
                 );
endmodule
