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
module Tick_Gen_5ms(clk, rst, tick);

   input       clk, rst;   // on-board clock, and AISO reset signal
   output  wire    tick;   // slowed clock signal
   
   reg    [18:0]  count;   // count up from 0 to 499,999 (ie. 500,000)
   
   // Tick is HIGH if count reaches 500,000
   assign tick = (count == 19'd499999);

   always@(posedge clk, posedge rst) 
      if(rst)  count <= 19'b0;   else  // Reset
      if(tick) count <= 19'b0;         // Reset count after Tick
      else     count <= count+19'b1;   // count up

endmodule
