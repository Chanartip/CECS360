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
