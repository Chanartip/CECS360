`timescale 1ns / 1ps
//*****************************************************************************//
//    This document contains information proprietary to the                    //
//    CSULB student that created the file - any reuse without                  //
//    adequate approval and documentation is prohibited                        //
//                                                                             //
//    Class:         CECS360 Integrated Circuits Design                        //
//    Project name:  Counter on 7-segment display                              //
//    File name:     Debounce.v                                                //
//                                                                             //
//    Created by Chanartip Soonthornwan on September 17, 2017.                 //
//    Copyright @ 2017 Chanartip Soonthornwan. All rights reserved.            //
//                                                                             //
//    Abstract:      A finite state machine to wait for the input              //
//                   signal from mechanical switch or button to be             //
//                   stable around 30ms before output a confirm                //
//                   stable signal.                                            //
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
module Debounce(clk, rst, tick, db_in, db_out);

   input  wire clk, rst;        // on-board clock, and AISO reset signal
   input  wire     tick;        // 10ms clock signal from 10ms Tick Generator
   input  wire    db_in;        // input signal
   output wire   db_out;        // debounced output
   
   // State registers declaration
   reg           ps_out;        // Present state output
   reg           ns_out;        // Next state output
   reg  [2:0]  ps_state;        // Present state
   reg  [2:0]  ns_state;        // Next state
   
   // State names declaration
   // Named after Pong Chu's example on FSM Debounce(page 131)
   // (FPGA PROTOTYPING BY VERILOG EXAMPLES v.3, 2008)
   parameter [2:0]
             zero    = 3'b000,
             wait1_1 = 3'b001,
             wait1_2 = 3'b010,
             wait1_3 = 3'b011,
             one     = 3'b100,
             wait0_1 = 3'b101,
             wait0_2 = 3'b110,
             wait0_3 = 3'b111;
   
   /***********************************************
    *                Debounce FSM                 *
    ***********************************************/
   
   // State Register
   always@(posedge clk, posedge rst)       
      if(rst) {ps_state, ps_out} <= {zero, 1'b0}; 
      else    {ps_state, ps_out} <= {ns_state, ns_out};
   
   // Next state and Output logic
   always@(*)
      casez({ps_state, db_in, tick})
         // Low to High signal detecting states
         //    If input is HIGH for 3 ticks,
         //    present state will go to state 'one'
         {zero   , 2'b1_?}: {ns_state, ns_out} = {wait1_1, 1'b0};
         {wait1_1, 2'b1_1}: {ns_state, ns_out} = {wait1_2, 1'b0};
         {wait1_2, 2'b1_1}: {ns_state, ns_out} = {wait1_3, 1'b0};
         {wait1_3, 2'b1_1}: {ns_state, ns_out} = {    one, 1'b0};
         
         // High to Low signal detecting states
         //    If input is LOW for 3 ticks,
         //    present state will go back to 'zero'
         {one    , 2'b0_?}: {ns_state, ns_out} = {wait0_1, 1'b1};
         {wait0_1, 2'b0_1}: {ns_state, ns_out} = {wait0_2, 1'b1};
         {wait0_2, 2'b0_1}: {ns_state, ns_out} = {wait0_3, 1'b1};
         {wait0_3, 2'b0_1}: {ns_state, ns_out} = {   zero, 1'b1};
         
         // Default cases 
         5'b0??_0_?: {ns_state, ns_out} = {zero, 1'b0};     // back to zero when input is LOW
         5'b1??_1_?: {ns_state, ns_out} = {one,  1'b1};     // back to one when input is HIGH
         default : {ns_state, ns_out} = {ps_state, ps_out}; // stay the same state when !tick
      endcase 
   
   // change the debounced output name.
   assign db_out = ps_out;
   
endmodule
