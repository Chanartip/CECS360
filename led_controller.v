`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
// Engineer:   Chanartip Soonthornwan                                          //
// Email:      Chanartip.Soonthornwan@gmail.com                                //
// Filename:   led_controller.v                                                //
// module:     led_controller                                                  //
// Date:       September 7, 2016                                               //
// Version:    1.0                                                             //
//                                                                             //
// Purpose:    A Finite State Machine to counting up from 00 to 11             //
//             then go back to 00 state, and generate 6 bit output             //
//             using for Anode selection and for segment selection             //
//                                                                             //
// Note:       This module is Moore type since there is no input to change     //
//             the behavior of the state machine.                              //
//                                                                             //
// Revision date: June 17, 2017                                                //
// Version      : 1.1                                                          //
// Update       : re-arrange comments and change some variables names.         //
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////
module led_controller(clk, reset, anode, seg_sel);

   input           clk, reset;               // On-board clock and reset signal
   output  reg  [1:0] seg_sel;               // Multiplexer selection
   output  reg  [3:0]   anode;               // Anode selection

   reg   [1:0] PresentState, NextState;      // State Registers
   
   // Next State Combination Logic
   // Move to the next state by one
   always @ (PresentState)
      case(PresentState)                     
         2'b00: NextState = 2'b01;           
         2'b01: NextState = 2'b10;  
         2'b10: NextState = 2'b11;
         2'b11: NextState = 2'b00;
         default: NextState = 2'b00;
      endcase
      
   // State Register
   always @ (posedge clk, posedge reset)
      if(reset == 1'b1)
         PresentState = 3'b00;               // Got reset signal
      else 
         PresentState = NextState;           // Update present state
   
   // Output Combination Logic
   always @ (PresentState)
      case(PresentState)                        
         2'b00: {anode, seg_sel} = 6'b1110_00;
         2'b01: {anode, seg_sel} = 6'b1101_01;
         2'b10: {anode, seg_sel} = 6'b1011_10;
         2'b11: {anode, seg_sel} = 6'b0111_11;
         default: {anode, seg_sel} = 6'b0000_00;
      endcase

endmodule
