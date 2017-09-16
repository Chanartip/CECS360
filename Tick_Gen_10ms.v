`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:52 09/12/2017 
// Design Name: 
// Module Name:    Tick_Gen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Tick_Gen_10ms(clk, rst, tick);

   input       clk, rst;   // on-board clock, and AISO reset signal
   output  wire    tick;   // slowed clock signal
   
   reg    [19:0]  count;   // count up from 0 to 999,999 (ie. 1 million)
   
   // Tick is HIGH if count reaches 1 million
   assign tick = (count == 20'd999999);

   always@(posedge clk, posedge rst)   
      if(rst)  count <= 20'b0;   else  // Reset
      if(tick) count <= 20'b0;         // Reset count after Tick
      else     count <= count+20'b1;   // count up

endmodule
