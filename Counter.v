`timescale 1ns / 1ps
/* ********************************* CECS 360 *********************************
 *    Name:       Chanartip Soonthornwan
 *    Email:      Chanartip.Soonthornwan@gmail.com
 *    Filename:   
 *    Date:       September 8, 2017
 *    Purpose:
 *
 *
 *    Note:
 *
 *    Version:     1.0     Rev date: 9/8/2017
 *
 * ****************************************************************************/
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
