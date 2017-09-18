`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
// Engineer:   Chanartip Soonthornwan                                          //
// Email:      Chanartip.Soonthornwan@gmail.com                                //
// Filename:   Mux4to1.v                                                       //
// module:     Mux4to1                                                         //
// Date:       September 7, 2016                                               //
// Version:    1.0                                                             //
//                                                                             //
// Purpose:    This module is a multiplexer selecting an one-bit output(Q)     //
//             based on selection input(sel)                                   //
//                                                                             //
// Note:       selction input selects output by:                               //
//                00 ----  D[3:0] will be selected.                            //
//                01 ----  D[7:4] will be selected.                            //
//                10 ----  D[11:8] will be selected.                           //
//                11 ----  D[15:12] will be selected.                          //
//             and output will be zero by default.                             //
//                                                                             //
// Revision date: June 8, 2017                                                 //
// Version      : 1.1                                                          //
// Update       : re-arrange the code and comment, and change variables' names.//
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////
module Mux4to1(D, sel, Q);

   input        [ 1:0] sel;          // Selection input
   input        [15:0]   D;          // 16-bit input
   output  reg  [ 3:0]   Q;          // an one-bit selected output

   always @ (D, sel) begin
   
      case(sel)               
         2'b00:   Q = D[3:0];       
         2'b01:   Q = D[7:4];
         2'b10:   Q = D[11:8];
         2'b11:   Q = D[15:12];
         default: Q = D[3:0];
      endcase
   
   end

endmodule
