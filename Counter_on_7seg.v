`timescale 1ns / 1ps
//*****************************************************************************//
//    This document contains information proprietary to the                    //
//    CSULB student that created the file - any reuse without                  //
//    adequate approval and documentation is prohibited                        //
//                                                                             //
//    Class:         CECS360 Integrated Circuits Design                        //
//    Project name:  Counter on 7-segment display                              //
//    File name:     Counter_on_7seg.v                                         //
//                                                                             //
//    Created by Chanartip Soonthornwan on September 17, 2017.                 //
//    Copyright @ 2017 Chanartip Soonthornwan. All rights reserved.            //
//                                                                             //
//    Abstract:   Demonstrates a 16-bit counter that counts up or down         //
//                according to a switch(SW), which HIGH represents             //
//                counting up and LOW represents counting down, and step       //
//                button that will execute the code from SW, and then          //
//                displays the current values on 7-segment display.            //
//                As the top level of the entire project, showing              //
//                all wires and connections between modules.                   //
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
module Counter_on_7seg(clk, rst, step, SW, ANODE, SSEG);

   input      clk, rst;        // Nexys3 on-board clock and reset signal (BTNU)
   input          step;        // button input for stepping on Counter
   input            SW;        // switch input (SW0) selecting count up or down
   output [3:0]  ANODE;        // Anode on 7-segment display
   output [6:0]   SSEG;        // each segment on 7-segment display

   wire          rst_s;        // AISO reset signal
   wire           tick;        // Reduced clock frequency
   wire             db;        // debounce tick to pulse maker
   wire          pulse;        // one shot pulse signal for Counter
   wire  [15:0]  count;        // output to display on sseg

   // 7-segment Display for Counter
   //    Display counting number on 7-segment display
   SSG_Driver u0 (.clk(tick_6ms),               // 6ms clock(167Hz)
                  .rst(rst_s),                  // AISO reset
                  .count(count),                // 16-bit Input from Counter
                  .anode(ANODE),                // Anode to display
                  .sseg(SSEG)                   // segment to display
                  );
   
   // Up or Down counter
   //    Receive signal from Switch(SW) to count up
   //    or count down. If SW is HIGH, count up.
   //    If SW is LOW, count down.
   //    The counter will count when it gets pulse
   Counter u1 (.clk(clk),                       // On-board clock(100MHz)
               .rst(rst_s),                     // AISO reset
               .uphdl(SW),                      // Switch input
               .pulse(pulse),                   // PED signal 
               .count(count)                    // output to 7-seg display
               );
                   
   // Positive Edge signal Detector(PED)
   //    Receive debounced signal and create
   //    a one short pulse to Counter
   //    as its clock.
   PED u2 (.clk(clk),                           // On-board clock(100MHz)
           .rst(rst_s),                         // AISO reset
           .d_in(db),                           // debounced signal input
           .pulse(pulse)                        // PED signal to Counter
           );
           
   // switch Debouncing
   //    Debouncing input signal from a mechanical input
   //    that might not stable during initiation to 20~30ms,
   //    then outputs stable output(either HIGH or LOW) to PED
   Debounce u3 (.clk(clk),                      // On-board clock(100MHz)
                .rst(rst_s),                    // AISO reset
                .tick(tick_10ms),               // Slowed clock(10ms)
                .db_in(step),                   // Input signal from button
                .db_out(db)                     // Debounced signal
                );
           
   // Clock divider 
   //    slow on-board clock period 
   //    down for specific purpose
   // 200Hz clock(5ms) for 7-segment display
   Tick_Gen_6ms  u4 (.clk(clk),                 // On-board clock(100MHz)
                     .rst(rst_s),               // AISO reset
                     .tick(tick_6ms)            // clock to 7-segment display
                     );
   // 10ms Tick generator for Debounce module
   Tick_Gen_10ms u5 (.clk(clk),                 // On-board clock(100MHz)
                     .rst(rst_s),               // AISO reset
                     .tick(tick_10ms)           // clock to Debounce
                     );
                     
   // Asynchronized-In Synchronized-Out Reset Signal
   //    Receive reset signal output from on-board button
   //    then distributes synchronized reset signal to
   //    other modules at the rising edge of the on-board clock
   AISO_rst u6 (.clk(clk),                      // On-board clock(100MHz)
                .rst(rst),                      // On-board reset button
                .rst_s(rst_s)                   // Synconized reset signal
                );
   

endmodule
